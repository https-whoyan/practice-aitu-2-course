import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/data/auth_providers.dart';
import '../features/auth/presentation/blocked_screen.dart';
import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/auth/presentation/verify_email_screen.dart';
import '../shared/navigation/role_routes.dart';
import '../shared/widgets/splash_screen.dart';
import '../shared/widgets/widget_gallery_screen.dart';
import 'app_routes.dart';
import 'role_guard.dart';

part 'app_router.g.dart';

/// Провайдер корневого роутера с ролевыми guard'ами.
///
/// Редирект централизован в `redirect` (одна точка навигационной защиты).
/// Ролевые деревья (`StatefulShellRoute`) с разделами-заглушками и
/// dashboard'ами наполняются в шаге 9.
@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  // Роутер пересчитывает redirect при изменении авторизации/профиля.
  final refresh = ValueNotifier<int>(0);
  ref
    ..listen(authStateProvider, (_, _) => refresh.value++)
    ..listen(appUserProvider, (_, _) => refresh.value++)
    ..onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: refresh,
    redirect: (context, state) => _redirect(ref, state.matchedLocation),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyEmail,
        builder: (context, state) => const VerifyEmailScreen(),
      ),
      GoRoute(
        path: AppRoutes.blocked,
        builder: (context, state) => const BlockedScreen(),
      ),
      // Ролевые навигационные деревья (StatefulShellRoute) с разделами-заглушками
      // и dashboard'ами: /admin, /teacher, /student.
      ...roleShellRoutes(),
      GoRoute(
        path: '/gallery',
        builder: (context, state) => const WidgetGalleryScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Маршрут не найден')),
      body: Center(child: Text(state.uri.toString())),
    ),
  );
}

/// Централизованная навигационная защита (ТЗ §3, §5.1.2, §8.1).
String? _redirect(Ref ref, String location) {
  final authAsync = ref.read(authStateProvider);

  // Авторизация ещё грузится → splash (чтобы не моргать редиректами).
  if (authAsync.isLoading && !authAsync.hasValue) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  final isAuthRoute = AppRoutes.publicRoutes.contains(location);
  final authUser = authAsync.valueOrNull;

  // Не залогинен → только auth-маршруты.
  if (authUser == null) {
    return isAuthRoute ? null : AppRoutes.login;
  }

  // Залогинен: ждём загрузки документа пользователя (роль/статус).
  final appUserAsync = ref.read(appUserProvider);
  final appUser = appUserAsync.valueOrNull;
  if (appUser == null) {
    // Документа ещё нет (загрузка/гонка сразу после регистрации) → splash.
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  // Заблокирован → экран-заглушка, дальше не пускаем.
  if (appUser.status.isBlocked) {
    return location == AppRoutes.blocked ? null : AppRoutes.blocked;
  }

  // Email не подтверждён → экран верификации (§5.1.4, P1-10). После
  // подтверждения CF переводит status → active, и гейт открывается.
  if (appUser.status.isPendingVerification) {
    return location == AppRoutes.verifyEmail ? null : AppRoutes.verifyEmail;
  }

  final home = homeRouteForRole(appUser.role);

  // С auth/splash/blocked — на свой корневой раздел.
  if (isAuthRoute ||
      location == AppRoutes.splash ||
      location == AppRoutes.blocked) {
    return home;
  }

  // Заход в чужой ролевой раздел → редирект на свой.
  if (isRoleSection(location) && !location.startsWith(home)) {
    return home;
  }

  return null;
}
