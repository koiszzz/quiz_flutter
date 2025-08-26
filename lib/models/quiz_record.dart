import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_record.freezed.dart';
part 'quiz_record.g.dart';

@freezed
abstract class QuizRecord with _$QuizRecord {
  factory QuizRecord({
    int? id,
    @JsonKey(name: 'bank_id') required int bankId,
    @Default('') String answers,
    required int score,
    required int total,
    required int duration,
    required DateTime timestamp,
    required String mode,
    @JsonKey(name: 'question_ids') required String questionIds,
  }) = _QuizRecord;

  factory QuizRecord.fromJson(Map<String, dynamic> json) =>
      _$QuizRecordFromJson(json);
}
