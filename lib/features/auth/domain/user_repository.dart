import 'app_user.dart';
import 'user_profile.dart';

/// Контракт доступа к пользователю и профилю. Фичи зависят от этого интерфейса,
/// а не от `FirebaseFirestore` напрямую (эталон-шаблон из шага 4).
abstract interface class UserRepository {
  /// Стрим системного документа пользователя (`users/{uid}`).
  Stream<AppUser?> watchUser(String uid);

  /// Разовое чтение пользователя.
  Future<AppUser?> getUser(String uid);

  /// Стрим профиля (`profiles/{uid}`).
  Stream<UserProfile?> watchProfile(String uid);

  /// Атомарно создаёт пару `users` + `profiles` (чтобы не было пользователя
  /// без профиля). Используется при регистрации (шаг 7).
  Future<void> createUserWithProfile({
    required AppUser user,
    required UserProfile profile,
  });

  /// Обновляет редактируемый профиль.
  Future<void> updateProfile(UserProfile profile);

  /// Обновляет `lastLoginAt` (серверное время) при входе (ТЗ §5.1.2).
  Future<void> updateLastLogin(String uid);
}
