import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/services/database_helper.dart';

part 'bank_list_provider.g.dart';

@Riverpod(keepAlive: true)
class BankList extends _$BankList {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<List<QuestionBank>> build() async {
    log('hello bank');
    return _dbHelper.getAllBanks();
  }

  Future<void> addBank(QuestionBank bank) async {
    await _dbHelper.insertBank(bank);
    ref.invalidateSelf();
    // Wait for the state to be updated
    await future;
  }

  Future<void> updateBank(QuestionBank bank) async {
    await _dbHelper.updateBank(bank);
    ref.invalidateSelf();
    await future;
  }

  Future<void> deleteBank(int id) async {
    await _dbHelper.deleteBank(id);
    ref.invalidateSelf();
    await future;
  }
}
