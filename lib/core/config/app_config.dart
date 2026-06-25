import 'package:flutter/foundation.dart';

/// Окружение сборки. Выбирается отдельным entrypoint'ом (flavor):
/// `main.dart` → dev, `main_staging.dart` → staging, `main_prod.dart` → prod.
enum Environment { dev, staging, prod }

/// Конфигурация окружения, собирается в bootstrap по флейвору.
///
/// Единственная точка, где живут окружение-зависимые значения. Никакого
/// хардкода (хостов, флагов, имён) в коде фич — только через [AppConfig].
@immutable
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.useEmulators,
    required this.emulatorHost,
  });

  /// dev-конфиг: работает против Firebase Emulator Suite.
  factory AppConfig.dev() => AppConfig(
        environment: Environment.dev,
        appName: 'EduApp Dev',
        useEmulators: true,
        emulatorHost: resolveEmulatorHost(),
      );

  /// staging-конфиг: реальный Firebase проекта staging.
  factory AppConfig.staging() => AppConfig(
        environment: Environment.staging,
        appName: 'EduApp Staging',
        useEmulators: false,
        emulatorHost: resolveEmulatorHost(),
      );

  /// prod-конфиг: реальный Firebase проекта prod.
  factory AppConfig.prod() => const AppConfig(
        environment: Environment.prod,
        appName: 'EduApp',
        useEmulators: false,
        emulatorHost: 'localhost',
      );

  final Environment environment;
  final String appName;

  /// Использовать ли Firebase Emulator Suite вместо облака (шаг 3).
  final bool useEmulators;

  /// Хост эмуляторов. Зависит от платформы: web/desktop → `localhost`,
  /// Android-эмулятор видит хост-машину как `10.0.2.2`.
  final String emulatorHost;

  bool get isDev => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProd => environment == Environment.prod;

  @override
  String toString() =>
      'AppConfig(env: ${environment.name}, useEmulators: $useEmulators, '
      'emulatorHost: $emulatorHost)';
}

/// Определяет хост эмуляторов по платформе исполнения.
///
/// Android-эмулятор обращается к localhost хост-машины по адресу `10.0.2.2`;
/// web и десктоп используют `localhost`.
String resolveEmulatorHost() {
  if (kIsWeb) return 'localhost';
  if (defaultTargetPlatform == TargetPlatform.android) return '10.0.2.2';
  return 'localhost';
}
