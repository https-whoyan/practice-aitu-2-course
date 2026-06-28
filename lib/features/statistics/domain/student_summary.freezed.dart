// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudentSummary {

 String get studentId; int get totalGrades; int get gradedQuizzes; int get gradedAssignments; num get averagePercentage; num get averageQuizPercentage; int get overdueCount; int get upcomingCount; RiskLevel get riskLevel;@NullableTimestampConverter() DateTime? get updatedAt;
/// Create a copy of StudentSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentSummaryCopyWith<StudentSummary> get copyWith => _$StudentSummaryCopyWithImpl<StudentSummary>(this as StudentSummary, _$identity);

  /// Serializes this StudentSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentSummary&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.totalGrades, totalGrades) || other.totalGrades == totalGrades)&&(identical(other.gradedQuizzes, gradedQuizzes) || other.gradedQuizzes == gradedQuizzes)&&(identical(other.gradedAssignments, gradedAssignments) || other.gradedAssignments == gradedAssignments)&&(identical(other.averagePercentage, averagePercentage) || other.averagePercentage == averagePercentage)&&(identical(other.averageQuizPercentage, averageQuizPercentage) || other.averageQuizPercentage == averageQuizPercentage)&&(identical(other.overdueCount, overdueCount) || other.overdueCount == overdueCount)&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentId,totalGrades,gradedQuizzes,gradedAssignments,averagePercentage,averageQuizPercentage,overdueCount,upcomingCount,riskLevel,updatedAt);

@override
String toString() {
  return 'StudentSummary(studentId: $studentId, totalGrades: $totalGrades, gradedQuizzes: $gradedQuizzes, gradedAssignments: $gradedAssignments, averagePercentage: $averagePercentage, averageQuizPercentage: $averageQuizPercentage, overdueCount: $overdueCount, upcomingCount: $upcomingCount, riskLevel: $riskLevel, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $StudentSummaryCopyWith<$Res>  {
  factory $StudentSummaryCopyWith(StudentSummary value, $Res Function(StudentSummary) _then) = _$StudentSummaryCopyWithImpl;
@useResult
$Res call({
 String studentId, int totalGrades, int gradedQuizzes, int gradedAssignments, num averagePercentage, num averageQuizPercentage, int overdueCount, int upcomingCount, RiskLevel riskLevel,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$StudentSummaryCopyWithImpl<$Res>
    implements $StudentSummaryCopyWith<$Res> {
  _$StudentSummaryCopyWithImpl(this._self, this._then);

  final StudentSummary _self;
  final $Res Function(StudentSummary) _then;

/// Create a copy of StudentSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentId = null,Object? totalGrades = null,Object? gradedQuizzes = null,Object? gradedAssignments = null,Object? averagePercentage = null,Object? averageQuizPercentage = null,Object? overdueCount = null,Object? upcomingCount = null,Object? riskLevel = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,totalGrades: null == totalGrades ? _self.totalGrades : totalGrades // ignore: cast_nullable_to_non_nullable
as int,gradedQuizzes: null == gradedQuizzes ? _self.gradedQuizzes : gradedQuizzes // ignore: cast_nullable_to_non_nullable
as int,gradedAssignments: null == gradedAssignments ? _self.gradedAssignments : gradedAssignments // ignore: cast_nullable_to_non_nullable
as int,averagePercentage: null == averagePercentage ? _self.averagePercentage : averagePercentage // ignore: cast_nullable_to_non_nullable
as num,averageQuizPercentage: null == averageQuizPercentage ? _self.averageQuizPercentage : averageQuizPercentage // ignore: cast_nullable_to_non_nullable
as num,overdueCount: null == overdueCount ? _self.overdueCount : overdueCount // ignore: cast_nullable_to_non_nullable
as int,upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as RiskLevel,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentSummary].
extension StudentSummaryPatterns on StudentSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentSummary value)  $default,){
final _that = this;
switch (_that) {
case _StudentSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentSummary value)?  $default,){
final _that = this;
switch (_that) {
case _StudentSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String studentId,  int totalGrades,  int gradedQuizzes,  int gradedAssignments,  num averagePercentage,  num averageQuizPercentage,  int overdueCount,  int upcomingCount,  RiskLevel riskLevel, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentSummary() when $default != null:
return $default(_that.studentId,_that.totalGrades,_that.gradedQuizzes,_that.gradedAssignments,_that.averagePercentage,_that.averageQuizPercentage,_that.overdueCount,_that.upcomingCount,_that.riskLevel,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String studentId,  int totalGrades,  int gradedQuizzes,  int gradedAssignments,  num averagePercentage,  num averageQuizPercentage,  int overdueCount,  int upcomingCount,  RiskLevel riskLevel, @NullableTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _StudentSummary():
return $default(_that.studentId,_that.totalGrades,_that.gradedQuizzes,_that.gradedAssignments,_that.averagePercentage,_that.averageQuizPercentage,_that.overdueCount,_that.upcomingCount,_that.riskLevel,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String studentId,  int totalGrades,  int gradedQuizzes,  int gradedAssignments,  num averagePercentage,  num averageQuizPercentage,  int overdueCount,  int upcomingCount,  RiskLevel riskLevel, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _StudentSummary() when $default != null:
return $default(_that.studentId,_that.totalGrades,_that.gradedQuizzes,_that.gradedAssignments,_that.averagePercentage,_that.averageQuizPercentage,_that.overdueCount,_that.upcomingCount,_that.riskLevel,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudentSummary extends StudentSummary {
  const _StudentSummary({required this.studentId, this.totalGrades = 0, this.gradedQuizzes = 0, this.gradedAssignments = 0, this.averagePercentage = 0, this.averageQuizPercentage = 0, this.overdueCount = 0, this.upcomingCount = 0, this.riskLevel = RiskLevel.low, @NullableTimestampConverter() this.updatedAt}): super._();
  factory _StudentSummary.fromJson(Map<String, dynamic> json) => _$StudentSummaryFromJson(json);

@override final  String studentId;
@override@JsonKey() final  int totalGrades;
@override@JsonKey() final  int gradedQuizzes;
@override@JsonKey() final  int gradedAssignments;
@override@JsonKey() final  num averagePercentage;
@override@JsonKey() final  num averageQuizPercentage;
@override@JsonKey() final  int overdueCount;
@override@JsonKey() final  int upcomingCount;
@override@JsonKey() final  RiskLevel riskLevel;
@override@NullableTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of StudentSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentSummaryCopyWith<_StudentSummary> get copyWith => __$StudentSummaryCopyWithImpl<_StudentSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudentSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentSummary&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.totalGrades, totalGrades) || other.totalGrades == totalGrades)&&(identical(other.gradedQuizzes, gradedQuizzes) || other.gradedQuizzes == gradedQuizzes)&&(identical(other.gradedAssignments, gradedAssignments) || other.gradedAssignments == gradedAssignments)&&(identical(other.averagePercentage, averagePercentage) || other.averagePercentage == averagePercentage)&&(identical(other.averageQuizPercentage, averageQuizPercentage) || other.averageQuizPercentage == averageQuizPercentage)&&(identical(other.overdueCount, overdueCount) || other.overdueCount == overdueCount)&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentId,totalGrades,gradedQuizzes,gradedAssignments,averagePercentage,averageQuizPercentage,overdueCount,upcomingCount,riskLevel,updatedAt);

@override
String toString() {
  return 'StudentSummary(studentId: $studentId, totalGrades: $totalGrades, gradedQuizzes: $gradedQuizzes, gradedAssignments: $gradedAssignments, averagePercentage: $averagePercentage, averageQuizPercentage: $averageQuizPercentage, overdueCount: $overdueCount, upcomingCount: $upcomingCount, riskLevel: $riskLevel, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$StudentSummaryCopyWith<$Res> implements $StudentSummaryCopyWith<$Res> {
  factory _$StudentSummaryCopyWith(_StudentSummary value, $Res Function(_StudentSummary) _then) = __$StudentSummaryCopyWithImpl;
@override @useResult
$Res call({
 String studentId, int totalGrades, int gradedQuizzes, int gradedAssignments, num averagePercentage, num averageQuizPercentage, int overdueCount, int upcomingCount, RiskLevel riskLevel,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$StudentSummaryCopyWithImpl<$Res>
    implements _$StudentSummaryCopyWith<$Res> {
  __$StudentSummaryCopyWithImpl(this._self, this._then);

  final _StudentSummary _self;
  final $Res Function(_StudentSummary) _then;

/// Create a copy of StudentSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentId = null,Object? totalGrades = null,Object? gradedQuizzes = null,Object? gradedAssignments = null,Object? averagePercentage = null,Object? averageQuizPercentage = null,Object? overdueCount = null,Object? upcomingCount = null,Object? riskLevel = null,Object? updatedAt = freezed,}) {
  return _then(_StudentSummary(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,totalGrades: null == totalGrades ? _self.totalGrades : totalGrades // ignore: cast_nullable_to_non_nullable
as int,gradedQuizzes: null == gradedQuizzes ? _self.gradedQuizzes : gradedQuizzes // ignore: cast_nullable_to_non_nullable
as int,gradedAssignments: null == gradedAssignments ? _self.gradedAssignments : gradedAssignments // ignore: cast_nullable_to_non_nullable
as int,averagePercentage: null == averagePercentage ? _self.averagePercentage : averagePercentage // ignore: cast_nullable_to_non_nullable
as num,averageQuizPercentage: null == averageQuizPercentage ? _self.averageQuizPercentage : averageQuizPercentage // ignore: cast_nullable_to_non_nullable
as num,overdueCount: null == overdueCount ? _self.overdueCount : overdueCount // ignore: cast_nullable_to_non_nullable
as int,upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as RiskLevel,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
