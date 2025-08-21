import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_flutter/models/json_convert.dart';

part 'question_bank.freezed.dart';
part 'question_bank.g.dart';

@freezed
abstract class QuestionBank with _$QuestionBank {
  const factory QuestionBank({
    int? id,
    required String name,
    String? description,
    @JsonKey(name: 'created_at')
    @TimestampSerializer()
    required DateTime createdAt,
  }) = _QuestionBank;

  factory QuestionBank.fromJson(Map<String, dynamic> json) =>
      _$QuestionBankFromJson(json);
}
