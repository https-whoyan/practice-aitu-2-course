import 'package:firebase_auth/firebase_auth.dart';

/// Контракт аутентификации (ТЗ §5.1). Источник истины авторизации — поток
/// [authStateChanges]; UI и роутер реагируют на него, а не дёргают
/// `currentUser` императивно.
abstract interface class AuthRepository {
  Stream<User?> authStateChanges();

  User? get currentUser;

  /// Регистрация: создаёт Firebase-аккаунт и пару `users`+`profiles` с ролью
  /// **student по умолчанию** (ТЗ §5.1.1), затем отправляет письмо-верификацию.
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<void> signIn({required String email, required String password});

  /// Восстановление пароля (ТЗ §5.1.3).
  Future<void> sendPasswordResetEmail(String email);

  /// Повторная отправка письма-верификации (ТЗ §5.1.4).
  Future<void> sendEmailVerification();

  /// Перечитывает пользователя и возвращает актуальный флаг подтверждения email.
  Future<bool> reloadAndCheckVerified();

  /// Выход (ТЗ §5.1.5).
  Future<void> signOut();
}
