import 'package:flutter/widgets.dart';

/// Тип формата экрана по ширине.
enum ScreenType { mobile, tablet, desktop }

/// Брейкпоинты адаптивности. Используются хелперами вместо россыпи
/// `MediaQuery` по коду (ТЗ §6.1).
class Breakpoints {
  const Breakpoints._();

  /// < 600 — мобильный (bottom navigation).
  static const double mobile = 600;

  /// 600–1024 — планшет.
  static const double tablet = 1024;

  static ScreenType typeOf(double width) {
    if (width < mobile) return ScreenType.mobile;
    if (width < tablet) return ScreenType.tablet;
    return ScreenType.desktop;
  }
}

/// Удобные геттеры адаптивности на `BuildContext`.
extension ResponsiveContext on BuildContext {
  ScreenType get screenType =>
      Breakpoints.typeOf(MediaQuery.sizeOf(this).width);

  bool get isMobile => screenType == ScreenType.mobile;
  bool get isTablet => screenType == ScreenType.tablet;
  bool get isDesktop => screenType == ScreenType.desktop;

  /// На широких экранах — боковое меню (rail/sidebar), на узких — bottom nav.
  bool get useSidebar => screenType != ScreenType.mobile;
}

/// Строит разный layout под формат экрана.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, ScreenType type) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          builder(context, Breakpoints.typeOf(constraints.maxWidth)),
    );
  }
}
