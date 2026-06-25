import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/app_config.dart';
import 'routing/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_mode_provider.dart';

/// Корневой виджет приложения: `MaterialApp.router` с go_router (шаг 4),
/// темой light/dark и переключателем темы через Riverpod (шаг 5).
class EduApp extends ConsumerWidget {
  const EduApp({super.key, required this.config});

  final AppConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    return MaterialApp.router(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
