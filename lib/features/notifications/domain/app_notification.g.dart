// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      notificationId: json['notificationId'] as String,
      userId: json['userId'] as String? ?? '',
      type:
          $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']) ??
          NotificationType.system,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      payload:
          json['payload'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      isRead: json['isRead'] as bool? ?? false,
      createdAt: const NullableTimestampConverter().fromJson(
        json['createdAt'] as Timestamp?,
      ),
    );

Map<String, dynamic> _$AppNotificationToJson(
  _AppNotification instance,
) => <String, dynamic>{
  'notificationId': instance.notificationId,
  'userId': instance.userId,
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'title': instance.title,
  'body': instance.body,
  'payload': instance.payload,
  'isRead': instance.isRead,
  'createdAt': const NullableTimestampConverter().toJson(instance.createdAt),
};

const _$NotificationTypeEnumMap = {
  NotificationType.newCourse: 'newCourse',
  NotificationType.newWeek: 'newWeek',
  NotificationType.newAssignment: 'newAssignment',
  NotificationType.newQuiz: 'newQuiz',
  NotificationType.deadlineSoon: 'deadlineSoon',
  NotificationType.deadlineOverdue: 'deadlineOverdue',
  NotificationType.gradePosted: 'gradePosted',
  NotificationType.assignmentReturned: 'assignmentReturned',
  NotificationType.teacherComment: 'teacherComment',
  NotificationType.assignmentPublished: 'assignmentPublished',
  NotificationType.system: 'system',
};
