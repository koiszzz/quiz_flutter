// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Question _$QuestionFromJson(Map<String, dynamic> json) => _Question(
  id: (json['id'] as num?)?.toInt(),
  content: json['content'] as String,
  type: json['type'] as String,
  options: json['options'] as String,
  answer: json['answer'] as String,
  explanation: json['explanation'] as String?,
  tags: json['tags'] as String?,
  bankId: (json['bank_id'] as num).toInt(),
  createdAt: const TimestampSerializer().fromJson(json['created_at']),
);

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'type': instance.type,
  'options': instance.options,
  'answer': instance.answer,
  'explanation': instance.explanation,
  'tags': instance.tags,
  'bank_id': instance.bankId,
  'created_at': const TimestampSerializer().toJson(instance.createdAt),
};
