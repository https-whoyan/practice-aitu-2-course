// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_attempt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizAttempt {

 String get attemptId; String get quizId; String get studentId; String? get courseId; List<QuestionSnapshotItem> get questionSnapshot; Map<String, dynamic> get answers;@NullableTimestampConverter() DateTime? get startedAt;@NullableTimestampConverter() DateTime? get finishedAt; num? get score; num get maxScore; num? get percentage; AttemptStatus get status; int get attemptNumber; Map<String, dynamic>? get revealed;
/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizAttemptCopyWith<QuizAttempt> get copyWith => _$QuizAttemptCopyWithImpl<QuizAttempt>(this as QuizAttempt, _$identity);

  /// Serializes this QuizAttempt to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizAttempt&&(identical(other.attemptId, attemptId) || other.attemptId == attemptId)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&const DeepCollectionEquality().equals(other.questionSnapshot, questionSnapshot)&&const DeepCollectionEquality().equals(other.answers, answers)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.score, score) || other.score == score)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.status, status) || other.status == status)&&(identical(other.attemptNumber, attemptNumber) || other.attemptNumber == attemptNumber)&&const DeepCollectionEquality().equals(other.revealed, revealed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attemptId,quizId,studentId,courseId,const DeepCollectionEquality().hash(questionSnapshot),const DeepCollectionEquality().hash(answers),startedAt,finishedAt,score,maxScore,percentage,status,attemptNumber,const DeepCollectionEquality().hash(revealed));

@override
String toString() {
  return 'QuizAttempt(attemptId: $attemptId, quizId: $quizId, studentId: $studentId, courseId: $courseId, questionSnapshot: $questionSnapshot, answers: $answers, startedAt: $startedAt, finishedAt: $finishedAt, score: $score, maxScore: $maxScore, percentage: $percentage, status: $status, attemptNumber: $attemptNumber, revealed: $revealed)';
}


}

/// @nodoc
abstract mixin class $QuizAttemptCopyWith<$Res>  {
  factory $QuizAttemptCopyWith(QuizAttempt value, $Res Function(QuizAttempt) _then) = _$QuizAttemptCopyWithImpl;
@useResult
$Res call({
 String attemptId, String quizId, String studentId, String? courseId, List<QuestionSnapshotItem> questionSnapshot, Map<String, dynamic> answers,@NullableTimestampConverter() DateTime? startedAt,@NullableTimestampConverter() DateTime? finishedAt, num? score, num maxScore, num? percentage, AttemptStatus status, int attemptNumber, Map<String, dynamic>? revealed
});




}
/// @nodoc
class _$QuizAttemptCopyWithImpl<$Res>
    implements $QuizAttemptCopyWith<$Res> {
  _$QuizAttemptCopyWithImpl(this._self, this._then);

  final QuizAttempt _self;
  final $Res Function(QuizAttempt) _then;

/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attemptId = null,Object? quizId = null,Object? studentId = null,Object? courseId = freezed,Object? questionSnapshot = null,Object? answers = null,Object? startedAt = freezed,Object? finishedAt = freezed,Object? score = freezed,Object? maxScore = null,Object? percentage = freezed,Object? status = null,Object? attemptNumber = null,Object? revealed = freezed,}) {
  return _then(_self.copyWith(
attemptId: null == attemptId ? _self.attemptId : attemptId // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,questionSnapshot: null == questionSnapshot ? _self.questionSnapshot : questionSnapshot // ignore: cast_nullable_to_non_nullable
as List<QuestionSnapshotItem>,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num?,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as num,percentage: freezed == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as num?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttemptStatus,attemptNumber: null == attemptNumber ? _self.attemptNumber : attemptNumber // ignore: cast_nullable_to_non_nullable
as int,revealed: freezed == revealed ? _self.revealed : revealed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizAttempt].
extension QuizAttemptPatterns on QuizAttempt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizAttempt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizAttempt value)  $default,){
final _that = this;
switch (_that) {
case _QuizAttempt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizAttempt value)?  $default,){
final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String attemptId,  String quizId,  String studentId,  String? courseId,  List<QuestionSnapshotItem> questionSnapshot,  Map<String, dynamic> answers, @NullableTimestampConverter()  DateTime? startedAt, @NullableTimestampConverter()  DateTime? finishedAt,  num? score,  num maxScore,  num? percentage,  AttemptStatus status,  int attemptNumber,  Map<String, dynamic>? revealed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
return $default(_that.attemptId,_that.quizId,_that.studentId,_that.courseId,_that.questionSnapshot,_that.answers,_that.startedAt,_that.finishedAt,_that.score,_that.maxScore,_that.percentage,_that.status,_that.attemptNumber,_that.revealed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String attemptId,  String quizId,  String studentId,  String? courseId,  List<QuestionSnapshotItem> questionSnapshot,  Map<String, dynamic> answers, @NullableTimestampConverter()  DateTime? startedAt, @NullableTimestampConverter()  DateTime? finishedAt,  num? score,  num maxScore,  num? percentage,  AttemptStatus status,  int attemptNumber,  Map<String, dynamic>? revealed)  $default,) {final _that = this;
switch (_that) {
case _QuizAttempt():
return $default(_that.attemptId,_that.quizId,_that.studentId,_that.courseId,_that.questionSnapshot,_that.answers,_that.startedAt,_that.finishedAt,_that.score,_that.maxScore,_that.percentage,_that.status,_that.attemptNumber,_that.revealed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String attemptId,  String quizId,  String studentId,  String? courseId,  List<QuestionSnapshotItem> questionSnapshot,  Map<String, dynamic> answers, @NullableTimestampConverter()  DateTime? startedAt, @NullableTimestampConverter()  DateTime? finishedAt,  num? score,  num maxScore,  num? percentage,  AttemptStatus status,  int attemptNumber,  Map<String, dynamic>? revealed)?  $default,) {final _that = this;
switch (_that) {
case _QuizAttempt() when $default != null:
return $default(_that.attemptId,_that.quizId,_that.studentId,_that.courseId,_that.questionSnapshot,_that.answers,_that.startedAt,_that.finishedAt,_that.score,_that.maxScore,_that.percentage,_that.status,_that.attemptNumber,_that.revealed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizAttempt implements QuizAttempt {
  const _QuizAttempt({required this.attemptId, this.quizId = '', this.studentId = '', this.courseId, final  List<QuestionSnapshotItem> questionSnapshot = const <QuestionSnapshotItem>[], final  Map<String, dynamic> answers = const <String, dynamic>{}, @NullableTimestampConverter() this.startedAt, @NullableTimestampConverter() this.finishedAt, this.score, this.maxScore = 0, this.percentage, this.status = AttemptStatus.inProgress, this.attemptNumber = 1, final  Map<String, dynamic>? revealed}): _questionSnapshot = questionSnapshot,_answers = answers,_revealed = revealed;
  factory _QuizAttempt.fromJson(Map<String, dynamic> json) => _$QuizAttemptFromJson(json);

@override final  String attemptId;
@override@JsonKey() final  String quizId;
@override@JsonKey() final  String studentId;
@override final  String? courseId;
 final  List<QuestionSnapshotItem> _questionSnapshot;
@override@JsonKey() List<QuestionSnapshotItem> get questionSnapshot {
  if (_questionSnapshot is EqualUnmodifiableListView) return _questionSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questionSnapshot);
}

 final  Map<String, dynamic> _answers;
@override@JsonKey() Map<String, dynamic> get answers {
  if (_answers is EqualUnmodifiableMapView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_answers);
}

@override@NullableTimestampConverter() final  DateTime? startedAt;
@override@NullableTimestampConverter() final  DateTime? finishedAt;
@override final  num? score;
@override@JsonKey() final  num maxScore;
@override final  num? percentage;
@override@JsonKey() final  AttemptStatus status;
@override@JsonKey() final  int attemptNumber;
 final  Map<String, dynamic>? _revealed;
@override Map<String, dynamic>? get revealed {
  final value = _revealed;
  if (value == null) return null;
  if (_revealed is EqualUnmodifiableMapView) return _revealed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizAttemptCopyWith<_QuizAttempt> get copyWith => __$QuizAttemptCopyWithImpl<_QuizAttempt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizAttemptToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizAttempt&&(identical(other.attemptId, attemptId) || other.attemptId == attemptId)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&const DeepCollectionEquality().equals(other._questionSnapshot, _questionSnapshot)&&const DeepCollectionEquality().equals(other._answers, _answers)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.score, score) || other.score == score)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.status, status) || other.status == status)&&(identical(other.attemptNumber, attemptNumber) || other.attemptNumber == attemptNumber)&&const DeepCollectionEquality().equals(other._revealed, _revealed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attemptId,quizId,studentId,courseId,const DeepCollectionEquality().hash(_questionSnapshot),const DeepCollectionEquality().hash(_answers),startedAt,finishedAt,score,maxScore,percentage,status,attemptNumber,const DeepCollectionEquality().hash(_revealed));

@override
String toString() {
  return 'QuizAttempt(attemptId: $attemptId, quizId: $quizId, studentId: $studentId, courseId: $courseId, questionSnapshot: $questionSnapshot, answers: $answers, startedAt: $startedAt, finishedAt: $finishedAt, score: $score, maxScore: $maxScore, percentage: $percentage, status: $status, attemptNumber: $attemptNumber, revealed: $revealed)';
}


}

/// @nodoc
abstract mixin class _$QuizAttemptCopyWith<$Res> implements $QuizAttemptCopyWith<$Res> {
  factory _$QuizAttemptCopyWith(_QuizAttempt value, $Res Function(_QuizAttempt) _then) = __$QuizAttemptCopyWithImpl;
@override @useResult
$Res call({
 String attemptId, String quizId, String studentId, String? courseId, List<QuestionSnapshotItem> questionSnapshot, Map<String, dynamic> answers,@NullableTimestampConverter() DateTime? startedAt,@NullableTimestampConverter() DateTime? finishedAt, num? score, num maxScore, num? percentage, AttemptStatus status, int attemptNumber, Map<String, dynamic>? revealed
});




}
/// @nodoc
class __$QuizAttemptCopyWithImpl<$Res>
    implements _$QuizAttemptCopyWith<$Res> {
  __$QuizAttemptCopyWithImpl(this._self, this._then);

  final _QuizAttempt _self;
  final $Res Function(_QuizAttempt) _then;

/// Create a copy of QuizAttempt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attemptId = null,Object? quizId = null,Object? studentId = null,Object? courseId = freezed,Object? questionSnapshot = null,Object? answers = null,Object? startedAt = freezed,Object? finishedAt = freezed,Object? score = freezed,Object? maxScore = null,Object? percentage = freezed,Object? status = null,Object? attemptNumber = null,Object? revealed = freezed,}) {
  return _then(_QuizAttempt(
attemptId: null == attemptId ? _self.attemptId : attemptId // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,questionSnapshot: null == questionSnapshot ? _self._questionSnapshot : questionSnapshot // ignore: cast_nullable_to_non_nullable
as List<QuestionSnapshotItem>,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as num?,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as num,percentage: freezed == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as num?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttemptStatus,attemptNumber: null == attemptNumber ? _self.attemptNumber : attemptNumber // ignore: cast_nullable_to_non_nullable
as int,revealed: freezed == revealed ? _self._revealed : revealed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
