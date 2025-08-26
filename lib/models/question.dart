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
    @TimestampSerializer()
    @JsonKey(name: 'updated_at')
    required DateTime updatedAt,
    @JsonKey(name: 'is_favorite')
    @BooleanSerializer()
    @Default(false)
    bool isFavorite,
    @JsonKey(name: 'taking_times') required int takingTimes,
    @TimestampSerializer()
    @JsonKey(name: 'last_taken_at')
    required DateTime lastTakenAt,
    @JsonKey(name: 'uncorrect_times') required int uncorrectTimes,
    @JsonKey(includeToJson: false) @Default("") String shuffleOptions,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
