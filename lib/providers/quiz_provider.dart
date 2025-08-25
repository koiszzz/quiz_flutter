import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:quiz_flutter/providers/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/services/database_helper.dart';

part 'quiz_provider.g.dart';

@immutable
class QuizConfig {
  final int? bankId;
  final String mode;
  final int single;
  final int multiple;
  final int trueFalse;
  final int duration;
  final bool shuffleQuestions;
  final bool shuffleOptions;
  final bool withoutTaken;

  const QuizConfig({
    this.bankId,
    required this.mode,
    this.single = 0,
    this.multiple = 0,
    this.trueFalse = 0,
    this.duration = 0,
    this.shuffleQuestions = false,
    this.shuffleOptions = false,
    this.withoutTaken = false,
  });
}

@immutable
class QuizState {
  final List<Question> questions;
  final Map<int, dynamic> userAnswers;
  final int currentIndex;
  final bool quizFinished;
  final bool showAnswer;
  final DateTime startTime;
  final Duration remainingTime;
  final QuizConfig quizConfig;

  const QuizState({
    this.questions = const [],
    this.userAnswers = const {},
    this.currentIndex = 0,
    this.quizFinished = false,
    this.showAnswer = false,
    required this.startTime,
    required this.remainingTime,
    required this.quizConfig,
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
    bool? showAnswer,
    Duration? remainingTime,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      userAnswers: userAnswers ?? this.userAnswers,
      currentIndex: currentIndex ?? this.currentIndex,
      quizFinished: quizFinished ?? this.quizFinished,
      showAnswer: showAnswer ?? this.showAnswer,
      startTime: startTime,
      remainingTime: remainingTime ?? this.remainingTime,
      quizConfig: quizConfig,
    );
  }
}

@riverpod
class QuizList extends _$QuizList {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  Timer? _timer;

  @override
  Future<QuizState> build(QuizConfig config) async {
    ref.onDispose(() => _timer?.cancel());

    final questions = await _loadQuestions(config);
    final systemSettings = ref.read(settingsProvider);

    if (config.mode == 'exam') {
      _timer = Timer.periodic(const Duration(seconds: 1), _tick);
    }

    return QuizState(
      questions: questions,
      showAnswer: config.mode == 'practice'
          ? systemSettings['showAnswer']
          : false,
      startTime: DateTime.now(),
      remainingTime: Duration(minutes: config.duration),
      quizConfig: config,
    );
  }

  void _tick(Timer timer) {
    if (state.value == null) return;
    final newTime = state.value!.remainingTime - const Duration(seconds: 1);
    if (newTime.inSeconds <= 0) {
      timer.cancel();
      finishQuiz();
    } else {
      state = AsyncValue.data(state.value!.copyWith(remainingTime: newTime));
    }
  }

  Future<List<Question>> _loadQuestions(QuizConfig config) async {
    final List<Question> allQuestions = await _dbHelper.getQuestionsByBank(
      bankId: config.bankId!,
      withFavorites: config.mode == 'favorites',
      withoutTaken: config.withoutTaken,
    );
    List<Question> single = allQuestions.where((q) => q.type == '单选').toList();
    List<Question> multiple = allQuestions
        .where((q) => q.type == '多选')
        .toList();
    List<Question> trueFalse = allQuestions
        .where((q) => q.type == '判断')
        .toList();

    if (config.shuffleQuestions) {
      single.shuffle();
      multiple.shuffle();
      trueFalse.shuffle();
    }

    final selectedQuestions = [
      ...single.take(config.single),
      ...multiple.take(config.multiple),
      ...trueFalse.take(config.trueFalse),
    ];
    if (config.shuffleOptions) {
      final List<Question> shuffleds = [];
      for (final question in selectedQuestions) {
        if (question.type == '判断') {
          shuffleds.add(question); // No options to shuffle for true/false
          continue;
        }
        final originalOptions = jsonDecode(question.options) as List;
        final originalAnswer = jsonDecode(question.answer);
        final List<int> newIndices = List<int>.generate(
          originalOptions.length,
          (i) => i,
        )..shuffle();
        final shuffledOptions = newIndices
            .map((i) => originalOptions[i])
            .toList();
        dynamic shuffledAnswer;
        if (question.type == '单选') {
          final originalAnswer = jsonDecode(question.answer);
          shuffledAnswer = newIndices[originalAnswer];
        } else if (question.type == '多选') {
          shuffledAnswer = [for (final fi in newIndices) originalAnswer[fi]];
        }
        shuffleds.add(
          question.copyWith(
            options: jsonEncode(shuffledOptions),
            answer: jsonEncode(shuffledAnswer),
          ),
        );
      }
      return shuffleds;
    }
    return selectedQuestions;
  }

  void answerQuestion(int questionId, dynamic answer) {
    final newAnswers = Map<int, dynamic>.from(state.value!.userAnswers);
    newAnswers[questionId] = answer;
    state = AsyncValue.data(state.value!.copyWith(userAnswers: newAnswers));
  }

  void preQuestion() {
    if (state.value!.currentIndex > 0) {
      state = AsyncValue.data(
        state.value!.copyWith(currentIndex: state.value!.currentIndex - 1),
      );
    }
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

  Future<void> toggleCurrentFav() async {
    final currentQuestion = state.value?.currentQuestion;
    if (currentQuestion != null) {
      final isFavorite = !currentQuestion.isFavorite;
      state = AsyncValue.data(
        state.value!.copyWith(
          questions: state.value!.questions.map((question) {
            return question.id == currentQuestion.id
                ? question.copyWith(isFavorite: isFavorite)
                : question;
          }).toList(),
        ),
      );
      await _dbHelper.updateQuestion(
        currentQuestion.copyWith(isFavorite: isFavorite),
      );
    }
  }

  void toggleShowAnswer() {
    state = AsyncValue.data(
      state.value!.copyWith(showAnswer: !state.value!.showAnswer),
    );
  }

  Future<void> finishQuiz() async {
    if (state.value?.quizFinished ?? true) return;
    _timer?.cancel();
    state = AsyncValue.data(state.value!.copyWith(quizFinished: true));
    await _saveRecords();
  }

  Future<void> _saveRecords() async {
    final currentState = state.value;
    if (currentState == null) return;
    String userAnswersJson = '{';
    currentState.userAnswers.forEach((key, value) {
      userAnswersJson += '"$key": "${value.toString()}",';
    });
    userAnswersJson =
        '${userAnswersJson.substring(0, userAnswersJson.length - 1)}}';

    for (final Question q in currentState.questions) {
      final questionUpdate = q.copyWith(
        takingTimes: q.takingTimes + 1,
        lastTakenAt: DateTime.now(),
        uncorrectTimes:
            (currentState.userAnswers[q.id] != null &&
                !_isCorrect(q, currentState.userAnswers[q.id]))
            ? q.uncorrectTimes + 1
            : q.uncorrectTimes,
      );
      await _dbHelper.updateQuestion(questionUpdate);
    }
    final record = QuizRecord(
      bankId: currentState.quizConfig.bankId!,
      mode: currentState.quizConfig.mode,
      score: getScore(),
      duration: (DateTime.now().difference(currentState.startTime)).inSeconds,
      answers: userAnswersJson,
      timestamp: DateTime.now(),
    );
    await _dbHelper.insertRecord(record);
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
