// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Course {

 String get courseId; String get title; String get description; String? get ownerTeacherId; List<String> get teacherIds; List<String> get groupIds; String? get coverUrl; CourseStatus get status;@NullableTimestampConverter() DateTime? get startDate;@NullableTimestampConverter() DateTime? get endDate;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;
/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseCopyWith<Course> get copyWith => _$CourseCopyWithImpl<Course>(this as Course, _$identity);

  /// Serializes this Course to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Course&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.ownerTeacherId, ownerTeacherId) || other.ownerTeacherId == ownerTeacherId)&&const DeepCollectionEquality().equals(other.teacherIds, teacherIds)&&const DeepCollectionEquality().equals(other.groupIds, groupIds)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseId,title,description,ownerTeacherId,const DeepCollectionEquality().hash(teacherIds),const DeepCollectionEquality().hash(groupIds),coverUrl,status,startDate,endDate,createdAt,updatedAt);

@override
String toString() {
  return 'Course(courseId: $courseId, title: $title, description: $description, ownerTeacherId: $ownerTeacherId, teacherIds: $teacherIds, groupIds: $groupIds, coverUrl: $coverUrl, status: $status, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CourseCopyWith<$Res>  {
  factory $CourseCopyWith(Course value, $Res Function(Course) _then) = _$CourseCopyWithImpl;
@useResult
$Res call({
 String courseId, String title, String description, String? ownerTeacherId, List<String> teacherIds, List<String> groupIds, String? coverUrl, CourseStatus status,@NullableTimestampConverter() DateTime? startDate,@NullableTimestampConverter() DateTime? endDate,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class _$CourseCopyWithImpl<$Res>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._self, this._then);

  final Course _self;
  final $Res Function(Course) _then;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseId = null,Object? title = null,Object? description = null,Object? ownerTeacherId = freezed,Object? teacherIds = null,Object? groupIds = null,Object? coverUrl = freezed,Object? status = null,Object? startDate = freezed,Object? endDate = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,ownerTeacherId: freezed == ownerTeacherId ? _self.ownerTeacherId : ownerTeacherId // ignore: cast_nullable_to_non_nullable
as String?,teacherIds: null == teacherIds ? _self.teacherIds : teacherIds // ignore: cast_nullable_to_non_nullable
as List<String>,groupIds: null == groupIds ? _self.groupIds : groupIds // ignore: cast_nullable_to_non_nullable
as List<String>,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CourseStatus,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Course].
extension CoursePatterns on Course {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Course value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Course() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Course value)  $default,){
final _that = this;
switch (_that) {
case _Course():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Course value)?  $default,){
final _that = this;
switch (_that) {
case _Course() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String courseId,  String title,  String description,  String? ownerTeacherId,  List<String> teacherIds,  List<String> groupIds,  String? coverUrl,  CourseStatus status, @NullableTimestampConverter()  DateTime? startDate, @NullableTimestampConverter()  DateTime? endDate, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Course() when $default != null:
return $default(_that.courseId,_that.title,_that.description,_that.ownerTeacherId,_that.teacherIds,_that.groupIds,_that.coverUrl,_that.status,_that.startDate,_that.endDate,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String courseId,  String title,  String description,  String? ownerTeacherId,  List<String> teacherIds,  List<String> groupIds,  String? coverUrl,  CourseStatus status, @NullableTimestampConverter()  DateTime? startDate, @NullableTimestampConverter()  DateTime? endDate, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Course():
return $default(_that.courseId,_that.title,_that.description,_that.ownerTeacherId,_that.teacherIds,_that.groupIds,_that.coverUrl,_that.status,_that.startDate,_that.endDate,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String courseId,  String title,  String description,  String? ownerTeacherId,  List<String> teacherIds,  List<String> groupIds,  String? coverUrl,  CourseStatus status, @NullableTimestampConverter()  DateTime? startDate, @NullableTimestampConverter()  DateTime? endDate, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Course() when $default != null:
return $default(_that.courseId,_that.title,_that.description,_that.ownerTeacherId,_that.teacherIds,_that.groupIds,_that.coverUrl,_that.status,_that.startDate,_that.endDate,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Course implements Course {
  const _Course({required this.courseId, this.title = '', this.description = '', this.ownerTeacherId, final  List<String> teacherIds = const <String>[], final  List<String> groupIds = const <String>[], this.coverUrl, this.status = CourseStatus.draft, @NullableTimestampConverter() this.startDate, @NullableTimestampConverter() this.endDate, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt}): _teacherIds = teacherIds,_groupIds = groupIds;
  factory _Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

@override final  String courseId;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override final  String? ownerTeacherId;
 final  List<String> _teacherIds;
@override@JsonKey() List<String> get teacherIds {
  if (_teacherIds is EqualUnmodifiableListView) return _teacherIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teacherIds);
}

 final  List<String> _groupIds;
@override@JsonKey() List<String> get groupIds {
  if (_groupIds is EqualUnmodifiableListView) return _groupIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groupIds);
}

@override final  String? coverUrl;
@override@JsonKey() final  CourseStatus status;
@override@NullableTimestampConverter() final  DateTime? startDate;
@override@NullableTimestampConverter() final  DateTime? endDate;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseCopyWith<_Course> get copyWith => __$CourseCopyWithImpl<_Course>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Course&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.ownerTeacherId, ownerTeacherId) || other.ownerTeacherId == ownerTeacherId)&&const DeepCollectionEquality().equals(other._teacherIds, _teacherIds)&&const DeepCollectionEquality().equals(other._groupIds, _groupIds)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseId,title,description,ownerTeacherId,const DeepCollectionEquality().hash(_teacherIds),const DeepCollectionEquality().hash(_groupIds),coverUrl,status,startDate,endDate,createdAt,updatedAt);

@override
String toString() {
  return 'Course(courseId: $courseId, title: $title, description: $description, ownerTeacherId: $ownerTeacherId, teacherIds: $teacherIds, groupIds: $groupIds, coverUrl: $coverUrl, status: $status, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CourseCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$CourseCopyWith(_Course value, $Res Function(_Course) _then) = __$CourseCopyWithImpl;
@override @useResult
$Res call({
 String courseId, String title, String description, String? ownerTeacherId, List<String> teacherIds, List<String> groupIds, String? coverUrl, CourseStatus status,@NullableTimestampConverter() DateTime? startDate,@NullableTimestampConverter() DateTime? endDate,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class __$CourseCopyWithImpl<$Res>
    implements _$CourseCopyWith<$Res> {
  __$CourseCopyWithImpl(this._self, this._then);

  final _Course _self;
  final $Res Function(_Course) _then;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseId = null,Object? title = null,Object? description = null,Object? ownerTeacherId = freezed,Object? teacherIds = null,Object? groupIds = null,Object? coverUrl = freezed,Object? status = null,Object? startDate = freezed,Object? endDate = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Course(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,ownerTeacherId: freezed == ownerTeacherId ? _self.ownerTeacherId : ownerTeacherId // ignore: cast_nullable_to_non_nullable
as String?,teacherIds: null == teacherIds ? _self._teacherIds : teacherIds // ignore: cast_nullable_to_non_nullable
as List<String>,groupIds: null == groupIds ? _self._groupIds : groupIds // ignore: cast_nullable_to_non_nullable
as List<String>,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CourseStatus,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
