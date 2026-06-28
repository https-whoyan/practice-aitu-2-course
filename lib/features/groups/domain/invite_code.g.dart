// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InviteCode _$InviteCodeFromJson(Map<String, dynamic> json) => _InviteCode(
  inviteId: json['inviteId'] as String,
  code: json['code'] as String,
  groupId: json['groupId'] as String,
  createdBy: json['createdBy'] as String?,
  expiresAt: const NullableTimestampConverter().fromJson(
    json['expiresAt'] as Timestamp?,
  ),
  maxUses: (json['maxUses'] as num?)?.toInt(),
  usedCount: (json['usedCount'] as num?)?.toInt() ?? 0,
  active: json['active'] as bool? ?? true,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$InviteCodeToJson(
  _InviteCode instance,
) => <String, dynamic>{
  'inviteId': instance.inviteId,
  'code': instance.code,
  'groupId': instance.groupId,
  'createdBy': instance.createdBy,
  'expiresAt': const NullableTimestampConverter().toJson(instance.expiresAt),
  'maxUses': instance.maxUses,
  'usedCount': instance.usedCount,
  'active': instance.active,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
