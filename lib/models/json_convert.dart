import 'package:json_annotation/json_annotation.dart';

class TimestampSerializer implements JsonConverter<DateTime, dynamic> {
  const TimestampSerializer();

  @override
  DateTime fromJson(dynamic timestamp) => DateTime.parse(timestamp as String);

  @override
  String toJson(DateTime date) => date.toIso8601String();
}

class BooleanSerializer implements JsonConverter<bool, dynamic> {
  const BooleanSerializer();

  @override
  bool fromJson(dynamic value) => value == 1;

  @override
  int toJson(bool value) => value ? 1 : 0;
}
