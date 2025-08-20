import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_flutter/services/database_helper.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('答题模式'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildModeCard(
            context,
            '练习模式',
            '按题库顺序或随机练习',
            Icons.psychology_alt,
            () => _showBankSelectionDialog(context, 'practice'),
          ),
          _buildModeCard(
            context,
            '考试模式',
            '模拟真实考试，计时计分',
            Icons.assignment,
            () => _showBankSelectionDialog(context, 'exam'),
          ),
          // TODO: Add other modes like "错题重练" and "收藏夹答题"
        ],
      ),
    );
  }

  Widget _buildModeCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Theme.of(context).primaryColor),
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }

  Future<void> _showBankSelectionDialog(
    BuildContext context,
    String mode,
  ) async {
    final banks = await _dbHelper.getAllBanks();
    if (!mounted) return;

    if (banks.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('没有可用的题库，请先创建题库。')));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('选择题库'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: banks.length,
              itemBuilder: (BuildContext context, int index) {
                final bank = banks[index];
                return ListTile(
                  title: Text(bank.name),
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    context.go(
                      '/quiz/taking',
                      extra: {'bankId': bank.id!, 'mode': mode},
                    );
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
