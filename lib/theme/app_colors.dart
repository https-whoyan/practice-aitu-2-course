import 'package:flutter/material.dart';

/// Базовая палитра приложения.
///
/// Большая часть цветов выводится из `seed` через `ColorScheme.fromSeed`
/// (Material 3). Здесь — seed и точечные семантические цвета, которых нет в
/// стандартной схеме (успех/предупреждение).
class AppColors {
  const AppColors._();

  /// Seed-цвет, из которого Material 3 строит светлую/тёмную схемы.
  static const Color seed = Color(0xFF4F46E5); // indigo

  // Семантические цвета (не покрываются ColorScheme).
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color info = Color(0xFF2563EB);
}
