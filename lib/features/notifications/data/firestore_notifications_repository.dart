import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/app_notification.dart';
import 'notifications_repository.dart';

/// Реализация [NotificationsRepository] поверх Firestore. Ошибки → `Failure`.
class FirestoreNotificationsRepository implements NotificationsRepository {
  FirestoreNotificationsRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<AppNotification> get _notifications =>
      _db.collection('notifications').withConverter<AppNotification>(
            fromFirestore: (snap, _) => AppNotification.fromJson(
              {...?snap.data(), 'notificationId': snap.id},
            ),
            toFirestore: (n, _) => n.toJson()..remove('notificationId'),
          );

  @override
  Stream<List<AppNotification>> watchMine(String userId) => _notifications
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .limit(100)
      .snapshots()
      .map((s) => s.docs.map((d) => d.data()).toList())
      .mapFailures();

  @override
  Stream<int> watchUnreadCount(String userId) => _notifications
      .where('userId', isEqualTo: userId)
      .where('isRead', isEqualTo: false)
      .snapshots()
      .map((s) => s.docs.length)
      .mapFailures();

  @override
  Future<void> markRead(String id) async {
    try {
      await _db
          .collection('notifications')
          .doc(id)
          .update({'isRead': true});
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> markAllRead(String userId) async {
    try {
      final unread = await _db
          .collection('notifications')
          .where('userId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();
      if (unread.docs.isEmpty) return;
      final batch = _db.batch();
      for (final doc in unread.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      await batch.commit();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
