// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_bank.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionBank {

 int? get id; String get name; String? get description;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of QuestionBank
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionBankCopyWith<QuestionBank> get copyWith => _$QuestionBankCopyWithImpl<QuestionBank>(this as QuestionBank, _$identity);

  /// Serializes this QuestionBank to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionBank&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt);

@override
String toString() {
  return 'QuestionBank(id: $id, name: $name, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $QuestionBankCopyWith<$Res>  {
  factory $QuestionBankCopyWith(QuestionBank value, $Res Function(QuestionBank) _then) = _$QuestionBankCopyWithImpl;
@useResult
$Res call({
 int? id, String name, String? description,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$QuestionBankCopyWithImpl<$Res>
    implements $QuestionBankCopyWith<$Res> {
  _$QuestionBankCopyWithImpl(this._self, this._then);

  final QuestionBank _self;
  final $Res Function(QuestionBank) _then;

/// Create a copy of QuestionBank
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? description = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionBank].
extension QuestionBankPatterns on QuestionBank {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionBank value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionBank() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionBank value)  $default,){
final _that = this;
switch (_that) {
case _QuestionBank():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionBank value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionBank() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  String? description, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionBank() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  String? description, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _QuestionBank():
return $default(_that.id,_that.name,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  String? description, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _QuestionBank() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionBank implements QuestionBank {
  const _QuestionBank({this.id, required this.name, this.description, @JsonKey(name: 'created_at') required this.createdAt});
  factory _QuestionBank.fromJson(Map<String, dynamic> json) => _$QuestionBankFromJson(json);

@override final  int? id;
@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of QuestionBank
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionBankCopyWith<_QuestionBank> get copyWith => __$QuestionBankCopyWithImpl<_QuestionBank>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionBankToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionBank&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt);

@override
String toString() {
  return 'QuestionBank(id: $id, name: $name, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$QuestionBankCopyWith<$Res> implements $QuestionBankCopyWith<$Res> {
  factory _$QuestionBankCopyWith(_QuestionBank value, $Res Function(_QuestionBank) _then) = __$QuestionBankCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, String? description,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$QuestionBankCopyWithImpl<$Res>
    implements _$QuestionBankCopyWith<$Res> {
  __$QuestionBankCopyWithImpl(this._self, this._then);

  final _QuestionBank _self;
  final $Res Function(_QuestionBank) _then;

/// Create a copy of QuestionBank
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? description = freezed,Object? createdAt = null,}) {
  return _then(_QuestionBank(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
