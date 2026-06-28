import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../../auth/data/auth_providers.dart';
import '../domain/app_notification.dart';
import 'firestore_notifications_repository.dart';
import 'notifications_repository.dart';

part 'notification_providers.g.dart';

/// Репозиторий in-app уведомлений.
@Riverpod(keepAlive: true)
NotificationsRepository notificationsRepository(Ref ref) =>
    FirestoreNotificationsRepository(ref.watch(firestoreProvider));

/// Мои уведомления (свежие сверху). Без авторизации — пустой список.
@riverpod
Stream<List<AppNotification>> myNotifications(Ref ref) {
  final uid = ref.watch(appUserProvider).valueOrNull?.uid;
  if (uid == null) return Stream.value(const []);
  return ref.watch(notificationsRepositoryProvider).watchMine(uid);
}

/// Счётчик непрочитанных (для бейджа). Без авторизации — 0.
@riverpod
Stream<int> unreadCount(Ref ref) {
  final uid = ref.watch(appUserProvider).valueOrNull?.uid;
  if (uid == null) return Stream.value(0);
  return ref.watch(notificationsRepositoryProvider).watchUnreadCount(uid);
}
