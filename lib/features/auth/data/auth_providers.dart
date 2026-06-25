import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../domain/app_user.dart';
import '../domain/auth_repository.dart';
import '../domain/user_profile.dart';
import 'auth_repository.dart';
import 'user_providers.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => FirebaseAuthRepository(
      auth: ref.watch(firebaseAuthProvider),
      users: ref.watch(userRepositoryProvider),
    );

/// Источник истины авторизации — поток `authStateChanges()`.
/// На него реагируют роутер (redirect, шаг 8) и UI.
@Riverpod(keepAlive: true)
Stream<User?> authState(Ref ref) =>
    ref.watch(authRepositoryProvider).authStateChanges();

/// Текущий пользователь (системный документ `users`) по авторизации.
/// Вход для ролевых редиректов (шаг 8).
@Riverpod(keepAlive: true)
Stream<AppUser?> appUser(Ref ref) {
  final authUser = ref.watch(authStateProvider).valueOrNull;
  if (authUser == null) return Stream.value(null);
  return ref.watch(userRepositoryProvider).watchUser(authUser.uid);
}

/// Текущий профиль (редактируемые данные) по авторизации.
@Riverpod(keepAlive: true)
Stream<UserProfile?> appProfile(Ref ref) {
  final authUser = ref.watch(authStateProvider).valueOrNull;
  if (authUser == null) return Stream.value(null);
  return ref.watch(userRepositoryProvider).watchProfile(authUser.uid);
}
