import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/error_mapper.dart';
import '../../auth/domain/app_user.dart';
import '../../auth/domain/user_profile.dart';
import '../domain/admin_user_repository.dart';

/// Реализация [AdminUserRepository] поверх Firestore (только чтение).
///
/// Список фильтруется по роли на сервере и пагинируется курсором (ТЗ §10);
/// поиск по имени/email и скрытие удалённых довыполняются на странице (Firestore
/// не умеет полнотекст — префиксный поиск закрывает MVP-сценарий §10).
class FirestoreAdminUserRepository implements AdminUserRepository {
  FirestoreAdminUserRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');
  CollectionReference<Map<String, dynamic>> get _profiles =>
      _db.collection('profiles');

  AppUser _userFrom(DocumentSnapshot<Map<String, dynamic>> snap) =>
      AppUser.fromJson({...?snap.data(), 'uid': snap.id});

  @override
  Future<List<AdminUserRow>> fetchUsers({
    AdminUserFilters filters = const AdminUserFilters(),
    int limit = 20,
    String? startAfterId,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _users.orderBy('email');
      if (filters.role != null) {
        query = query.where('role', isEqualTo: filters.role!.code);
      }
      if (startAfterId != null) {
        final cursor = await _users.doc(startAfterId).get();
        if (cursor.exists) query = query.startAfterDocument(cursor);
      }
      final snap = await query.limit(limit).get();

      var users = snap.docs.map(_userFrom);
      if (!filters.includeDeleted) {
        users = users.where((u) => !u.deleted);
      }
      if (filters.status != null) {
        users = users.where((u) => u.status == filters.status);
      }
      final search = filters.search.trim().toLowerCase();
      if (search.isNotEmpty) {
        users = users.where((u) => u.email.toLowerCase().contains(search));
      }
      final userList = users.toList();

      // Догружаем профили страницы (имена/группы) одним проходом.
      final rows = <AdminUserRow>[];
      for (final user in userList) {
        final profileSnap = await _profiles.doc(user.uid).get();
        final profile = profileSnap.exists
            ? UserProfile.fromJson({...?profileSnap.data(), 'uid': user.uid})
            : null;
        if (search.isNotEmpty &&
            profile != null &&
            !user.email.toLowerCase().contains(search) &&
            !profile.fullName.toLowerCase().contains(search)) {
          continue;
        }
        rows.add(AdminUserRow(user: user, profile: profile));
      }
      return rows;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Stream<AdminUserRow?> watchUser(String uid) {
    // Реактивно следим за документом users; профиль подгружаем на каждое
    // изменение (карточка — не горячий путь, отдельный stream-merge не нужен).
    return _users.doc(uid).snapshots().asyncMap((u) async {
      if (!u.exists) return null;
      final user = _userFrom(u);
      final p = await _profiles.doc(uid).get();
      final profile =
          p.exists ? UserProfile.fromJson({...?p.data(), 'uid': uid}) : null;
      return AdminUserRow(user: user, profile: profile);
    }).mapFailures();
  }
}
