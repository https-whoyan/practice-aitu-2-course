// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grade_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GradeHistoryEntry {

 num get score; String? get comment; String get changedBy;@TimestampConverter() DateTime get changedAt;
/// Create a copy of GradeHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeHistoryEntryCopyWith<GradeHistoryEntry> get copyWith => _$GradeHistoryEntryCopyWithImpl<GradeHistoryEntry>(this as GradeHistoryEntry, _$identity);

  /// Serializes this GradeHistoryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeHistoryEntry&&(identical(other.score, score) || other.score == score)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.changedBy, changedBy) || other.changedBy == changedBy)&&(identical(other.changedAt, changedAt) || other.changedAt == changedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,score,comment,changedBy,changedAt);

@override
String toString() {
  return 'GradeHistoryEntry(score: $score, comment: $comment, changedBy: $changedBy, changedAt: $changedAt)';
}


}

/// @nodoc
abstract mixin class $GradeHistoryEntryCopyWith<$Res>  {
  factory $GradeHistoryEntryCopyWith(GradeHistoryEntry value, $Res Function(GradeHistoryEntry) _then) = _$GradeHistoryEntryCopyWithImpl;
@useResult
$Res call({
 num score, String? comment, String changedBy,@TimestampConverter() DateTime changedAt
});




}
/// @nodoc
class _$GradeHistoryEntryCopyWithImpl<$Res>
    implements $GradeHistoryEntryCopyWith<$Res> {
  _$GradeHistoryEntryCopyWithImpl(this._self, this._then);

  final GradeHistoryEntry _self;
  final $Res Function(GradeHistoryEntry) _then;

/// Create a copy of GradeHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = null,Object? comment = freezed,Object? changedBy = null,Object? changedAt = null,}) {
  return _then(_self.copyWith(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,changedBy: null == changedBy ? _self.changedBy : changedBy // ignore: cast_nullable_to_non_nullable
as String,changedAt: null == changedAt ? _self.changedAt : changedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeHistoryEntry].
extension GradeHistoryEntryPatterns on GradeHistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeHistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeHistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _GradeHistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeHistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _GradeHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num score,  String? comment,  String changedBy, @TimestampConverter()  DateTime changedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeHistoryEntry() when $default != null:
return $default(_that.score,_that.comment,_that.changedBy,_that.changedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num score,  String? comment,  String changedBy, @TimestampConverter()  DateTime changedAt)  $default,) {final _that = this;
switch (_that) {
case _GradeHistoryEntry():
return $default(_that.score,_that.comment,_that.changedBy,_that.changedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num score,  String? comment,  String changedBy, @TimestampConverter()  DateTime changedAt)?  $default,) {final _that = this;
switch (_that) {
case _GradeHistoryEntry() when $default != null:
return $default(_that.score,_that.comment,_that.changedBy,_that.changedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeHistoryEntry implements GradeHistoryEntry {
  const _GradeHistoryEntry({this.score = 0, this.comment, this.changedBy = '', @TimestampConverter() required this.changedAt});
  factory _GradeHistoryEntry.fromJson(Map<String, dynamic> json) => _$GradeHistoryEntryFromJson(json);

@override@JsonKey() final  num score;
@override final  String? comment;
@override@JsonKey() final  String changedBy;
@override@TimestampConverter() final  DateTime changedAt;

/// Create a copy of GradeHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeHistoryEntryCopyWith<_GradeHistoryEntry> get copyWith => __$GradeHistoryEntryCopyWithImpl<_GradeHistoryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeHistoryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeHistoryEntry&&(identical(other.score, score) || other.score == score)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.changedBy, changedBy) || other.changedBy == changedBy)&&(identical(other.changedAt, changedAt) || other.changedAt == changedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,score,comment,changedBy,changedAt);

@override
String toString() {
  return 'GradeHistoryEntry(score: $score, comment: $comment, changedBy: $changedBy, changedAt: $changedAt)';
}


}

/// @nodoc
abstract mixin class _$GradeHistoryEntryCopyWith<$Res> implements $GradeHistoryEntryCopyWith<$Res> {
  factory _$GradeHistoryEntryCopyWith(_GradeHistoryEntry value, $Res Function(_GradeHistoryEntry) _then) = __$GradeHistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 num score, String? comment, String changedBy,@TimestampConverter() DateTime changedAt
});




}
/// @nodoc
class __$GradeHistoryEntryCopyWithImpl<$Res>
    implements _$GradeHistoryEntryCopyWith<$Res> {
  __$GradeHistoryEntryCopyWithImpl(this._self, this._then);

  final _GradeHistoryEntry _self;
  final $Res Function(_GradeHistoryEntry) _then;

/// Create a copy of GradeHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? comment = freezed,Object? changedBy = null,Object? changedAt = null,}) {
  return _then(_GradeHistoryEntry(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,changedBy: null == changedBy ? _self.changedBy : changedBy // ignore: cast_nullable_to_non_nullable
as String,changedAt: null == changedAt ? _self.changedAt : changedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
