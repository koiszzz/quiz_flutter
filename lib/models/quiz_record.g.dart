// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizRecord _$QuizRecordFromJson(Map<String, dynamic> json) => _QuizRecord(
  id: (json['id'] as num?)?.toInt(),
  bankId: (json['bank_id'] as num).toInt(),
  answers: json['answers'] as String? ?? '',
  score: (json['score'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  duration: (json['duration'] as num).toInt(),
  timestamp: DateTime.parse(json['timestamp'] as String),
  mode: json['mode'] as String,
  questionIds: json['question_ids'] as String,
);

Map<String, dynamic> _$QuizRecordToJson(_QuizRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bank_id': instance.bankId,
      'answers': instance.answers,
      'score': instance.score,
      'total': instance.total,
      'duration': instance.duration,
      'timestamp': instance.timestamp.toIso8601String(),
      'mode': instance.mode,
      'question_ids': instance.questionIds,
    };
