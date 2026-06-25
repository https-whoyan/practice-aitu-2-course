import 'package:flutter/widgets.dart';

/// Токены отступов. Единый ритм вертикали/горизонтали — никаких «магических»
/// чисел в экранах (ТЗ §15).
class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  // Частые готовые отступы (чтобы не плодить SizedBox с числами).
  static const Widget gapXs = SizedBox(width: xs, height: xs);
  static const Widget gapSm = SizedBox(width: sm, height: sm);
  static const Widget gapMd = SizedBox(width: md, height: md);
  static const Widget gapLg = SizedBox(width: lg, height: lg);
  static const Widget gapXl = SizedBox(width: xl, height: xl);
}

/// Токены радиусов скругления.
class AppRadius {
  const AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double pill = 999;

  static const BorderRadius brSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius brMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius brLg = BorderRadius.all(Radius.circular(lg));
}

/// Прочие размерные токены.
class AppSizes {
  const AppSizes._();

  /// Максимальная ширина контентной колонки на широких экранах.
  static const double maxContentWidth = 1100;

  /// Ширина бокового меню (sidebar) на web/desktop.
  static const double sidebarWidth = 256;

  /// Высота стандартной кнопки/поля.
  static const double controlHeight = 48;
}
