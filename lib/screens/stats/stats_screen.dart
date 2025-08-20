import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_flutter/providers/stats_provider.dart';
import 'package:intl/intl.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsyncValue = ref.watch(statsListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('数据统计'),
      ),
      body: statsAsyncValue.when(
        data: (records) {
          if (records.isEmpty) {
            return const Center(child: Text('还没有答题记录。'));
          }
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(
                    record.isCorrect ? Icons.check_circle : Icons.cancel,
                    color: record.isCorrect ? Colors.green : Colors.red,
                  ),
                  title: Text('题目ID: ${record.questionId}'),
                  subtitle: Text(
                    '时间: ${DateFormat('yyyy-MM-dd HH:mm').format(record.timestamp)}模式: ${record.mode}',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('加载记录失败: $err')),
      ),
    );
  }
}
