import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../../auth/domain/account_status.dart';
import '../../auth/domain/user_role.dart';
import '../domain/admin_user_repository.dart';
import 'firestore_admin_user_repository.dart';

part 'admin_user_providers.g.dart';

/// Репозиторий чтения пользователей для админки.
@Riverpod(keepAlive: true)
AdminUserRepository adminUserRepository(Ref ref) =>
    FirestoreAdminUserRepository(ref.watch(firestoreProvider));

/// Состояние фильтров/поиска списка пользователей.
@riverpod
class AdminUserFiltersController extends _$AdminUserFiltersController {
  @override
  AdminUserFilters build() => const AdminUserFilters();

  void setRole(UserRole? role) =>
      state = state.copyWith(role: role, clearRole: role == null);

  void setStatus(AccountStatus? status) =>
      state = state.copyWith(status: status, clearStatus: status == null);

  void setSearch(String search) => state = state.copyWith(search: search);

  void setIncludeDeleted(bool value) =>
      state = state.copyWith(includeDeleted: value);
}

/// Постраничный список пользователей с фильтрами и подгрузкой «ещё» (ТЗ §10).
@riverpod
class AdminUsersController extends _$AdminUsersController {
  static const int _pageSize = 20;
  bool _reachedEnd = false;

  @override
  Future<List<AdminUserRow>> build() async {
    _reachedEnd = false;
    final filters = ref.watch(adminUserFiltersControllerProvider);
    final page = await ref
        .read(adminUserRepositoryProvider)
        .fetchUsers(filters: filters, limit: _pageSize);
    _reachedEnd = page.length < _pageSize;
    return page;
  }

  bool get reachedEnd => _reachedEnd;

  /// Догружает следующую страницу (курсор по последнему uid).
  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || _reachedEnd) return;
    final filters = ref.read(adminUserFiltersControllerProvider);
    final next = await ref.read(adminUserRepositoryProvider).fetchUsers(
          filters: filters,
          limit: _pageSize,
          startAfterId: current.last.user.uid,
        );
    _reachedEnd = next.length < _pageSize;
    state = AsyncData([...current, ...next]);
  }
}

/// Отдельные списки преподавателей/студентов (роль фиксирована маршрутом).
@riverpod
Future<List<AdminUserRow>> adminUsersByRole(Ref ref, UserRole role) =>
    ref.read(adminUserRepositoryProvider).fetchUsers(
          filters: AdminUserFilters(role: role),
          limit: 50,
        );

/// Карточка одного пользователя (user + profile).
@riverpod
Stream<AdminUserRow?> adminUserById(Ref ref, String uid) =>
    ref.watch(adminUserRepositoryProvider).watchUser(uid);
