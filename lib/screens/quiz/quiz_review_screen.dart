
import 'package:flutter/material.dart';
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
        title: const Text('错题回顾'),
      ),
      body: wrongQuestions.isEmpty
          ? const Center(
              child: Text('恭喜你，全部回答正确！'),
            )
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
                          '题目 ${index + 1}: ${question.content}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildOptionsReview(context, question, userAnswer),
                        if (question.explanation != null &&
                            question.explanation!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          const Divider(),
                          Text('解析: ', style: Theme.of(context).textTheme.titleLarge),
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
      if (question.type == '单选' || question.type == '判断') {
        return userAnswer == correctAnswer;
      } else if (question.type == '多选') {
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
      BuildContext context, Question question, dynamic userAnswer) {
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

        if (question.type == '单选' || question.type == '判断') {
          isCorrect = (index == correctAnswer);
          isUserChoice = (index == userAnswer);
        } else if (question.type == '多选') {
          isCorrect = correctAnswer[index];
          isUserChoice = userAnswer[index];
        }

        return Card(
          color: isCorrect ? Colors.green[100] : (isUserChoice ? Colors.red[100] : null),
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
