import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/services/database_helper.dart';

part 'stats_provider.g.dart';

@Riverpod(keepAlive: true)
class StatsList extends _$StatsList {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  @override
  Future<List<QuizRecord>> build() async {
    final records = await _dbHelper.getAllRecords();
    // Sort by date, newest first
    records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return records;
  }

  Future<void> addRecord(QuizRecord record) async {
    await _dbHelper.insertRecord(record);
    ref.invalidateSelf();
    await future;
  }
}
