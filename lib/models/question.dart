import 'package:freezed_annotation/freezed_annotation.dart';
import 'json_convert.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
abstract class Question with _$Question {
  factory Question({
    int? id,
    required String content,
    required String type,
    required String options, // JSON encoded string
    required String answer,
    String? explanation,
    String? tags, // Comma-separated
    @JsonKey(name: 'bank_id') required int bankId,
    @TimestampSerializer()
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
