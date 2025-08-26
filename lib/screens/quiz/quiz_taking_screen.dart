import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_flutter/providers/quiz_provider.dart';
import 'dart:convert';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/screens/quiz/quiz_review_screen.dart';

final optionPrefix = 'ABCDEFGHIJK';

class QuizTakingScreen extends ConsumerWidget {
  final QuizConfig config;

  const QuizTakingScreen({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizListAsyncValue = ref.watch(quizProvider(config));

    return switch (quizListAsyncValue) {
      AsyncData(:final value) =>
        value.questions.isEmpty
            ? Scaffold(
                appBar: AppBar(title: Text('${config.mode} 模式')),
                body: Center(
                  child: Column(
                    children: [
                      const Text('当前考试没有题目，请选择模式或题库。'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('返回'),
                      ),
                    ],
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text('${config.mode} 模式'),
                  actions: [
                    if (config.mode == 'exam')
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            '${value.remainingTime.inMinutes.toString().padLeft(2, '0')}:${(value.remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontFeatures: [
                                    const FontFeature.tabularFigures(),
                                  ],
                                ),
                          ),
                        ),
                      ),
                    value.currentQuestion != null && !value.quizFinished
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
                                  .read(quizProvider(config).notifier)
                                  .toggleCurrentFav();
                            },
                          )
                        : const SizedBox.shrink(),
                    IconButton(
                      icon: const Icon(Icons.list_alt),
                      onPressed: () {
                        _showQuestionList(context, ref, value);
                      },
                    ),
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

  void _showQuestionList(
    BuildContext context,
    WidgetRef ref,
    QuizState provider,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: provider.questions.length,
          itemBuilder: (context, index) {
            final question = provider.questions[index];
            final isAnswered = provider.userAnswers.containsKey(question.id);
            return ElevatedButton(
              onPressed: () {
                ref.read(quizProvider(config).notifier).goToQuestion(index);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0),
                ),
                backgroundColor: isAnswered
                    ? Colors.green[200]
                    : Colors.red[300],
                foregroundColor: Colors.white,
              ),
              child: Text(
                '${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildQuestionView(
    BuildContext context,
    WidgetRef ref,
    QuizState provider,
  ) {
    final question = provider.currentQuestion!;
    final userAnswer = provider.userAnswers[question.id];
    bool readyForShow = userAnswer != null;
    if (question.type == '多选') {
      final answer = jsonDecode(question.answer);
      readyForShow =
          (((userAnswer as List<dynamic>?) ?? <bool>[])
              .cast<bool>()
              .where((v) => v)
              .length >=
          (answer?.where((v) => v as bool).length ?? 0));
    }
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
            if (config.mode == 'practice')
              ListTile(
                title: const Text('是否显示答案'),
                trailing: Switch(
                  value: provider.showAnswer,
                  onChanged: (newValue) {
                    ref.read(quizProvider(config).notifier).toggleShowAnswer();
                  },
                ),
              ),
            if (provider.showAnswer && readyForShow)
              _buildAnswerView(context, question),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: provider.currentIndex > 0
                        ? () => ref
                              .read(quizProvider(config).notifier)
                              .preQuestion()
                        : null,
                    child: const Text('上一题'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        provider.currentIndex == provider.questions.length - 1
                        ? () => _submitQuiz(context, ref, provider)
                        : () => ref
                              .read(quizProvider(config).notifier)
                              .nextQuestion(),
                    child: Text(
                      provider.currentIndex == provider.questions.length - 1
                          ? '完成'
                          : '下一题',
                    ),
                  ),
                ),
              ],
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
                title: Text('${optionPrefix[index]}: ${options[index]}'),
                value: index,
                groupValue: userAnswer,
                onChanged: (value) {
                  ref
                      .read(quizProvider(config).notifier)
                      .answerQuestion(question.id!, value);
                },
              ),
            );
          },
        );
      case '多选':
        final currentAnswers =
            (userAnswer as List<dynamic>?)?.cast<bool>() ??
            List.filled(options.length, false);
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return Card(
              child: CheckboxListTile(
                title: Text('${optionPrefix[index]}: ${options[index]}'),
                value: currentAnswers[index],
                onChanged: (value) {
                  currentAnswers[index] = value!;
                  ref
                      .read(quizProvider(config).notifier)
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
            Text('正确答案: ', style: Theme.of(context).textTheme.titleLarge),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                correctAnswerText,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[300],
                ),
              ),
            ),
            if (question.explanation != null &&
                question.explanation!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('解析: ', style: Theme.of(context).textTheme.titleLarge),
              Text(question.explanation!),
            ],
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
    final score = ref.read(quizProvider(config).notifier).getScore();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('答题完成!', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          Text(
            '你的得分: $score / ${provider.questions.length}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizReviewScreen(
                    questions: provider.questions,
                    userAnswers: provider.userAnswers,
                  ),
                ),
              );
            },
            child: const Text('查看错题'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('返回主页'),
          ),
        ],
      ),
    );
  }

  void _submitQuiz(BuildContext context, WidgetRef ref, QuizState provider) {
    final unansweredQuestions =
        provider.questions.length - provider.userAnswers.length;
    if (unansweredQuestions > 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('提示'),
          content: Text('您还有 $unansweredQuestions 题未作答，确定要提交吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(quizProvider(config).notifier).nextQuestion();
              },
              child: const Text('确定'),
            ),
          ],
        ),
      );
    } else {
      ref.read(quizProvider(config).notifier).nextQuestion();
    }
  }
}
