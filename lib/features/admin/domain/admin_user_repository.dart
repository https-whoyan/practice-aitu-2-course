import '../../auth/domain/account_status.dart';
import '../../auth/domain/app_user.dart';
import '../../auth/domain/user_profile.dart';
import '../../auth/domain/user_role.dart';

/// Пользователь + его профиль для админских списков/карточек.
class AdminUserRow {
  const AdminUserRow({required this.user, this.profile});

  final AppUser user;
  final UserProfile? profile;

  String get displayName =>
      profile?.fullName.trim().isNotEmpty == true ? profile!.fullName : user.email;
}

/// Фильтры списка пользователей (роль/статус/поиск).
class AdminUserFilters {
  const AdminUserFilters({
    this.role,
    this.status,
    this.search = '',
    this.includeDeleted = false,
  });

  final UserRole? role;
  final AccountStatus? status;
  final String search;
  final bool includeDeleted;

  AdminUserFilters copyWith({
    UserRole? role,
    bool clearRole = false,
    AccountStatus? status,
    bool clearStatus = false,
    String? search,
    bool? includeDeleted,
  }) =>
      AdminUserFilters(
        role: clearRole ? null : (role ?? this.role),
        status: clearStatus ? null : (status ?? this.status),
        search: search ?? this.search,
        includeDeleted: includeDeleted ?? this.includeDeleted,
      );
}

/// Контракт чтения пользователей для админки (ТЗ §5.3.1–5.3.3, §10).
///
/// Только чтение: все мутации идут через Cloud Functions (шаг 10).
abstract class AdminUserRepository {
  /// Постраничный список пользователей с фильтрами (курсор по `startAfterId`).
  Future<List<AdminUserRow>> fetchUsers({
    AdminUserFilters filters = const AdminUserFilters(),
    int limit = 20,
    String? startAfterId,
  });

  /// Пользователь + профиль по uid (карточка).
  Stream<AdminUserRow?> watchUser(String uid);
}
