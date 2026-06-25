import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_routes.dart';

part 'app_router.g.dart';

/// Провайдер корневого роутера приложения.
///
/// На шаге 4 — каркас с заглушками `/splash`, `/login`, `/home` и точкой
/// `redirect` для будущих ролевых guard'ов (шаг 8). Ветви навигации по ролям
/// (`StatefulShellRoute`) добавляются в шаге 9.
@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    // Точка интеграции ролевых guard'ов — наполняется в шаге 8.
    redirect: (context, state) => null,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const _StubScreen(
          title: 'Splash',
          subtitle: 'Загрузка…',
        ),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const _StubScreen(
          title: 'Вход',
          subtitle: 'Экран входа появится в шаге 7',
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const _StubScreen(
          title: 'Home',
          subtitle: 'Навигация по ролям появится в шагах 8–9',
        ),
      ),
    ],
    errorBuilder: (context, state) => _StubScreen(
      title: 'Маршрут не найден',
      subtitle: state.uri.toString(),
    ),
  );
}

/// Временная заглушка экрана (до UI-кита шага 5 и реальных экранов).
class _StubScreen extends StatelessWidget {
  const _StubScreen({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
