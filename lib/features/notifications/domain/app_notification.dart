import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'notification_type.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

/// In-app уведомление ← коллекция `notifications` (ТЗ §26).
///
/// Документы пишет Cloud Functions; клиент читает свои (`userId == uid`) и
/// может только переключать `isRead`. `docId` инжектится в `notificationId`.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String notificationId,
    @Default('') String userId,
    @Default(NotificationType.system) NotificationType type,
    @Default('') String title,
    @Default('') String body,
    @Default(<String, dynamic>{}) Map<String, dynamic> payload,
    @Default(false) bool isRead,
    @NullableTimestampConverter() DateTime? createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
