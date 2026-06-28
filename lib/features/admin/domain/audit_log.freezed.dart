// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuditLog {

 String get auditId; String get userId; String get role; String get actionType; String get entityType; String get entityId; Map<String, dynamic>? get oldValue; Map<String, dynamic>? get newValue;@TimestampConverter() DateTime get createdAt;
/// Create a copy of AuditLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditLogCopyWith<AuditLog> get copyWith => _$AuditLogCopyWithImpl<AuditLog>(this as AuditLog, _$identity);

  /// Serializes this AuditLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditLog&&(identical(other.auditId, auditId) || other.auditId == auditId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&const DeepCollectionEquality().equals(other.oldValue, oldValue)&&const DeepCollectionEquality().equals(other.newValue, newValue)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,auditId,userId,role,actionType,entityType,entityId,const DeepCollectionEquality().hash(oldValue),const DeepCollectionEquality().hash(newValue),createdAt);

@override
String toString() {
  return 'AuditLog(auditId: $auditId, userId: $userId, role: $role, actionType: $actionType, entityType: $entityType, entityId: $entityId, oldValue: $oldValue, newValue: $newValue, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AuditLogCopyWith<$Res>  {
  factory $AuditLogCopyWith(AuditLog value, $Res Function(AuditLog) _then) = _$AuditLogCopyWithImpl;
@useResult
$Res call({
 String auditId, String userId, String role, String actionType, String entityType, String entityId, Map<String, dynamic>? oldValue, Map<String, dynamic>? newValue,@TimestampConverter() DateTime createdAt
});




}
/// @nodoc
class _$AuditLogCopyWithImpl<$Res>
    implements $AuditLogCopyWith<$Res> {
  _$AuditLogCopyWithImpl(this._self, this._then);

  final AuditLog _self;
  final $Res Function(AuditLog) _then;

/// Create a copy of AuditLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? auditId = null,Object? userId = null,Object? role = null,Object? actionType = null,Object? entityType = null,Object? entityId = null,Object? oldValue = freezed,Object? newValue = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
auditId: null == auditId ? _self.auditId : auditId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,oldValue: freezed == oldValue ? _self.oldValue : oldValue // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,newValue: freezed == newValue ? _self.newValue : newValue // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditLog].
extension AuditLogPatterns on AuditLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditLog value)  $default,){
final _that = this;
switch (_that) {
case _AuditLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditLog value)?  $default,){
final _that = this;
switch (_that) {
case _AuditLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String auditId,  String userId,  String role,  String actionType,  String entityType,  String entityId,  Map<String, dynamic>? oldValue,  Map<String, dynamic>? newValue, @TimestampConverter()  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditLog() when $default != null:
return $default(_that.auditId,_that.userId,_that.role,_that.actionType,_that.entityType,_that.entityId,_that.oldValue,_that.newValue,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String auditId,  String userId,  String role,  String actionType,  String entityType,  String entityId,  Map<String, dynamic>? oldValue,  Map<String, dynamic>? newValue, @TimestampConverter()  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AuditLog():
return $default(_that.auditId,_that.userId,_that.role,_that.actionType,_that.entityType,_that.entityId,_that.oldValue,_that.newValue,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String auditId,  String userId,  String role,  String actionType,  String entityType,  String entityId,  Map<String, dynamic>? oldValue,  Map<String, dynamic>? newValue, @TimestampConverter()  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AuditLog() when $default != null:
return $default(_that.auditId,_that.userId,_that.role,_that.actionType,_that.entityType,_that.entityId,_that.oldValue,_that.newValue,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditLog implements AuditLog {
  const _AuditLog({required this.auditId, this.userId = '', this.role = '', this.actionType = '', this.entityType = '', this.entityId = '', final  Map<String, dynamic>? oldValue, final  Map<String, dynamic>? newValue, @TimestampConverter() required this.createdAt}): _oldValue = oldValue,_newValue = newValue;
  factory _AuditLog.fromJson(Map<String, dynamic> json) => _$AuditLogFromJson(json);

@override final  String auditId;
@override@JsonKey() final  String userId;
@override@JsonKey() final  String role;
@override@JsonKey() final  String actionType;
@override@JsonKey() final  String entityType;
@override@JsonKey() final  String entityId;
 final  Map<String, dynamic>? _oldValue;
@override Map<String, dynamic>? get oldValue {
  final value = _oldValue;
  if (value == null) return null;
  if (_oldValue is EqualUnmodifiableMapView) return _oldValue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _newValue;
@override Map<String, dynamic>? get newValue {
  final value = _newValue;
  if (value == null) return null;
  if (_newValue is EqualUnmodifiableMapView) return _newValue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@TimestampConverter() final  DateTime createdAt;

/// Create a copy of AuditLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditLogCopyWith<_AuditLog> get copyWith => __$AuditLogCopyWithImpl<_AuditLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditLogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditLog&&(identical(other.auditId, auditId) || other.auditId == auditId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&const DeepCollectionEquality().equals(other._oldValue, _oldValue)&&const DeepCollectionEquality().equals(other._newValue, _newValue)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,auditId,userId,role,actionType,entityType,entityId,const DeepCollectionEquality().hash(_oldValue),const DeepCollectionEquality().hash(_newValue),createdAt);

@override
String toString() {
  return 'AuditLog(auditId: $auditId, userId: $userId, role: $role, actionType: $actionType, entityType: $entityType, entityId: $entityId, oldValue: $oldValue, newValue: $newValue, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AuditLogCopyWith<$Res> implements $AuditLogCopyWith<$Res> {
  factory _$AuditLogCopyWith(_AuditLog value, $Res Function(_AuditLog) _then) = __$AuditLogCopyWithImpl;
@override @useResult
$Res call({
 String auditId, String userId, String role, String actionType, String entityType, String entityId, Map<String, dynamic>? oldValue, Map<String, dynamic>? newValue,@TimestampConverter() DateTime createdAt
});




}
/// @nodoc
class __$AuditLogCopyWithImpl<$Res>
    implements _$AuditLogCopyWith<$Res> {
  __$AuditLogCopyWithImpl(this._self, this._then);

  final _AuditLog _self;
  final $Res Function(_AuditLog) _then;

/// Create a copy of AuditLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? auditId = null,Object? userId = null,Object? role = null,Object? actionType = null,Object? entityType = null,Object? entityId = null,Object? oldValue = freezed,Object? newValue = freezed,Object? createdAt = null,}) {
  return _then(_AuditLog(
auditId: null == auditId ? _self.auditId : auditId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,oldValue: freezed == oldValue ? _self._oldValue : oldValue // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,newValue: freezed == newValue ? _self._newValue : newValue // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
