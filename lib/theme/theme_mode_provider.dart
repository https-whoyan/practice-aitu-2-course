import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_provider.g.dart';

/// Текущий режим темы (system/light/dark).
///
/// Пока по умолчанию `system`; персист выбора (в профиль/`shared_preferences`)
/// добавим, когда появится профиль (шаги 6–7).
@riverpod
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() => ThemeMode.system;

  void set(ThemeMode mode) => state = mode;

  /// Переключение light ↔ dark (для кнопки в настройках/профиле).
  void toggle() {
    state = switch (state) {
      ThemeMode.dark => ThemeMode.light,
      _ => ThemeMode.dark,
    };
  }
}
