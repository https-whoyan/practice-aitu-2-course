// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grade.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Grade {

 String get gradeId; String get studentId; String get teacherId; String get courseId; String? get groupId; GradeSourceType get sourceType; String? get sourceId; num get score; num get maxScore; num get percentage; String? get comment;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; List<GradeHistoryEntry> get history;
/// Create a copy of Grade
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeCopyWith<Grade> get copyWith => _$GradeCopyWithImpl<Grade>(this as Grade, _$identity);

  /// Serializes this Grade to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Grade&&(identical(other.gradeId, gradeId) || other.gradeId == gradeId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.teacherId, teacherId) || other.teacherId == teacherId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.score, score) || other.score == score)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.history, history));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gradeId,studentId,teacherId,courseId,groupId,sourceType,sourceId,score,maxScore,percentage,comment,createdAt,updatedAt,const DeepCollectionEquality().hash(history));

@override
String toString() {
  return 'Grade(gradeId: $gradeId, studentId: $studentId, teacherId: $teacherId, courseId: $courseId, groupId: $groupId, sourceType: $sourceType, sourceId: $sourceId, score: $score, maxScore: $maxScore, percentage: $percentage, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt, history: $history)';
}


}

/// @nodoc
abstract mixin class $GradeCopyWith<$Res>  {
  factory $GradeCopyWith(Grade value, $Res Function(Grade) _then) = _$GradeCopyWithImpl;
@useResult
$Res call({
 String gradeId, String studentId, String teacherId, String courseId, String? groupId, GradeSourceType sourceType, String? sourceId, num score, num maxScore, num percentage, String? comment,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, List<GradeHistoryEntry> history
});




}
/// @nodoc
class _$GradeCopyWithImpl<$Res>
    implements $GradeCopyWith<$Res> {
  _$GradeCopyWithImpl(this._self, this._then);

  final Grade _self;
  final $Res Function(Grade) _then;

/// Create a copy of Grade
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gradeId = null,Object? studentId = null,Object? teacherId = null,Object? courseId = null,Object? groupId = freezed,Object? sourceType = null,Object? sourceId = freezed,Object? score = null,Object? maxScore = null,Object? percentage = null,Object? comment = freezed,Object? createdAt = null,Object? updatedAt = null,Object? history = null,}) {
  return _then(_self.copyWith(
gradeId: null == gradeId ? _self.gradeId : gradeId // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,teacherId: null == teacherId ? _self.teacherId : teacherId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as GradeSourceType,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as num,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as num,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<GradeHistoryEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [Grade].
extension GradePatterns on Grade {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Grade value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Grade() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Grade value)  $default,){
final _that = this;
switch (_that) {
case _Grade():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Grade value)?  $default,){
final _that = this;
switch (_that) {
case _Grade() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String gradeId,  String studentId,  String teacherId,  String courseId,  String? groupId,  GradeSourceType sourceType,  String? sourceId,  num score,  num maxScore,  num percentage,  String? comment, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  List<GradeHistoryEntry> history)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Grade() when $default != null:
return $default(_that.gradeId,_that.studentId,_that.teacherId,_that.courseId,_that.groupId,_that.sourceType,_that.sourceId,_that.score,_that.maxScore,_that.percentage,_that.comment,_that.createdAt,_that.updatedAt,_that.history);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String gradeId,  String studentId,  String teacherId,  String courseId,  String? groupId,  GradeSourceType sourceType,  String? sourceId,  num score,  num maxScore,  num percentage,  String? comment, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  List<GradeHistoryEntry> history)  $default,) {final _that = this;
switch (_that) {
case _Grade():
return $default(_that.gradeId,_that.studentId,_that.teacherId,_that.courseId,_that.groupId,_that.sourceType,_that.sourceId,_that.score,_that.maxScore,_that.percentage,_that.comment,_that.createdAt,_that.updatedAt,_that.history);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String gradeId,  String studentId,  String teacherId,  String courseId,  String? groupId,  GradeSourceType sourceType,  String? sourceId,  num score,  num maxScore,  num percentage,  String? comment, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  List<GradeHistoryEntry> history)?  $default,) {final _that = this;
switch (_that) {
case _Grade() when $default != null:
return $default(_that.gradeId,_that.studentId,_that.teacherId,_that.courseId,_that.groupId,_that.sourceType,_that.sourceId,_that.score,_that.maxScore,_that.percentage,_that.comment,_that.createdAt,_that.updatedAt,_that.history);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Grade implements Grade {
  const _Grade({required this.gradeId, this.studentId = '', this.teacherId = '', this.courseId = '', this.groupId, this.sourceType = GradeSourceType.manual, this.sourceId, this.score = 0, this.maxScore = 100, this.percentage = 0, this.comment, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, final  List<GradeHistoryEntry> history = const <GradeHistoryEntry>[]}): _history = history;
  factory _Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);

@override final  String gradeId;
@override@JsonKey() final  String studentId;
@override@JsonKey() final  String teacherId;
@override@JsonKey() final  String courseId;
@override final  String? groupId;
@override@JsonKey() final  GradeSourceType sourceType;
@override final  String? sourceId;
@override@JsonKey() final  num score;
@override@JsonKey() final  num maxScore;
@override@JsonKey() final  num percentage;
@override final  String? comment;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
 final  List<GradeHistoryEntry> _history;
@override@JsonKey() List<GradeHistoryEntry> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of Grade
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeCopyWith<_Grade> get copyWith => __$GradeCopyWithImpl<_Grade>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Grade&&(identical(other.gradeId, gradeId) || other.gradeId == gradeId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.teacherId, teacherId) || other.teacherId == teacherId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.score, score) || other.score == score)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._history, _history));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gradeId,studentId,teacherId,courseId,groupId,sourceType,sourceId,score,maxScore,percentage,comment,createdAt,updatedAt,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'Grade(gradeId: $gradeId, studentId: $studentId, teacherId: $teacherId, courseId: $courseId, groupId: $groupId, sourceType: $sourceType, sourceId: $sourceId, score: $score, maxScore: $maxScore, percentage: $percentage, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt, history: $history)';
}


}

/// @nodoc
abstract mixin class _$GradeCopyWith<$Res> implements $GradeCopyWith<$Res> {
  factory _$GradeCopyWith(_Grade value, $Res Function(_Grade) _then) = __$GradeCopyWithImpl;
@override @useResult
$Res call({
 String gradeId, String studentId, String teacherId, String courseId, String? groupId, GradeSourceType sourceType, String? sourceId, num score, num maxScore, num percentage, String? comment,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, List<GradeHistoryEntry> history
});




}
/// @nodoc
class __$GradeCopyWithImpl<$Res>
    implements _$GradeCopyWith<$Res> {
  __$GradeCopyWithImpl(this._self, this._then);

  final _Grade _self;
  final $Res Function(_Grade) _then;

/// Create a copy of Grade
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gradeId = null,Object? studentId = null,Object? teacherId = null,Object? courseId = null,Object? groupId = freezed,Object? sourceType = null,Object? sourceId = freezed,Object? score = null,Object? maxScore = null,Object? percentage = null,Object? comment = freezed,Object? createdAt = null,Object? updatedAt = null,Object? history = null,}) {
  return _then(_Grade(
gradeId: null == gradeId ? _self.gradeId : gradeId // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,teacherId: null == teacherId ? _self.teacherId : teacherId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as GradeSourceType,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as num,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as num,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<GradeHistoryEntry>,
  ));
}


}

// dart format on
