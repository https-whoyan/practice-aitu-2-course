import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/app_config.dart';
import 'routing/app_router.dart';

/// Корневой виджет приложения.
///
/// `MaterialApp.router` с go_router (шаг 4). Тема light/dark подключается
/// в шаге 5 (`themeModeProvider` + `AppTheme`).
class EduApp extends ConsumerWidget {
  const EduApp({super.key, required this.config});

  final AppConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      routerConfig: router,
    );
  }
}
