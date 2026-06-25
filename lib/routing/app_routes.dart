/// Типобезопасные пути маршрутов. Никаких «магических» строк в коде.
///
/// Ролевые корневые разделы (`/admin`, `/teacher`, `/student`) и guard'ы
/// добавляются в шаге 8, дерево навигации с заглушками — в шаге 9.
class AppRoutes {
  const AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyEmail = '/verify-email';
  static const String blocked = '/blocked';

  // Корневые разделы по ролям (шаги 8–9).
  static const String admin = '/admin';
  static const String teacher = '/teacher';
  static const String student = '/student';

  /// Маршруты, доступные без аутентификации (auth-флоу).
  static const Set<String> publicRoutes = {
    login,
    register,
    forgotPassword,
  };
}
