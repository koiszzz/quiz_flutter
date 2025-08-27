// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Question {

 int? get id; String get content; String get type; String get options;// JSON encoded string
 String get answer; String? get explanation; String? get tags;// Comma-separated
@JsonKey(name: 'bank_id') int get bankId;@TimestampSerializer()@JsonKey(name: 'created_at') DateTime get createdAt;@TimestampSerializer()@JsonKey(name: 'updated_at') DateTime get updatedAt;@JsonKey(name: 'is_favorite')@BooleanSerializer() bool get isFavorite;@JsonKey(name: 'taking_times') int get takingTimes;@TimestampSerializer()@JsonKey(name: 'last_taken_at') DateTime get lastTakenAt;@JsonKey(name: 'uncorrect_times') int get uncorrectTimes;@JsonKey(includeToJson: false) String get shuffleOptions;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.options, options) || other.options == options)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.tags, tags) || other.tags == tags)&&(identical(other.bankId, bankId) || other.bankId == bankId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.takingTimes, takingTimes) || other.takingTimes == takingTimes)&&(identical(other.lastTakenAt, lastTakenAt) || other.lastTakenAt == lastTakenAt)&&(identical(other.uncorrectTimes, uncorrectTimes) || other.uncorrectTimes == uncorrectTimes)&&(identical(other.shuffleOptions, shuffleOptions) || other.shuffleOptions == shuffleOptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,type,options,answer,explanation,tags,bankId,createdAt,updatedAt,isFavorite,takingTimes,lastTakenAt,uncorrectTimes,shuffleOptions);

@override
String toString() {
  return 'Question(id: $id, content: $content, type: $type, options: $options, answer: $answer, explanation: $explanation, tags: $tags, bankId: $bankId, createdAt: $createdAt, updatedAt: $updatedAt, isFavorite: $isFavorite, takingTimes: $takingTimes, lastTakenAt: $lastTakenAt, uncorrectTimes: $uncorrectTimes, shuffleOptions: $shuffleOptions)';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 int? id, String content, String type, String options, String answer, String? explanation, String? tags,@JsonKey(name: 'bank_id') int bankId,@TimestampSerializer()@JsonKey(name: 'created_at') DateTime createdAt,@TimestampSerializer()@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'is_favorite')@BooleanSerializer() bool isFavorite,@JsonKey(name: 'taking_times') int takingTimes,@TimestampSerializer()@JsonKey(name: 'last_taken_at') DateTime lastTakenAt,@JsonKey(name: 'uncorrect_times') int uncorrectTimes,@JsonKey(includeToJson: false) String shuffleOptions
});




}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? content = null,Object? type = null,Object? options = null,Object? answer = null,Object? explanation = freezed,Object? tags = freezed,Object? bankId = null,Object? createdAt = null,Object? updatedAt = null,Object? isFavorite = null,Object? takingTimes = null,Object? lastTakenAt = null,Object? uncorrectTimes = null,Object? shuffleOptions = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as String?,bankId: null == bankId ? _self.bankId : bankId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,takingTimes: null == takingTimes ? _self.takingTimes : takingTimes // ignore: cast_nullable_to_non_nullable
as int,lastTakenAt: null == lastTakenAt ? _self.lastTakenAt : lastTakenAt // ignore: cast_nullable_to_non_nullable
as DateTime,uncorrectTimes: null == uncorrectTimes ? _self.uncorrectTimes : uncorrectTimes // ignore: cast_nullable_to_non_nullable
as int,shuffleOptions: null == shuffleOptions ? _self.shuffleOptions : shuffleOptions // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Question value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Question value)  $default,){
final _that = this;
switch (_that) {
case _Question():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Question value)?  $default,){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String content,  String type,  String options,  String answer,  String? explanation,  String? tags, @JsonKey(name: 'bank_id')  int bankId, @TimestampSerializer()@JsonKey(name: 'created_at')  DateTime createdAt, @TimestampSerializer()@JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'is_favorite')@BooleanSerializer()  bool isFavorite, @JsonKey(name: 'taking_times')  int takingTimes, @TimestampSerializer()@JsonKey(name: 'last_taken_at')  DateTime lastTakenAt, @JsonKey(name: 'uncorrect_times')  int uncorrectTimes, @JsonKey(includeToJson: false)  String shuffleOptions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.content,_that.type,_that.options,_that.answer,_that.explanation,_that.tags,_that.bankId,_that.createdAt,_that.updatedAt,_that.isFavorite,_that.takingTimes,_that.lastTakenAt,_that.uncorrectTimes,_that.shuffleOptions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String content,  String type,  String options,  String answer,  String? explanation,  String? tags, @JsonKey(name: 'bank_id')  int bankId, @TimestampSerializer()@JsonKey(name: 'created_at')  DateTime createdAt, @TimestampSerializer()@JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'is_favorite')@BooleanSerializer()  bool isFavorite, @JsonKey(name: 'taking_times')  int takingTimes, @TimestampSerializer()@JsonKey(name: 'last_taken_at')  DateTime lastTakenAt, @JsonKey(name: 'uncorrect_times')  int uncorrectTimes, @JsonKey(includeToJson: false)  String shuffleOptions)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.id,_that.content,_that.type,_that.options,_that.answer,_that.explanation,_that.tags,_that.bankId,_that.createdAt,_that.updatedAt,_that.isFavorite,_that.takingTimes,_that.lastTakenAt,_that.uncorrectTimes,_that.shuffleOptions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String content,  String type,  String options,  String answer,  String? explanation,  String? tags, @JsonKey(name: 'bank_id')  int bankId, @TimestampSerializer()@JsonKey(name: 'created_at')  DateTime createdAt, @TimestampSerializer()@JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'is_favorite')@BooleanSerializer()  bool isFavorite, @JsonKey(name: 'taking_times')  int takingTimes, @TimestampSerializer()@JsonKey(name: 'last_taken_at')  DateTime lastTakenAt, @JsonKey(name: 'uncorrect_times')  int uncorrectTimes, @JsonKey(includeToJson: false)  String shuffleOptions)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.content,_that.type,_that.options,_that.answer,_that.explanation,_that.tags,_that.bankId,_that.createdAt,_that.updatedAt,_that.isFavorite,_that.takingTimes,_that.lastTakenAt,_that.uncorrectTimes,_that.shuffleOptions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Question implements Question {
   _Question({this.id, required this.content, required this.type, required this.options, required this.answer, this.explanation, this.tags, @JsonKey(name: 'bank_id') required this.bankId, @TimestampSerializer()@JsonKey(name: 'created_at') required this.createdAt, @TimestampSerializer()@JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'is_favorite')@BooleanSerializer() this.isFavorite = false, @JsonKey(name: 'taking_times') required this.takingTimes, @TimestampSerializer()@JsonKey(name: 'last_taken_at') required this.lastTakenAt, @JsonKey(name: 'uncorrect_times') required this.uncorrectTimes, @JsonKey(includeToJson: false) this.shuffleOptions = ""});
  factory _Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

@override final  int? id;
@override final  String content;
@override final  String type;
@override final  String options;
// JSON encoded string
@override final  String answer;
@override final  String? explanation;
@override final  String? tags;
// Comma-separated
@override@JsonKey(name: 'bank_id') final  int bankId;
@override@TimestampSerializer()@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@TimestampSerializer()@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override@JsonKey(name: 'is_favorite')@BooleanSerializer() final  bool isFavorite;
@override@JsonKey(name: 'taking_times') final  int takingTimes;
@override@TimestampSerializer()@JsonKey(name: 'last_taken_at') final  DateTime lastTakenAt;
@override@JsonKey(name: 'uncorrect_times') final  int uncorrectTimes;
@override@JsonKey(includeToJson: false) final  String shuffleOptions;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.options, options) || other.options == options)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.tags, tags) || other.tags == tags)&&(identical(other.bankId, bankId) || other.bankId == bankId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.takingTimes, takingTimes) || other.takingTimes == takingTimes)&&(identical(other.lastTakenAt, lastTakenAt) || other.lastTakenAt == lastTakenAt)&&(identical(other.uncorrectTimes, uncorrectTimes) || other.uncorrectTimes == uncorrectTimes)&&(identical(other.shuffleOptions, shuffleOptions) || other.shuffleOptions == shuffleOptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,type,options,answer,explanation,tags,bankId,createdAt,updatedAt,isFavorite,takingTimes,lastTakenAt,uncorrectTimes,shuffleOptions);

@override
String toString() {
  return 'Question(id: $id, content: $content, type: $type, options: $options, answer: $answer, explanation: $explanation, tags: $tags, bankId: $bankId, createdAt: $createdAt, updatedAt: $updatedAt, isFavorite: $isFavorite, takingTimes: $takingTimes, lastTakenAt: $lastTakenAt, uncorrectTimes: $uncorrectTimes, shuffleOptions: $shuffleOptions)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 int? id, String content, String type, String options, String answer, String? explanation, String? tags,@JsonKey(name: 'bank_id') int bankId,@TimestampSerializer()@JsonKey(name: 'created_at') DateTime createdAt,@TimestampSerializer()@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'is_favorite')@BooleanSerializer() bool isFavorite,@JsonKey(name: 'taking_times') int takingTimes,@TimestampSerializer()@JsonKey(name: 'last_taken_at') DateTime lastTakenAt,@JsonKey(name: 'uncorrect_times') int uncorrectTimes,@JsonKey(includeToJson: false) String shuffleOptions
});




}
/// @nodoc
class __$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? content = null,Object? type = null,Object? options = null,Object? answer = null,Object? explanation = freezed,Object? tags = freezed,Object? bankId = null,Object? createdAt = null,Object? updatedAt = null,Object? isFavorite = null,Object? takingTimes = null,Object? lastTakenAt = null,Object? uncorrectTimes = null,Object? shuffleOptions = null,}) {
  return _then(_Question(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as String?,bankId: null == bankId ? _self.bankId : bankId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,takingTimes: null == takingTimes ? _self.takingTimes : takingTimes // ignore: cast_nullable_to_non_nullable
as int,lastTakenAt: null == lastTakenAt ? _self.lastTakenAt : lastTakenAt // ignore: cast_nullable_to_non_nullable
as DateTime,uncorrectTimes: null == uncorrectTimes ? _self.uncorrectTimes : uncorrectTimes // ignore: cast_nullable_to_non_nullable
as int,shuffleOptions: null == shuffleOptions ? _self.shuffleOptions : shuffleOptions // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
