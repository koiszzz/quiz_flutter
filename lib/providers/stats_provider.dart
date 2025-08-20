import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/services/database_helper.dart';

part 'stats_provider.g.dart';

@Riverpod(keepAlive: true)
class StatsList extends _$StatsList {
  @override
  Future<List<QuizRecord>> build() async {
    final dbHelper = DatabaseHelper.instance;
    final records = await dbHelper.getAllRecords();
    // Sort by date, newest first
    records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return records;
  }
}
