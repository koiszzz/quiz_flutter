import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_flutter/providers/favorite_list_provider.dart';
import 'package:quiz_flutter/providers/quiz_provider.dart';
import 'dart:convert';
import 'package:quiz_flutter/models/models.dart';

class QuizTakingScreen extends ConsumerWidget {
  final int? bankId;
  final String mode;

  const QuizTakingScreen({super.key, this.bankId, required this.mode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizListAsyncValue = ref.watch(
      quizListProvider(bankId: bankId, mode: mode),
    );
    return switch (quizListAsyncValue) {
      AsyncData(:final value) => Scaffold(
          appBar: AppBar(
            title: Text('$mode 模式'),
            actions: [
              if (mode == 'practice')
                Switch(
                  value: value.showAnswer,
                  onChanged: (newValue) {
                    ref
                        .read(
                          quizListProvider(bankId: bankId, mode: mode)
                              .notifier,
                        )
                        .toggleShowAnswer();
                  },
                ),
              value.currentQuestion != null
                  ? IconButton(
                      icon: Icon(
                        ref
                                .read(favoriteListProvider.notifier)
                                .isFavorite(value.currentQuestion!.id!)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: ref
                                .read(favoriteListProvider.notifier)
                                .isFavorite(value.currentQuestion!.id!)
                            ? Colors.red
                            : null,
                      ),
                      onPressed: () {
                        ref
                            .read(favoriteListProvider.notifier)
                            .toggleFavorite(value.currentQuestion!.id!);
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          body: value.quizFinished
              ? _buildResultView(context, ref, value)
              : _buildQuestionView(context, ref, value),
        ),
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      _ => const Center(child: Text('加载失败')),
    };
  }

  Widget _buildQuestionView(
    BuildContext context,
    WidgetRef ref,
    QuizState provider,
  ) {
    final question = provider.currentQuestion!;
    final userAnswer = provider.userAnswers[question.id];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '题目 ${provider.currentIndex + 1}/${provider.questions.length}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(question.content,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            _buildOptions(context, ref, provider, question),
            if (provider.showAnswer && userAnswer != null)
              _buildAnswerView(context, question),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: provider.userAnswers.containsKey(question.id)
                  ? () => ref
                      .read(
                        quizListProvider(bankId: bankId, mode: mode).notifier,
                      )
                      .nextQuestion()
                  : null,
              child: Text(
                provider.currentIndex == provider.questions.length - 1
                    ? '完成'
                    : '下一题',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(
    BuildContext context,
    WidgetRef ref,
    QuizState provider,
    Question question,
  ) {
    final options = jsonDecode(question.options) as List;
    final userAnswer = provider.userAnswers[question.id];

    switch (question.type) {
      case '单选':
      case '判断':
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return Card(
              child: RadioListTile<int>(
                title: Text(options[index]),
                value: index,
                groupValue: userAnswer,
                onChanged: (value) {
                  ref
                      .read(
                        quizListProvider(bankId: bankId, mode: mode).notifier,
                      )
                      .answerQuestion(question.id!, value);
                },
              ),
            );
          },
        );
      case '多选':
        // Initialize answer list if not present
        final currentAnswers =
            (userAnswer as List<bool>?) ?? List.filled(options.length, false);
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return Card(
              child: CheckboxListTile(
                title: Text(options[index]),
                value: currentAnswers[index],
                onChanged: (value) {
                  currentAnswers[index] = value!;
                  ref
                      .read(
                        quizListProvider(bankId: bankId, mode: mode).notifier,
                      )
                      .answerQuestion(question.id!, currentAnswers);
                },
              ),
            );
          },
        );
      default:
        return const Text('不支持的题目类型');
    }
  }

  Widget _buildAnswerView(BuildContext context, Question question) {
    final correctAnswer = jsonDecode(question.answer);
    final options = jsonDecode(question.options) as List;
    String correctAnswerText;
    switch (question.type) {
      case '单选':
      case '判断':
        correctAnswerText = options[correctAnswer as int];
        break;
      case '多选':
        final correctIndices = (correctAnswer as List).asMap().entries.where((e) => e.value).map((e) => e.key).toList();
        correctAnswerText =
            correctIndices.map((i) => options[i]).join(', ');
        break;
      default:
        correctAnswerText = '未知';
    }
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '正确答案: $correctAnswerText',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text('解析: ${question.explanation}'),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView(
    BuildContext context,
    WidgetRef ref,
    QuizState provider,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('答题完成!', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          Text(
            '你的得分: ${ref.read(quizListProvider(bankId: bankId, mode: mode).notifier).getScore()} / ${provider.questions.length}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('返回'),
          ),
        ],
      ),
    );
  }
}
