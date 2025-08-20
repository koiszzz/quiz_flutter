import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_flutter/models/json_convert.dart';

part 'quiz_record.freezed.dart';
part 'quiz_record.g.dart';

@freezed
abstract class QuizRecord with _$QuizRecord {
  factory QuizRecord({
    int? id,
    @JsonKey(name: 'question_id') required int questionId,
    @JsonKey(name: 'user_answer') @Default('') String userAnswer,
    @JsonKey(name: 'is_correct') @BooleanSerializer() required bool isCorrect,
    required DateTime timestamp,
    required String mode,
  }) = _QuizRecord;

  factory QuizRecord.fromJson(Map<String, dynamic> json) =>
      _$QuizRecordFromJson(json);
}
