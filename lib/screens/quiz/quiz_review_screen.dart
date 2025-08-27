import 'package:flutter/material.dart';
import 'package:quiz_flutter/l10n/app_localizations.dart';
import 'package:quiz_flutter/models/models.dart';
import 'dart:convert';

class QuizReviewScreen extends StatelessWidget {
  final List<Question> questions;
  final Map<int, dynamic> userAnswers;

  const QuizReviewScreen({
    super.key,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final wrongQuestions = questions.where((q) {
      final userAnswer = userAnswers[q.id];
      return userAnswer != null && !_isCorrect(q, userAnswer);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.quizReviewTitle),
      ),
      body: wrongQuestions.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.allCorrectMsg))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: wrongQuestions.length,
              itemBuilder: (context, index) {
                final question = wrongQuestions[index];
                final userAnswer = userAnswers[question.id];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.question} ${index + 1}: ${question.content}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildOptionsReview(context, question, userAnswer),
                        if (question.explanation != null &&
                            question.explanation!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          const Divider(),
                          Text(
                            '${AppLocalizations.of(context)!.analysisLabel}: ',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(question.explanation!),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  bool _isCorrect(Question question, dynamic userAnswer) {
    try {
      final correctAnswer = jsonDecode(question.answer);
      if (question.type == 'single' || question.type == 'judge') {
        return userAnswer == correctAnswer;
      } else if (question.type == 'multiple') {
        if (userAnswer is! List || correctAnswer is! List) return false;
        if (userAnswer.length != correctAnswer.length) return false;
        for (int i = 0; i < userAnswer.length; i++) {
          if (userAnswer[i] != correctAnswer[i]) return false;
        }
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Widget _buildOptionsReview(
    BuildContext context,
    Question question,
    dynamic userAnswer,
  ) {
    final options = jsonDecode(question.options) as List;
    final correctAnswer = jsonDecode(question.answer);
    const optionPrefix = 'ABCDEFGHIJK';

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final optionText = '${optionPrefix[index]}: ${options[index]}';
        bool isCorrect = false;
        bool isUserChoice = false;

        if (question.type == 'single' || question.type == 'judge') {
          isCorrect = (index == correctAnswer);
          isUserChoice = (index == userAnswer);
        } else if (question.type == 'multiple') {
          isCorrect = correctAnswer[index];
          isUserChoice = userAnswer[index];
        }

        return Card(
          color: isCorrect
              ? Colors.green[300]
              : (isUserChoice ? Colors.red[300] : null),
          child: ListTile(
            title: Text(optionText),
            trailing: isCorrect
                ? const Icon(Icons.check_circle, color: Colors.green)
                : (isUserChoice
                      ? const Icon(Icons.cancel, color: Colors.red)
                      : null),
          ),
        );
      },
    );
  }
}
