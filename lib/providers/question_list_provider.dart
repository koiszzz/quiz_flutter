import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/services/database_helper.dart';

part 'question_list_provider.g.dart';

@riverpod
class QuestionList extends _$QuestionList {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Question>> build(int bankId) async {
    log('hello question $bankId');
    return _dbHelper.getQuestionsByBank(bankId: bankId);
  }

  Future<void> addQuestion(Question question) async {
    await _dbHelper.insertQuestion(question);
    ref.invalidateSelf();
    await future;
  }

  Future<void> updateQuestion(Question question) async {
    await _dbHelper.updateQuestion(question);
    ref.invalidateSelf();
    await future;
  }

  Future<void> deleteQuestion(int id) async {
    await _dbHelper.deleteQuestion(id);
    ref.invalidateSelf();
    await future;
  }
}
