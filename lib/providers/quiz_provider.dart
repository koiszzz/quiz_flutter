import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/services/database_helper.dart';

part 'quiz_provider.g.dart';

@immutable
class QuizState {
  final List<Question> questions;
  final Map<int, dynamic> userAnswers;
  final int currentIndex;
  final bool quizFinished;

  const QuizState({
    this.questions = const [],
    this.userAnswers = const {},
    this.currentIndex = 0,
    this.quizFinished = false,
  });

  Question? get currentQuestion =>
      questions.isNotEmpty && currentIndex < questions.length
      ? questions[currentIndex]
      : null;

  QuizState copyWith({
    List<Question>? questions,
    Map<int, dynamic>? userAnswers,
    int? currentIndex,
    bool? quizFinished,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      userAnswers: userAnswers ?? this.userAnswers,
      currentIndex: currentIndex ?? this.currentIndex,
      quizFinished: quizFinished ?? this.quizFinished,
    );
  }
}

@riverpod
class QuizList extends _$QuizList {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  late final String _mode;

  @override
  Future<QuizState> build({int? bankId, required String mode}) async {
    _mode = mode;
    final questions = await _loadQuestions(bankId: bankId, mode: mode);
    return QuizState(questions: questions);
  }

  Future<List<Question>> _loadQuestions({
    int? bankId,
    required String mode,
  }) async {
    if (mode == 'favorites') {
      final favoriteIds = (await _dbHelper.getAllFavorites())
          .map((f) => f.questionId)
          .toList();
      if (favoriteIds.isNotEmpty) {
        return _dbHelper.getQuestionsByIds(favoriteIds);
      }
      return [];
    } else if (bankId != null) {
      return _dbHelper.getQuestionsByBank(bankId);
    }
    return [];
  }

  void answerQuestion(int questionId, dynamic answer) {
    final newAnswers = Map<int, dynamic>.from(state.value!.userAnswers);
    newAnswers[questionId] = answer;
    state = AsyncValue.data(state.value!.copyWith(userAnswers: newAnswers));
  }

  void nextQuestion() {
    if (state.value!.currentIndex < state.value!.questions.length - 1) {
      state = AsyncValue.data(
        state.value!.copyWith(currentIndex: state.value!.currentIndex + 1),
      );
    } else {
      finishQuiz();
    }
  }

  Future<void> finishQuiz() async {
    if (state.value?.quizFinished ?? true) return;

    state = AsyncValue.data(state.value!.copyWith(quizFinished: true));
    await _saveRecords();
  }

  Future<void> _saveRecords() async {
    final currentState = state.value;
    if (currentState == null) return;

    for (var question in currentState.questions) {
      final userAnswer = currentState.userAnswers[question.id!];
      if (userAnswer != null) {
        final isCorrect = _isCorrect(question, userAnswer);
        final record = QuizRecord(
          questionId: question.id!,
          userAnswer: jsonEncode(userAnswer),
          isCorrect: isCorrect,
          timestamp: DateTime.now(),
          mode: _mode,
        );
        await _dbHelper.insertRecord(record);
      }
    }
  }

  bool _isCorrect(Question question, dynamic userAnswer) {
    try {
      final correctAnswer = jsonDecode(question.answer);
      if (question.type == '单选' || question.type == '判断') {
        return userAnswer == correctAnswer;
      } else if (question.type == '多选') {
        if (userAnswer is! List || correctAnswer is! List) return false;
        return listEquals(userAnswer, correctAnswer);
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  int getScore() {
    int correctCount = 0;
    final currentState = state.value;
    if (currentState == null) return 0;

    for (var question in currentState.questions) {
      if (_isCorrect(question, currentState.userAnswers[question.id])) {
        correctCount++;
      }
    }
    return correctCount;
  }
}
