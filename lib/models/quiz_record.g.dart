// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizRecord _$QuizRecordFromJson(Map<String, dynamic> json) => _QuizRecord(
  id: (json['id'] as num?)?.toInt(),
  questionId: (json['question_id'] as num).toInt(),
  userAnswer: json['user_answer'] as String? ?? '',
  isCorrect: const BooleanSerializer().fromJson(json['is_correct']),
  timestamp: DateTime.parse(json['timestamp'] as String),
  mode: json['mode'] as String,
);

Map<String, dynamic> _$QuizRecordToJson(_QuizRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'user_answer': instance.userAnswer,
      'is_correct': const BooleanSerializer().toJson(instance.isCorrect),
      'timestamp': instance.timestamp.toIso8601String(),
      'mode': instance.mode,
    };
