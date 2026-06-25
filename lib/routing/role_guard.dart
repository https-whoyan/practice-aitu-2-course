import '../features/auth/domain/user_role.dart';
import 'app_routes.dart';

/// Корневой маршрут раздела для роли.
String homeRouteForRole(UserRole role) => switch (role) {
      UserRole.admin => AppRoutes.admin,
      UserRole.teacher => AppRoutes.teacher,
      UserRole.student => AppRoutes.student,
    };

/// Принадлежит ли путь корневому разделу какой-либо роли.
bool isRoleSection(String location) =>
    location.startsWith(AppRoutes.admin) ||
    location.startsWith(AppRoutes.teacher) ||
    location.startsWith(AppRoutes.student);

/// Хелпер guard'а: если роль [role] не входит в [allowed], возвращает маршрут
/// её собственного раздела (куда редиректить), иначе `null` (доступ разрешён).
String? requireRole(UserRole role, Set<UserRole> allowed) =>
    allowed.contains(role) ? null : homeRouteForRole(role);
