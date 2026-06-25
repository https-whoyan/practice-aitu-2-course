import 'package:flutter/material.dart';

/// Типографика. Базируется на Material 3 `TextTheme`; здесь — единая точка
/// настройки семейства шрифта и точечных стилей.
class AppTextStyles {
  const AppTextStyles._();

  /// Базовая `TextTheme` для светлой/тёмной темы. Цвета подставляет Material
  /// из `ColorScheme`, поэтому здесь только размеры/начертания.
  static TextTheme textTheme(TextTheme base) {
    return base.copyWith(
      headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
      titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
