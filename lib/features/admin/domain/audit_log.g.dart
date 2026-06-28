// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuditLog _$AuditLogFromJson(Map<String, dynamic> json) => _AuditLog(
  auditId: json['auditId'] as String,
  userId: json['userId'] as String? ?? '',
  role: json['role'] as String? ?? '',
  actionType: json['actionType'] as String? ?? '',
  entityType: json['entityType'] as String? ?? '',
  entityId: json['entityId'] as String? ?? '',
  oldValue: json['oldValue'] as Map<String, dynamic>?,
  newValue: json['newValue'] as Map<String, dynamic>?,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$AuditLogToJson(_AuditLog instance) => <String, dynamic>{
  'auditId': instance.auditId,
  'userId': instance.userId,
  'role': instance.role,
  'actionType': instance.actionType,
  'entityType': instance.entityType,
  'entityId': instance.entityId,
  'oldValue': instance.oldValue,
  'newValue': instance.newValue,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
