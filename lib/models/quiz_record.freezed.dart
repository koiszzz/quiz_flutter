// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizRecord {

 int? get id;@JsonKey(name: 'question_id') int get questionId;@JsonKey(name: 'user_answer') String get userAnswer;@JsonKey(name: 'is_correct')@BooleanSerializer() bool get isCorrect; DateTime get timestamp; String get mode;
/// Create a copy of QuizRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizRecordCopyWith<QuizRecord> get copyWith => _$QuizRecordCopyWithImpl<QuizRecord>(this as QuizRecord, _$identity);

  /// Serializes this QuizRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.userAnswer, userAnswer) || other.userAnswer == userAnswer)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.mode, mode) || other.mode == mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,questionId,userAnswer,isCorrect,timestamp,mode);

@override
String toString() {
  return 'QuizRecord(id: $id, questionId: $questionId, userAnswer: $userAnswer, isCorrect: $isCorrect, timestamp: $timestamp, mode: $mode)';
}


}

/// @nodoc
abstract mixin class $QuizRecordCopyWith<$Res>  {
  factory $QuizRecordCopyWith(QuizRecord value, $Res Function(QuizRecord) _then) = _$QuizRecordCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'question_id') int questionId,@JsonKey(name: 'user_answer') String userAnswer,@JsonKey(name: 'is_correct')@BooleanSerializer() bool isCorrect, DateTime timestamp, String mode
});




}
/// @nodoc
class _$QuizRecordCopyWithImpl<$Res>
    implements $QuizRecordCopyWith<$Res> {
  _$QuizRecordCopyWithImpl(this._self, this._then);

  final QuizRecord _self;
  final $Res Function(QuizRecord) _then;

/// Create a copy of QuizRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? questionId = null,Object? userAnswer = null,Object? isCorrect = null,Object? timestamp = null,Object? mode = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,userAnswer: null == userAnswer ? _self.userAnswer : userAnswer // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizRecord].
extension QuizRecordPatterns on QuizRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizRecord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizRecord value)  $default,){
final _that = this;
switch (_that) {
case _QuizRecord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizRecord value)?  $default,){
final _that = this;
switch (_that) {
case _QuizRecord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'question_id')  int questionId, @JsonKey(name: 'user_answer')  String userAnswer, @JsonKey(name: 'is_correct')@BooleanSerializer()  bool isCorrect,  DateTime timestamp,  String mode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizRecord() when $default != null:
return $default(_that.id,_that.questionId,_that.userAnswer,_that.isCorrect,_that.timestamp,_that.mode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'question_id')  int questionId, @JsonKey(name: 'user_answer')  String userAnswer, @JsonKey(name: 'is_correct')@BooleanSerializer()  bool isCorrect,  DateTime timestamp,  String mode)  $default,) {final _that = this;
switch (_that) {
case _QuizRecord():
return $default(_that.id,_that.questionId,_that.userAnswer,_that.isCorrect,_that.timestamp,_that.mode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(name: 'question_id')  int questionId, @JsonKey(name: 'user_answer')  String userAnswer, @JsonKey(name: 'is_correct')@BooleanSerializer()  bool isCorrect,  DateTime timestamp,  String mode)?  $default,) {final _that = this;
switch (_that) {
case _QuizRecord() when $default != null:
return $default(_that.id,_that.questionId,_that.userAnswer,_that.isCorrect,_that.timestamp,_that.mode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizRecord implements QuizRecord {
   _QuizRecord({this.id, @JsonKey(name: 'question_id') required this.questionId, @JsonKey(name: 'user_answer') this.userAnswer = '', @JsonKey(name: 'is_correct')@BooleanSerializer() required this.isCorrect, required this.timestamp, required this.mode});
  factory _QuizRecord.fromJson(Map<String, dynamic> json) => _$QuizRecordFromJson(json);

@override final  int? id;
@override@JsonKey(name: 'question_id') final  int questionId;
@override@JsonKey(name: 'user_answer') final  String userAnswer;
@override@JsonKey(name: 'is_correct')@BooleanSerializer() final  bool isCorrect;
@override final  DateTime timestamp;
@override final  String mode;

/// Create a copy of QuizRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizRecordCopyWith<_QuizRecord> get copyWith => __$QuizRecordCopyWithImpl<_QuizRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.userAnswer, userAnswer) || other.userAnswer == userAnswer)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.mode, mode) || other.mode == mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,questionId,userAnswer,isCorrect,timestamp,mode);

@override
String toString() {
  return 'QuizRecord(id: $id, questionId: $questionId, userAnswer: $userAnswer, isCorrect: $isCorrect, timestamp: $timestamp, mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$QuizRecordCopyWith<$Res> implements $QuizRecordCopyWith<$Res> {
  factory _$QuizRecordCopyWith(_QuizRecord value, $Res Function(_QuizRecord) _then) = __$QuizRecordCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'question_id') int questionId,@JsonKey(name: 'user_answer') String userAnswer,@JsonKey(name: 'is_correct')@BooleanSerializer() bool isCorrect, DateTime timestamp, String mode
});




}
/// @nodoc
class __$QuizRecordCopyWithImpl<$Res>
    implements _$QuizRecordCopyWith<$Res> {
  __$QuizRecordCopyWithImpl(this._self, this._then);

  final _QuizRecord _self;
  final $Res Function(_QuizRecord) _then;

/// Create a copy of QuizRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? questionId = null,Object? userAnswer = null,Object? isCorrect = null,Object? timestamp = null,Object? mode = null,}) {
  return _then(_QuizRecord(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,userAnswer: null == userAnswer ? _self.userAnswer : userAnswer // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
