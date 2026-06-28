import '../domain/app_notification.dart';

/// Доступ к in-app уведомлениям пользователя (коллекция `notifications`).
///
/// Клиент только читает свои документы и переключает `isRead` — создание
/// уведомлений на стороне Cloud Functions.
abstract class NotificationsRepository {
  /// Поток моих уведомлений (свежие сверху, не больше 100).
  Stream<List<AppNotification>> watchMine(String userId);

  /// Поток счётчика непрочитанных (для бейджа на иконке).
  Stream<int> watchUnreadCount(String userId);

  /// Отметить одно уведомление прочитанным.
  Future<void> markRead(String id);

  /// Отметить все мои уведомления прочитанными.
  Future<void> markAllRead(String userId);
}
