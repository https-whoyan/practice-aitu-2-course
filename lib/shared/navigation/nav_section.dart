import 'package:flutter/material.dart';

/// Описание раздела навигации (вкладки) для роли.
class NavSection {
  const NavSection({
    required this.route,
    required this.label,
    required this.icon,
  });

  /// Полный путь маршрута (например, `/admin/users`).
  final String route;
  final String label;
  final IconData icon;
}
