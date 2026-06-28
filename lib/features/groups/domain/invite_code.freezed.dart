// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InviteCode {

 String get inviteId; String get code; String get groupId; String? get createdBy;@NullableTimestampConverter() DateTime? get expiresAt; int? get maxUses; int get usedCount; bool get active;@TimestampConverter() DateTime get createdAt;
/// Create a copy of InviteCode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteCodeCopyWith<InviteCode> get copyWith => _$InviteCodeCopyWithImpl<InviteCode>(this as InviteCode, _$identity);

  /// Serializes this InviteCode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteCode&&(identical(other.inviteId, inviteId) || other.inviteId == inviteId)&&(identical(other.code, code) || other.code == code)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.usedCount, usedCount) || other.usedCount == usedCount)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inviteId,code,groupId,createdBy,expiresAt,maxUses,usedCount,active,createdAt);

@override
String toString() {
  return 'InviteCode(inviteId: $inviteId, code: $code, groupId: $groupId, createdBy: $createdBy, expiresAt: $expiresAt, maxUses: $maxUses, usedCount: $usedCount, active: $active, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InviteCodeCopyWith<$Res>  {
  factory $InviteCodeCopyWith(InviteCode value, $Res Function(InviteCode) _then) = _$InviteCodeCopyWithImpl;
@useResult
$Res call({
 String inviteId, String code, String groupId, String? createdBy,@NullableTimestampConverter() DateTime? expiresAt, int? maxUses, int usedCount, bool active,@TimestampConverter() DateTime createdAt
});




}
/// @nodoc
class _$InviteCodeCopyWithImpl<$Res>
    implements $InviteCodeCopyWith<$Res> {
  _$InviteCodeCopyWithImpl(this._self, this._then);

  final InviteCode _self;
  final $Res Function(InviteCode) _then;

/// Create a copy of InviteCode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inviteId = null,Object? code = null,Object? groupId = null,Object? createdBy = freezed,Object? expiresAt = freezed,Object? maxUses = freezed,Object? usedCount = null,Object? active = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
inviteId: null == inviteId ? _self.inviteId : inviteId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,usedCount: null == usedCount ? _self.usedCount : usedCount // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteCode].
extension InviteCodePatterns on InviteCode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteCode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteCode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteCode value)  $default,){
final _that = this;
switch (_that) {
case _InviteCode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteCode value)?  $default,){
final _that = this;
switch (_that) {
case _InviteCode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String inviteId,  String code,  String groupId,  String? createdBy, @NullableTimestampConverter()  DateTime? expiresAt,  int? maxUses,  int usedCount,  bool active, @TimestampConverter()  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteCode() when $default != null:
return $default(_that.inviteId,_that.code,_that.groupId,_that.createdBy,_that.expiresAt,_that.maxUses,_that.usedCount,_that.active,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String inviteId,  String code,  String groupId,  String? createdBy, @NullableTimestampConverter()  DateTime? expiresAt,  int? maxUses,  int usedCount,  bool active, @TimestampConverter()  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _InviteCode():
return $default(_that.inviteId,_that.code,_that.groupId,_that.createdBy,_that.expiresAt,_that.maxUses,_that.usedCount,_that.active,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String inviteId,  String code,  String groupId,  String? createdBy, @NullableTimestampConverter()  DateTime? expiresAt,  int? maxUses,  int usedCount,  bool active, @TimestampConverter()  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InviteCode() when $default != null:
return $default(_that.inviteId,_that.code,_that.groupId,_that.createdBy,_that.expiresAt,_that.maxUses,_that.usedCount,_that.active,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteCode implements InviteCode {
  const _InviteCode({required this.inviteId, required this.code, required this.groupId, this.createdBy, @NullableTimestampConverter() this.expiresAt, this.maxUses, this.usedCount = 0, this.active = true, @TimestampConverter() required this.createdAt});
  factory _InviteCode.fromJson(Map<String, dynamic> json) => _$InviteCodeFromJson(json);

@override final  String inviteId;
@override final  String code;
@override final  String groupId;
@override final  String? createdBy;
@override@NullableTimestampConverter() final  DateTime? expiresAt;
@override final  int? maxUses;
@override@JsonKey() final  int usedCount;
@override@JsonKey() final  bool active;
@override@TimestampConverter() final  DateTime createdAt;

/// Create a copy of InviteCode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteCodeCopyWith<_InviteCode> get copyWith => __$InviteCodeCopyWithImpl<_InviteCode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteCodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteCode&&(identical(other.inviteId, inviteId) || other.inviteId == inviteId)&&(identical(other.code, code) || other.code == code)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.usedCount, usedCount) || other.usedCount == usedCount)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inviteId,code,groupId,createdBy,expiresAt,maxUses,usedCount,active,createdAt);

@override
String toString() {
  return 'InviteCode(inviteId: $inviteId, code: $code, groupId: $groupId, createdBy: $createdBy, expiresAt: $expiresAt, maxUses: $maxUses, usedCount: $usedCount, active: $active, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InviteCodeCopyWith<$Res> implements $InviteCodeCopyWith<$Res> {
  factory _$InviteCodeCopyWith(_InviteCode value, $Res Function(_InviteCode) _then) = __$InviteCodeCopyWithImpl;
@override @useResult
$Res call({
 String inviteId, String code, String groupId, String? createdBy,@NullableTimestampConverter() DateTime? expiresAt, int? maxUses, int usedCount, bool active,@TimestampConverter() DateTime createdAt
});




}
/// @nodoc
class __$InviteCodeCopyWithImpl<$Res>
    implements _$InviteCodeCopyWith<$Res> {
  __$InviteCodeCopyWithImpl(this._self, this._then);

  final _InviteCode _self;
  final $Res Function(_InviteCode) _then;

/// Create a copy of InviteCode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inviteId = null,Object? code = null,Object? groupId = null,Object? createdBy = freezed,Object? expiresAt = freezed,Object? maxUses = freezed,Object? usedCount = null,Object? active = null,Object? createdAt = null,}) {
  return _then(_InviteCode(
inviteId: null == inviteId ? _self.inviteId : inviteId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,usedCount: null == usedCount ? _self.usedCount : usedCount // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
