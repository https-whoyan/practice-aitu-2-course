import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../domain/app_user.dart';
import '../domain/user_profile.dart';
import '../domain/user_repository.dart';
import 'firestore_user_repository.dart';

part 'user_providers.g.dart';

/// Репозиторий пользователя поверх `firestoreProvider` (шаг 2).
@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) =>
    FirestoreUserRepository(ref.watch(firestoreProvider));

/// Стрим документа пользователя по `uid`.
/// «Текущий» пользователь (по авторизации) собирается в шаге 7 (`appUserProvider`).
@riverpod
Stream<AppUser?> userStream(Ref ref, String uid) =>
    ref.watch(userRepositoryProvider).watchUser(uid);

/// Стрим профиля по `uid`.
@riverpod
Stream<UserProfile?> profileStream(Ref ref, String uid) =>
    ref.watch(userRepositoryProvider).watchProfile(uid);
