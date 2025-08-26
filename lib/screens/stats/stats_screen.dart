import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_flutter/providers/stats_provider.dart';
import 'package:quiz_flutter/screens/stats/quiz_record_details_screen.dart';

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
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuizRecordDetailsScreen(record: record),
                    ),
                  );
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text('得分: ${record.score} / ${record.total}'),
                        subtitle: Text('日期: ${record.timestamp}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '正确率: ${(record.score / record.total * 100).toStringAsFixed(2)}%',
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 1.7,
                        child: Column(
                          children: [
                            // SizedBox(height: 28),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1.3,
                                child: PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        value: record.score.toDouble(),
                                        color: Colors.green,
                                        title: '正确',
                                        radius: 50,
                                        titleStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      PieChartSectionData(
                                        value: (record.total - record.score)
                                            .toDouble(),
                                        color: Colors.red,
                                        title: '错误',
                                        radius: 50,
                                        titleStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 30,
                                  ),
                                  duration: const Duration(
                                    milliseconds: 150,
                                  ), // Optional
                                  curve: Curves.linear, // Optional
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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