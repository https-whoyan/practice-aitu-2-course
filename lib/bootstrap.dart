import 'package:flutter/material.dart';

import 'app.dart';
import 'core/config/app_config.dart';

/// Единая точка старта приложения для всех флейворов.
///
/// Каждый entrypoint (`main.dart` / `main_staging.dart` / `main_prod.dart`)
/// собирает свой [AppConfig] и передаёт сюда. На следующих шагах здесь же
/// инициализируется Firebase (шаг 2), подключаются эмуляторы (шаг 3) и
/// оборачивается `ProviderScope` (шаг 4).
Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(EduApp(config: config));
}
