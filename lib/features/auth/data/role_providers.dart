import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/user_role.dart';
import 'auth_providers.dart';

part 'role_providers.g.dart';

/// Текущая роль пользователя. Источник истины — `users.role` (через
/// [appUserProvider]). Серверная проверка — Security Rules (шаг 8).
@riverpod
UserRole? currentRole(Ref ref) =>
    ref.watch(appUserProvider).valueOrNull?.role;
