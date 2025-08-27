import 'package:flutter/material.dart';
import 'package:quiz_flutter/l10n/app_localizations.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/services/database_helper.dart';
import 'dart:convert';

class QuizRecordDetailsScreen extends StatefulWidget {
  final QuizRecord record;

  const QuizRecordDetailsScreen({super.key, required this.record});

  @override
  State<QuizRecordDetailsScreen> createState() =>
      _QuizRecordDetailsScreenState();
}

class _QuizRecordDetailsScreenState extends State<QuizRecordDetailsScreen> {
  late Future<List<Question>> _questionsFuture;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _questionsFuture = _loadQuestions();
  }

  Future<List<Question>> _loadQuestions() async {
    final questionIds = widget.record.questionIds
        .split(',')
        .map(int.parse)
        .toList();
    return await _dbHelper.getQuestionsByIds(questionIds);
  }

  @override
  Widget build(BuildContext context) {
    final answers = jsonDecode(widget.record.answers) as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.examDetail)),
      body: FutureBuilder<List<Question>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${AppLocalizations.of(context)!.loadFailMsg}: ${snapshot.error}',
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noQuestionFoundMsg),
            );
          }

          final questions = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              final answerInfo =
                  answers[question.id.toString()] as Map<String, dynamic>;
              final userAnswer = answerInfo['userAnswer'];
              final status = answerInfo['status'] ?? 'unanswered';

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
                      _buildOptionsReview(
                        context,
                        question,
                        userAnswer,
                        status,
                      ),
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
          );
        },
      ),
    );
  }

  Widget _buildOptionsReview(
    BuildContext context,
    Question question,
    dynamic userAnswer,
    String status,
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

        dynamic parsedUserAnswer;
        try {
          parsedUserAnswer = jsonDecode(userAnswer);
        } catch (e) {
          parsedUserAnswer = userAnswer;
        }

        if (question.type == 'single' || question.type == 'judge') {
          isCorrect = (index == correctAnswer);
          isUserChoice = (index.toString() == parsedUserAnswer.toString());
        } else if (question.type == 'multiple') {
          isCorrect = correctAnswer[index];
          if (parsedUserAnswer is List && parsedUserAnswer.length > index) {
            isUserChoice = parsedUserAnswer[index];
          }
        }

        Color? cardColor;
        Widget? trailingIcon;

        if (isCorrect) {
          cardColor = Colors.green[300];
          trailingIcon = const Icon(Icons.check_circle, color: Colors.green);
        } else if (isUserChoice) {
          switch (status) {
            case 'incorrect':
              cardColor = Colors.red[300];
              trailingIcon = const Icon(Icons.cancel, color: Colors.red);
              break;
            case 'partial':
              cardColor = Colors.orange[300];
              trailingIcon = const Icon(Icons.error, color: Colors.orange);
              break;
          }
        }

        if (status == 'unanswered') {
          cardColor = Colors.grey[500];
        }

        return Card(
          color: cardColor,
          child: ListTile(title: Text(optionText), trailing: trailingIcon),
        );
      },
    );
  }
}
