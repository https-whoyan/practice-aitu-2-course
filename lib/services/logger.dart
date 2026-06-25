import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Простой логгер поверх `dart:developer`.
///
/// Единая точка логирования; позже сюда подключается Crashlytics (Сессия 2).
/// В release-сборке debug/info-сообщения подавляются.
class AppLogger {
  const AppLogger._();

  static const String _name = 'eduapp';

  static void d(String message) {
    if (kReleaseMode) return;
    developer.log(message, name: _name, level: 500);
  }

  static void i(String message) {
    if (kReleaseMode) return;
    developer.log(message, name: _name, level: 800);
  }

  static void w(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(message,
        name: _name, level: 900, error: error, stackTrace: stackTrace);
  }

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(message,
        name: _name, level: 1000, error: error, stackTrace: stackTrace);
  }
}
