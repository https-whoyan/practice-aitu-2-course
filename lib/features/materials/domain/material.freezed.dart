// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'material.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseMaterial {

 String get materialId; String get courseId; String get weekId; String get title; String get description; CourseMaterialType get type; String? get url; String? get fileUrl; int get orderIndex; bool get isPublished;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;
/// Create a copy of CourseMaterial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseMaterialCopyWith<CourseMaterial> get copyWith => _$CourseMaterialCopyWithImpl<CourseMaterial>(this as CourseMaterial, _$identity);

  /// Serializes this CourseMaterial to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseMaterial&&(identical(other.materialId, materialId) || other.materialId == materialId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.weekId, weekId) || other.weekId == weekId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,materialId,courseId,weekId,title,description,type,url,fileUrl,orderIndex,isPublished,createdAt,updatedAt);

@override
String toString() {
  return 'CourseMaterial(materialId: $materialId, courseId: $courseId, weekId: $weekId, title: $title, description: $description, type: $type, url: $url, fileUrl: $fileUrl, orderIndex: $orderIndex, isPublished: $isPublished, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CourseMaterialCopyWith<$Res>  {
  factory $CourseMaterialCopyWith(CourseMaterial value, $Res Function(CourseMaterial) _then) = _$CourseMaterialCopyWithImpl;
@useResult
$Res call({
 String materialId, String courseId, String weekId, String title, String description, CourseMaterialType type, String? url, String? fileUrl, int orderIndex, bool isPublished,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class _$CourseMaterialCopyWithImpl<$Res>
    implements $CourseMaterialCopyWith<$Res> {
  _$CourseMaterialCopyWithImpl(this._self, this._then);

  final CourseMaterial _self;
  final $Res Function(CourseMaterial) _then;

/// Create a copy of CourseMaterial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? materialId = null,Object? courseId = null,Object? weekId = null,Object? title = null,Object? description = null,Object? type = null,Object? url = freezed,Object? fileUrl = freezed,Object? orderIndex = null,Object? isPublished = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
materialId: null == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,weekId: null == weekId ? _self.weekId : weekId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CourseMaterialType,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseMaterial].
extension CourseMaterialPatterns on CourseMaterial {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseMaterial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseMaterial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseMaterial value)  $default,){
final _that = this;
switch (_that) {
case _CourseMaterial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseMaterial value)?  $default,){
final _that = this;
switch (_that) {
case _CourseMaterial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String materialId,  String courseId,  String weekId,  String title,  String description,  CourseMaterialType type,  String? url,  String? fileUrl,  int orderIndex,  bool isPublished, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseMaterial() when $default != null:
return $default(_that.materialId,_that.courseId,_that.weekId,_that.title,_that.description,_that.type,_that.url,_that.fileUrl,_that.orderIndex,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String materialId,  String courseId,  String weekId,  String title,  String description,  CourseMaterialType type,  String? url,  String? fileUrl,  int orderIndex,  bool isPublished, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CourseMaterial():
return $default(_that.materialId,_that.courseId,_that.weekId,_that.title,_that.description,_that.type,_that.url,_that.fileUrl,_that.orderIndex,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String materialId,  String courseId,  String weekId,  String title,  String description,  CourseMaterialType type,  String? url,  String? fileUrl,  int orderIndex,  bool isPublished, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CourseMaterial() when $default != null:
return $default(_that.materialId,_that.courseId,_that.weekId,_that.title,_that.description,_that.type,_that.url,_that.fileUrl,_that.orderIndex,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseMaterial implements CourseMaterial {
  const _CourseMaterial({required this.materialId, required this.courseId, required this.weekId, this.title = '', this.description = '', this.type = CourseMaterialType.text, this.url, this.fileUrl, this.orderIndex = 0, this.isPublished = false, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt});
  factory _CourseMaterial.fromJson(Map<String, dynamic> json) => _$CourseMaterialFromJson(json);

@override final  String materialId;
@override final  String courseId;
@override final  String weekId;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  CourseMaterialType type;
@override final  String? url;
@override final  String? fileUrl;
@override@JsonKey() final  int orderIndex;
@override@JsonKey() final  bool isPublished;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;

/// Create a copy of CourseMaterial
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseMaterialCopyWith<_CourseMaterial> get copyWith => __$CourseMaterialCopyWithImpl<_CourseMaterial>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseMaterialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseMaterial&&(identical(other.materialId, materialId) || other.materialId == materialId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.weekId, weekId) || other.weekId == weekId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,materialId,courseId,weekId,title,description,type,url,fileUrl,orderIndex,isPublished,createdAt,updatedAt);

@override
String toString() {
  return 'CourseMaterial(materialId: $materialId, courseId: $courseId, weekId: $weekId, title: $title, description: $description, type: $type, url: $url, fileUrl: $fileUrl, orderIndex: $orderIndex, isPublished: $isPublished, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CourseMaterialCopyWith<$Res> implements $CourseMaterialCopyWith<$Res> {
  factory _$CourseMaterialCopyWith(_CourseMaterial value, $Res Function(_CourseMaterial) _then) = __$CourseMaterialCopyWithImpl;
@override @useResult
$Res call({
 String materialId, String courseId, String weekId, String title, String description, CourseMaterialType type, String? url, String? fileUrl, int orderIndex, bool isPublished,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class __$CourseMaterialCopyWithImpl<$Res>
    implements _$CourseMaterialCopyWith<$Res> {
  __$CourseMaterialCopyWithImpl(this._self, this._then);

  final _CourseMaterial _self;
  final $Res Function(_CourseMaterial) _then;

/// Create a copy of CourseMaterial
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? materialId = null,Object? courseId = null,Object? weekId = null,Object? title = null,Object? description = null,Object? type = null,Object? url = freezed,Object? fileUrl = freezed,Object? orderIndex = null,Object? isPublished = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_CourseMaterial(
materialId: null == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,weekId: null == weekId ? _self.weekId : weekId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CourseMaterialType,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
