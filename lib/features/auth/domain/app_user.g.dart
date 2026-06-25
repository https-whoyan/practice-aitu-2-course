// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  uid: json['uid'] as String,
  email: json['email'] as String,
  role:
      $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.student,
  status:
      $enumDecodeNullable(_$AccountStatusEnumMap, json['status']) ??
      AccountStatus.pendingVerification,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  lastLoginAt: const NullableTimestampConverter().fromJson(
    json['lastLoginAt'] as Timestamp?,
  ),
  emailVerified: json['emailVerified'] as bool? ?? false,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'role': _$UserRoleEnumMap[instance.role]!,
  'status': _$AccountStatusEnumMap[instance.status]!,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'lastLoginAt': const NullableTimestampConverter().toJson(
    instance.lastLoginAt,
  ),
  'emailVerified': instance.emailVerified,
};

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.teacher: 'teacher',
  UserRole.student: 'student',
};

const _$AccountStatusEnumMap = {
  AccountStatus.active: 'active',
  AccountStatus.blocked: 'blocked',
  AccountStatus.pendingVerification: 'pendingVerification',
};
