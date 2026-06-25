import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/common/presentation/profile_screen.dart';
import '../../features/common/presentation/settings_screen.dart';
import '../../features/dashboard/presentation/dashboards.dart';
import '../widgets/placeholder_screen.dart';
import 'app_shell.dart';
import 'nav_section.dart';

/// Раздел роли = вкладка навигации + её экран.
typedef _SectionRoute = ({NavSection section, Widget Function() build});

_SectionRoute _section(
  String route,
  String label,
  IconData icon,
  Widget Function() build,
) =>
    (section: NavSection(route: route, label: label, icon: icon), build: build);

Widget _placeholder(String title, IconData icon) =>
    PlaceholderScreen(title: title, icon: icon);

/// Разделы администратора (ТЗ §6.3).
final List<_SectionRoute> _adminSections = [
  _section('/admin', 'Главная', Icons.dashboard_outlined,
      () => const AdminDashboard()),
  _section('/admin/users', 'Пользователи', Icons.people_outline,
      () => _placeholder('Пользователи', Icons.people_outline)),
  _section('/admin/teachers', 'Преподаватели', Icons.school_outlined,
      () => _placeholder('Преподаватели', Icons.school_outlined)),
  _section('/admin/students', 'Студенты', Icons.groups_outlined,
      () => _placeholder('Студенты', Icons.groups_outlined)),
  _section('/admin/groups', 'Группы', Icons.group_work_outlined,
      () => _placeholder('Группы', Icons.group_work_outlined)),
  _section('/admin/courses', 'Курсы', Icons.menu_book_outlined,
      () => _placeholder('Курсы', Icons.menu_book_outlined)),
  _section('/admin/stats', 'Статистика', Icons.bar_chart_outlined,
      () => _placeholder('Статистика', Icons.bar_chart_outlined)),
  _section('/admin/audit', 'Журнал', Icons.history_outlined,
      () => _placeholder('Журнал действий', Icons.history_outlined)),
  _section('/admin/settings', 'Настройки', Icons.settings_outlined,
      () => const SettingsScreen()),
];

/// Разделы преподавателя (ТЗ §6.4).
final List<_SectionRoute> _teacherSections = [
  _section('/teacher', 'Главная', Icons.dashboard_outlined,
      () => const TeacherDashboard()),
  _section('/teacher/courses', 'Мои курсы', Icons.menu_book_outlined,
      () => _placeholder('Мои курсы', Icons.menu_book_outlined)),
  _section('/teacher/groups', 'Мои группы', Icons.group_work_outlined,
      () => _placeholder('Мои группы', Icons.group_work_outlined)),
  _section('/teacher/questions', 'Банк вопросов', Icons.quiz_outlined,
      () => _placeholder('Банк вопросов', Icons.quiz_outlined)),
  _section('/teacher/quizzes', 'Квизы', Icons.assignment_outlined,
      () => _placeholder('Квизы', Icons.assignment_outlined)),
  _section('/teacher/assignments', 'Задания', Icons.assignment_turned_in_outlined,
      () => _placeholder('Задания', Icons.assignment_turned_in_outlined)),
  _section('/teacher/grades', 'Оценки', Icons.grade_outlined,
      () => _placeholder('Оценки', Icons.grade_outlined)),
  _section('/teacher/stats', 'Статистика', Icons.bar_chart_outlined,
      () => _placeholder('Статистика', Icons.bar_chart_outlined)),
  _section('/teacher/import', 'Импорт/Экспорт', Icons.import_export_outlined,
      () => _placeholder('Импорт/Экспорт вопросов', Icons.import_export_outlined)),
  _section('/teacher/profile', 'Профиль', Icons.person_outline,
      () => const ProfileScreen()),
];

/// Разделы студента (ТЗ §6.5).
final List<_SectionRoute> _studentSections = [
  _section('/student', 'Главная', Icons.dashboard_outlined,
      () => const StudentDashboard()),
  _section('/student/courses', 'Мои курсы', Icons.menu_book_outlined,
      () => _placeholder('Мои курсы', Icons.menu_book_outlined)),
  _section('/student/assignments', 'Мои задания', Icons.assignment_outlined,
      () => _placeholder('Мои задания', Icons.assignment_outlined)),
  _section('/student/quizzes', 'Мои квизы', Icons.quiz_outlined,
      () => _placeholder('Мои квизы', Icons.quiz_outlined)),
  _section('/student/grades', 'Мои оценки', Icons.grade_outlined,
      () => _placeholder('Мои оценки', Icons.grade_outlined)),
  _section('/student/stats', 'Статистика', Icons.bar_chart_outlined,
      () => _placeholder('Моя статистика', Icons.bar_chart_outlined)),
  _section('/student/notifications', 'Уведомления', Icons.notifications_none,
      () => const NotificationsScreen()),
  _section('/student/profile', 'Профиль', Icons.person_outline,
      () => const ProfileScreen()),
];

StatefulShellRoute _buildRoleShell(List<_SectionRoute> items) {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) => AppShell(
      navigationShell: navigationShell,
      sections: [for (final i in items) i.section],
    ),
    branches: [
      for (final i in items)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: i.section.route,
              builder: (context, state) => i.build(),
            ),
          ],
        ),
    ],
  );
}

/// Ролевые навигационные деревья (StatefulShellRoute) для go_router.
List<RouteBase> roleShellRoutes() => [
      _buildRoleShell(_adminSections),
      _buildRoleShell(_teacherSections),
      _buildRoleShell(_studentSections),
    ];
