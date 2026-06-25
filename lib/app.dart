import 'package:flutter/material.dart';

import 'core/config/app_config.dart';

/// Корневой виджет приложения.
///
/// На шаге 1 это минимальная заглушка. На шаге 4 заменяется на
/// `MaterialApp.router` с go_router, темой (шаг 5) и `ProviderScope`.
class EduApp extends StatelessWidget {
  const EduApp({super.key, required this.config});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(title: Text(config.appName)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(size: 64),
              const SizedBox(height: 16),
              Text(config.appName, style: Theme.of(context).textTheme.titleLarge),
              Text('окружение: ${config.environment.name}'),
              Text('эмуляторы: ${config.useEmulators ? "да" : "нет"}'),
            ],
          ),
        ),
      ),
    );
  }
}
