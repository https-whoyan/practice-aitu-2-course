// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_week.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseWeek {

 String get weekId; String get courseId; String get title; String get description; int get orderIndex;@NullableTimestampConverter() DateTime? get startDate;@NullableTimestampConverter() DateTime? get endDate; bool get isPublished;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;
/// Create a copy of CourseWeek
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseWeekCopyWith<CourseWeek> get copyWith => _$CourseWeekCopyWithImpl<CourseWeek>(this as CourseWeek, _$identity);

  /// Serializes this CourseWeek to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseWeek&&(identical(other.weekId, weekId) || other.weekId == weekId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekId,courseId,title,description,orderIndex,startDate,endDate,isPublished,createdAt,updatedAt);

@override
String toString() {
  return 'CourseWeek(weekId: $weekId, courseId: $courseId, title: $title, description: $description, orderIndex: $orderIndex, startDate: $startDate, endDate: $endDate, isPublished: $isPublished, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CourseWeekCopyWith<$Res>  {
  factory $CourseWeekCopyWith(CourseWeek value, $Res Function(CourseWeek) _then) = _$CourseWeekCopyWithImpl;
@useResult
$Res call({
 String weekId, String courseId, String title, String description, int orderIndex,@NullableTimestampConverter() DateTime? startDate,@NullableTimestampConverter() DateTime? endDate, bool isPublished,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class _$CourseWeekCopyWithImpl<$Res>
    implements $CourseWeekCopyWith<$Res> {
  _$CourseWeekCopyWithImpl(this._self, this._then);

  final CourseWeek _self;
  final $Res Function(CourseWeek) _then;

/// Create a copy of CourseWeek
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekId = null,Object? courseId = null,Object? title = null,Object? description = null,Object? orderIndex = null,Object? startDate = freezed,Object? endDate = freezed,Object? isPublished = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
weekId: null == weekId ? _self.weekId : weekId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseWeek].
extension CourseWeekPatterns on CourseWeek {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseWeek value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseWeek() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseWeek value)  $default,){
final _that = this;
switch (_that) {
case _CourseWeek():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseWeek value)?  $default,){
final _that = this;
switch (_that) {
case _CourseWeek() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String weekId,  String courseId,  String title,  String description,  int orderIndex, @NullableTimestampConverter()  DateTime? startDate, @NullableTimestampConverter()  DateTime? endDate,  bool isPublished, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseWeek() when $default != null:
return $default(_that.weekId,_that.courseId,_that.title,_that.description,_that.orderIndex,_that.startDate,_that.endDate,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String weekId,  String courseId,  String title,  String description,  int orderIndex, @NullableTimestampConverter()  DateTime? startDate, @NullableTimestampConverter()  DateTime? endDate,  bool isPublished, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CourseWeek():
return $default(_that.weekId,_that.courseId,_that.title,_that.description,_that.orderIndex,_that.startDate,_that.endDate,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String weekId,  String courseId,  String title,  String description,  int orderIndex, @NullableTimestampConverter()  DateTime? startDate, @NullableTimestampConverter()  DateTime? endDate,  bool isPublished, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CourseWeek() when $default != null:
return $default(_that.weekId,_that.courseId,_that.title,_that.description,_that.orderIndex,_that.startDate,_that.endDate,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseWeek implements CourseWeek {
  const _CourseWeek({required this.weekId, required this.courseId, this.title = '', this.description = '', this.orderIndex = 0, @NullableTimestampConverter() this.startDate, @NullableTimestampConverter() this.endDate, this.isPublished = false, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt});
  factory _CourseWeek.fromJson(Map<String, dynamic> json) => _$CourseWeekFromJson(json);

@override final  String weekId;
@override final  String courseId;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  int orderIndex;
@override@NullableTimestampConverter() final  DateTime? startDate;
@override@NullableTimestampConverter() final  DateTime? endDate;
@override@JsonKey() final  bool isPublished;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;

/// Create a copy of CourseWeek
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseWeekCopyWith<_CourseWeek> get copyWith => __$CourseWeekCopyWithImpl<_CourseWeek>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseWeekToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseWeek&&(identical(other.weekId, weekId) || other.weekId == weekId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekId,courseId,title,description,orderIndex,startDate,endDate,isPublished,createdAt,updatedAt);

@override
String toString() {
  return 'CourseWeek(weekId: $weekId, courseId: $courseId, title: $title, description: $description, orderIndex: $orderIndex, startDate: $startDate, endDate: $endDate, isPublished: $isPublished, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CourseWeekCopyWith<$Res> implements $CourseWeekCopyWith<$Res> {
  factory _$CourseWeekCopyWith(_CourseWeek value, $Res Function(_CourseWeek) _then) = __$CourseWeekCopyWithImpl;
@override @useResult
$Res call({
 String weekId, String courseId, String title, String description, int orderIndex,@NullableTimestampConverter() DateTime? startDate,@NullableTimestampConverter() DateTime? endDate, bool isPublished,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class __$CourseWeekCopyWithImpl<$Res>
    implements _$CourseWeekCopyWith<$Res> {
  __$CourseWeekCopyWithImpl(this._self, this._then);

  final _CourseWeek _self;
  final $Res Function(_CourseWeek) _then;

/// Create a copy of CourseWeek
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekId = null,Object? courseId = null,Object? title = null,Object? description = null,Object? orderIndex = null,Object? startDate = freezed,Object? endDate = freezed,Object? isPublished = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_CourseWeek(
weekId: null == weekId ? _self.weekId : weekId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
