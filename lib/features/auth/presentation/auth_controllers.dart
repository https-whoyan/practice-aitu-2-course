import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/failure.dart';
import '../data/auth_providers.dart';
import '../data/user_providers.dart';

part 'auth_controllers.g.dart';

/// Контроллер экрана входа. Держит loading/ошибку через `AsyncValue`.
@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final auth = ref.read(authRepositoryProvider);
      await auth.signIn(email: email, password: password);

      // Логика входа (ТЗ §5.1.2): проверить статус и обновить lastLoginAt.
      final uid = auth.currentUser?.uid;
      if (uid == null) return;
      final users = ref.read(userRepositoryProvider);
      final appUser = await users.getUser(uid);
      if (appUser?.status.isBlocked ?? false) {
        await auth.signOut();
        throw const Failure.auth(
          message: 'Аккаунт заблокирован. Обратитесь к администратору.',
        );
      }
      await users.updateLastLogin(uid);
    });
  }
}

/// Контроллер экрана регистрации.
@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<void> build() {}

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).register(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
          ),
    );
  }
}

/// Контроллер восстановления пароля.
@riverpod
class ForgotPasswordController extends _$ForgotPasswordController {
  @override
  FutureOr<void> build() {}

  Future<void> sendReset(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).sendPasswordResetEmail(email),
    );
  }
}
