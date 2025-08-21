import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_flutter/providers/quiz_provider.dart';
import 'dart:convert';
import 'package:quiz_flutter/models/models.dart';

final String optionPrefix = 'ABCDEFGHIJK';

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
            value.currentQuestion != null
                ? IconButton(
                    icon: Icon(
                      value.currentQuestion!.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: value.currentQuestion!.isFavorite
                          ? Colors.red[400]
                          : null,
                    ),
                    onPressed: () {
                      ref
                          .read(
                            quizListProvider(
                              bankId: bankId,
                              mode: mode,
                            ).notifier,
                          )
                          .toggleCurrentFav();
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
            Text(
              question.content,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            _buildOptions(context, ref, provider, question),

            if (mode == 'practice')
              ListTile(
                title: Text('是否显示答案'),
                trailing: Switch(
                  value: provider.showAnswer,
                  onChanged: (newValue) {
                    ref
                        .read(
                          quizListProvider(bankId: bankId, mode: mode).notifier,
                        )
                        .toggleShowAnswer();
                  },
                ),
              ),
            if (provider.showAnswer && userAnswer != null)
              _buildAnswerView(context, question),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: provider.currentIndex > 0
                  ? () => ref
                        .read(
                          quizListProvider(bankId: bankId, mode: mode).notifier,
                        )
                        .preQuestion()
                  : null,
              child: const Text('上一题'),
            ),
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
    final correctAnswer = jsonDecode(question.answer);

    switch (question.type) {
      case '单选':
      case '判断':
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          itemBuilder: (context, index) {
            bool isSelected = userAnswer == index;
            bool isCorrect = correctAnswer == index;
            bool isWrong = isSelected && !isCorrect;

            return Card(
              color: isWrong ? Theme.of(context).colorScheme.error : null,
              child: RadioListTile<int>(
                title: Text('${optionPrefix[index]}: ${options[index]}'),
                value: index,
                groupValue: userAnswer,
                onChanged: (value) {
                  ref
                      .read(
                        quizListProvider(bankId: bankId, mode: mode).notifier,
                      )
                      .answerQuestion(question.id!, value);
                },
                secondary: isWrong ? const Icon(Icons.close) : null,
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
            bool isSelected = currentAnswers[index];
            bool isCorrect = (correctAnswer as List<dynamic>)[index];
            bool isWrong = isSelected && !isCorrect;
            return Card(
              color: isWrong ? Theme.of(context).colorScheme.error : null,
              child: CheckboxListTile(
                title: Text('${optionPrefix[index]}: ${options[index]}'),
                value: currentAnswers[index],
                onChanged: (value) {
                  currentAnswers[index] = value!;
                  ref
                      .read(
                        quizListProvider(bankId: bankId, mode: mode).notifier,
                      )
                      .answerQuestion(question.id!, currentAnswers);
                },
                secondary: isWrong ? const Icon(Icons.close) : null,
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
        int correctIndex = correctAnswer as int;
        correctAnswerText =
            '${optionPrefix[correctIndex]}: ${options[correctIndex]}';
        break;
      case '多选':
        final correctIndices = (correctAnswer as List)
            .asMap()
            .entries
            .where((e) => e.value)
            .map((e) => e.key)
            .toList();
        correctAnswerText = correctIndices
            .map((i) => '${optionPrefix[i]}: ${options[i]}')
            .join('\n');
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
            Text('正确答案: ', style: TextStyle(fontSize: 18)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                correctAnswerText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('解析: ', style: TextStyle(fontSize: 18)),
            Text(question.explanation ?? '无解析'),
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
