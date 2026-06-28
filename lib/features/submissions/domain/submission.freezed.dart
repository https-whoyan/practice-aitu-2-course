// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Submission {

 String get submissionId; String get assignmentId; String get courseId; String get studentId; String? get textAnswer; List<String> get fileUrls; String? get linkAnswer; SubmissionStatus get status;@NullableTimestampConverter() DateTime? get submittedAt;@TimestampConverter() DateTime get updatedAt; String? get teacherComment; String? get gradeId;
/// Create a copy of Submission
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmissionCopyWith<Submission> get copyWith => _$SubmissionCopyWithImpl<Submission>(this as Submission, _$identity);

  /// Serializes this Submission to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Submission&&(identical(other.submissionId, submissionId) || other.submissionId == submissionId)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.textAnswer, textAnswer) || other.textAnswer == textAnswer)&&const DeepCollectionEquality().equals(other.fileUrls, fileUrls)&&(identical(other.linkAnswer, linkAnswer) || other.linkAnswer == linkAnswer)&&(identical(other.status, status) || other.status == status)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.teacherComment, teacherComment) || other.teacherComment == teacherComment)&&(identical(other.gradeId, gradeId) || other.gradeId == gradeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,submissionId,assignmentId,courseId,studentId,textAnswer,const DeepCollectionEquality().hash(fileUrls),linkAnswer,status,submittedAt,updatedAt,teacherComment,gradeId);

@override
String toString() {
  return 'Submission(submissionId: $submissionId, assignmentId: $assignmentId, courseId: $courseId, studentId: $studentId, textAnswer: $textAnswer, fileUrls: $fileUrls, linkAnswer: $linkAnswer, status: $status, submittedAt: $submittedAt, updatedAt: $updatedAt, teacherComment: $teacherComment, gradeId: $gradeId)';
}


}

/// @nodoc
abstract mixin class $SubmissionCopyWith<$Res>  {
  factory $SubmissionCopyWith(Submission value, $Res Function(Submission) _then) = _$SubmissionCopyWithImpl;
@useResult
$Res call({
 String submissionId, String assignmentId, String courseId, String studentId, String? textAnswer, List<String> fileUrls, String? linkAnswer, SubmissionStatus status,@NullableTimestampConverter() DateTime? submittedAt,@TimestampConverter() DateTime updatedAt, String? teacherComment, String? gradeId
});




}
/// @nodoc
class _$SubmissionCopyWithImpl<$Res>
    implements $SubmissionCopyWith<$Res> {
  _$SubmissionCopyWithImpl(this._self, this._then);

  final Submission _self;
  final $Res Function(Submission) _then;

/// Create a copy of Submission
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? submissionId = null,Object? assignmentId = null,Object? courseId = null,Object? studentId = null,Object? textAnswer = freezed,Object? fileUrls = null,Object? linkAnswer = freezed,Object? status = null,Object? submittedAt = freezed,Object? updatedAt = null,Object? teacherComment = freezed,Object? gradeId = freezed,}) {
  return _then(_self.copyWith(
submissionId: null == submissionId ? _self.submissionId : submissionId // ignore: cast_nullable_to_non_nullable
as String,assignmentId: null == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,textAnswer: freezed == textAnswer ? _self.textAnswer : textAnswer // ignore: cast_nullable_to_non_nullable
as String?,fileUrls: null == fileUrls ? _self.fileUrls : fileUrls // ignore: cast_nullable_to_non_nullable
as List<String>,linkAnswer: freezed == linkAnswer ? _self.linkAnswer : linkAnswer // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,teacherComment: freezed == teacherComment ? _self.teacherComment : teacherComment // ignore: cast_nullable_to_non_nullable
as String?,gradeId: freezed == gradeId ? _self.gradeId : gradeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Submission].
extension SubmissionPatterns on Submission {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Submission value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Submission() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Submission value)  $default,){
final _that = this;
switch (_that) {
case _Submission():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Submission value)?  $default,){
final _that = this;
switch (_that) {
case _Submission() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String submissionId,  String assignmentId,  String courseId,  String studentId,  String? textAnswer,  List<String> fileUrls,  String? linkAnswer,  SubmissionStatus status, @NullableTimestampConverter()  DateTime? submittedAt, @TimestampConverter()  DateTime updatedAt,  String? teacherComment,  String? gradeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Submission() when $default != null:
return $default(_that.submissionId,_that.assignmentId,_that.courseId,_that.studentId,_that.textAnswer,_that.fileUrls,_that.linkAnswer,_that.status,_that.submittedAt,_that.updatedAt,_that.teacherComment,_that.gradeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String submissionId,  String assignmentId,  String courseId,  String studentId,  String? textAnswer,  List<String> fileUrls,  String? linkAnswer,  SubmissionStatus status, @NullableTimestampConverter()  DateTime? submittedAt, @TimestampConverter()  DateTime updatedAt,  String? teacherComment,  String? gradeId)  $default,) {final _that = this;
switch (_that) {
case _Submission():
return $default(_that.submissionId,_that.assignmentId,_that.courseId,_that.studentId,_that.textAnswer,_that.fileUrls,_that.linkAnswer,_that.status,_that.submittedAt,_that.updatedAt,_that.teacherComment,_that.gradeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String submissionId,  String assignmentId,  String courseId,  String studentId,  String? textAnswer,  List<String> fileUrls,  String? linkAnswer,  SubmissionStatus status, @NullableTimestampConverter()  DateTime? submittedAt, @TimestampConverter()  DateTime updatedAt,  String? teacherComment,  String? gradeId)?  $default,) {final _that = this;
switch (_that) {
case _Submission() when $default != null:
return $default(_that.submissionId,_that.assignmentId,_that.courseId,_that.studentId,_that.textAnswer,_that.fileUrls,_that.linkAnswer,_that.status,_that.submittedAt,_that.updatedAt,_that.teacherComment,_that.gradeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Submission extends Submission {
  const _Submission({required this.submissionId, required this.assignmentId, required this.courseId, required this.studentId, this.textAnswer, final  List<String> fileUrls = const <String>[], this.linkAnswer, this.status = SubmissionStatus.draft, @NullableTimestampConverter() this.submittedAt, @TimestampConverter() required this.updatedAt, this.teacherComment, this.gradeId}): _fileUrls = fileUrls,super._();
  factory _Submission.fromJson(Map<String, dynamic> json) => _$SubmissionFromJson(json);

@override final  String submissionId;
@override final  String assignmentId;
@override final  String courseId;
@override final  String studentId;
@override final  String? textAnswer;
 final  List<String> _fileUrls;
@override@JsonKey() List<String> get fileUrls {
  if (_fileUrls is EqualUnmodifiableListView) return _fileUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fileUrls);
}

@override final  String? linkAnswer;
@override@JsonKey() final  SubmissionStatus status;
@override@NullableTimestampConverter() final  DateTime? submittedAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String? teacherComment;
@override final  String? gradeId;

/// Create a copy of Submission
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmissionCopyWith<_Submission> get copyWith => __$SubmissionCopyWithImpl<_Submission>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubmissionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submission&&(identical(other.submissionId, submissionId) || other.submissionId == submissionId)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.textAnswer, textAnswer) || other.textAnswer == textAnswer)&&const DeepCollectionEquality().equals(other._fileUrls, _fileUrls)&&(identical(other.linkAnswer, linkAnswer) || other.linkAnswer == linkAnswer)&&(identical(other.status, status) || other.status == status)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.teacherComment, teacherComment) || other.teacherComment == teacherComment)&&(identical(other.gradeId, gradeId) || other.gradeId == gradeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,submissionId,assignmentId,courseId,studentId,textAnswer,const DeepCollectionEquality().hash(_fileUrls),linkAnswer,status,submittedAt,updatedAt,teacherComment,gradeId);

@override
String toString() {
  return 'Submission(submissionId: $submissionId, assignmentId: $assignmentId, courseId: $courseId, studentId: $studentId, textAnswer: $textAnswer, fileUrls: $fileUrls, linkAnswer: $linkAnswer, status: $status, submittedAt: $submittedAt, updatedAt: $updatedAt, teacherComment: $teacherComment, gradeId: $gradeId)';
}


}

/// @nodoc
abstract mixin class _$SubmissionCopyWith<$Res> implements $SubmissionCopyWith<$Res> {
  factory _$SubmissionCopyWith(_Submission value, $Res Function(_Submission) _then) = __$SubmissionCopyWithImpl;
@override @useResult
$Res call({
 String submissionId, String assignmentId, String courseId, String studentId, String? textAnswer, List<String> fileUrls, String? linkAnswer, SubmissionStatus status,@NullableTimestampConverter() DateTime? submittedAt,@TimestampConverter() DateTime updatedAt, String? teacherComment, String? gradeId
});




}
/// @nodoc
class __$SubmissionCopyWithImpl<$Res>
    implements _$SubmissionCopyWith<$Res> {
  __$SubmissionCopyWithImpl(this._self, this._then);

  final _Submission _self;
  final $Res Function(_Submission) _then;

/// Create a copy of Submission
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? submissionId = null,Object? assignmentId = null,Object? courseId = null,Object? studentId = null,Object? textAnswer = freezed,Object? fileUrls = null,Object? linkAnswer = freezed,Object? status = null,Object? submittedAt = freezed,Object? updatedAt = null,Object? teacherComment = freezed,Object? gradeId = freezed,}) {
  return _then(_Submission(
submissionId: null == submissionId ? _self.submissionId : submissionId // ignore: cast_nullable_to_non_nullable
as String,assignmentId: null == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,textAnswer: freezed == textAnswer ? _self.textAnswer : textAnswer // ignore: cast_nullable_to_non_nullable
as String?,fileUrls: null == fileUrls ? _self._fileUrls : fileUrls // ignore: cast_nullable_to_non_nullable
as List<String>,linkAnswer: freezed == linkAnswer ? _self.linkAnswer : linkAnswer // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,teacherComment: freezed == teacherComment ? _self.teacherComment : teacherComment // ignore: cast_nullable_to_non_nullable
as String?,gradeId: freezed == gradeId ? _self.gradeId : gradeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
