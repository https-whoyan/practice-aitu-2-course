import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/presentation/audit_log_screen.dart';
import '../../features/admin/presentation/course_card_screen.dart';
import '../../features/admin/presentation/course_form_screen.dart';
import '../../features/admin/presentation/courses_list_screen.dart';
import '../../features/admin/presentation/group_form_screen.dart';
import '../../features/admin/presentation/groups_list_screen.dart';
import '../../features/admin/presentation/students_list_screen.dart';
import '../../features/admin/presentation/teachers_list_screen.dart';
import '../../features/admin/presentation/user_card_screen.dart';
import '../../features/admin/presentation/user_form_screen.dart';
import '../../features/admin/presentation/users_list_screen.dart';
import '../../features/assignments/presentation/assignment_form_screen.dart';
import '../../features/assignments/presentation/course_assignments_screen.dart';
import '../../features/assignments/presentation/student_assignment_page_screen.dart';
import '../../features/assignments/presentation/student_assignments_screen.dart';
import '../../features/assignments/presentation/student_course_assignments_screen.dart';
import '../../features/common/presentation/edit_profile_screen.dart';
import '../../features/common/presentation/profile_screen.dart';
import '../../features/common/presentation/settings_screen.dart';
import '../../features/courses/presentation/course_form_screen.dart';
import '../../features/courses/presentation/course_page_screen.dart';
import '../../features/courses/presentation/my_courses_screen.dart';
import '../../features/courses/presentation/teacher_course_picker_screen.dart';
import '../../features/courses/presentation/student/course_page_screen.dart';
import '../../features/courses/presentation/student/material_view_screen.dart';
import '../../features/courses/presentation/student/my_courses_screen.dart';
import '../../features/courses/presentation/student/week_page_screen.dart';
import '../../features/courses/presentation/week_form_screen.dart';
import '../../features/courses/presentation/weeks_manage_screen.dart';
import '../../features/dashboard/presentation/dashboards.dart';
import '../../features/grading/presentation/gradebook_home_screen.dart';
import '../../features/grading/presentation/gradebook_screen.dart';
import '../../features/grading/presentation/student_grades_screen.dart';
import '../../features/groups/presentation/join_group_screen.dart';
import '../../features/groups/presentation/teacher_group_detail_screen.dart';
import '../../features/groups/presentation/teacher_groups_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/statistics/presentation/group_stats_screen.dart';
import '../../features/statistics/presentation/student_stats_screen.dart';
import '../../features/materials/presentation/material_form_screen.dart';
import '../../features/materials/presentation/week_materials_screen.dart';
import '../../features/questions/presentation/import/import_screen.dart';
import '../../features/questions/presentation/question_bank_screen.dart';
import '../../features/questions/presentation/question_form_screen.dart';
import '../../features/quizzes/presentation/builder/quiz_builder_screen.dart';
import '../../features/quizzes/presentation/builder/quiz_results_screen.dart';
import '../../features/quizzes/presentation/builder/quizzes_list_screen.dart';
import '../../features/quizzes/presentation/taking/quiz_start_screen.dart';
import '../../features/quizzes/presentation/taking/quiz_taking_screen.dart';
import '../../features/quizzes/presentation/taking/student_course_quizzes_screen.dart';
import '../../features/quizzes/presentation/taking/student_quizzes_screen.dart';
import '../../features/submissions/presentation/submissions_list_screen.dart';
import '../../features/submissions/presentation/submit_screen.dart';
import '../../features/grading/presentation/review_screen.dart';
import 'app_shell.dart';
import 'nav_section.dart';

/// Раздел роли = вкладка навигации + её экран (+ опц. вложенные маршруты).
typedef _SectionRoute = ({
  NavSection section,
  Widget Function() build,
  List<RouteBase> sub,
});

_SectionRoute _section(
  String route,
  String label,
  IconData icon,
  Widget Function() build, {
  List<RouteBase> sub = const [],
}) =>
    (
      section: NavSection(route: route, label: label, icon: icon),
      build: build,
      sub: sub,
    );

/// Вложенный маршрут (деталь/форма) внутри ветки раздела. Путь — относительный.
GoRoute _child(String path, Widget Function(GoRouterState) build,
        {List<RouteBase> sub = const []}) =>
    GoRoute(
      path: path,
      builder: (context, state) => build(state),
      routes: sub,
    );

/// Разделы администратора (ТЗ §6.3).
final List<_SectionRoute> _adminSections = [
  _section('/admin', 'Главная', Icons.dashboard_outlined,
      () => const AdminDashboard()),
  _section('/admin/users', 'Пользователи', Icons.people_outline,
      () => const UsersListScreen(), sub: [
    _child('new', (s) => const UserFormScreen()),
    _child(
      ':uid',
      (s) => UserCardScreen(uid: s.pathParameters['uid']!),
      sub: [
        _child('edit',
            (s) => UserFormScreen(uid: s.pathParameters['uid'])),
      ],
    ),
  ]),
  _section('/admin/teachers', 'Преподаватели', Icons.school_outlined,
      () => const TeachersListScreen()),
  _section('/admin/students', 'Студенты', Icons.groups_outlined,
      () => const StudentsListScreen()),
  _section('/admin/groups', 'Группы', Icons.group_work_outlined,
      () => const GroupsListScreen(), sub: [
    _child('new', (s) => const GroupFormScreen()),
    _child(':groupId',
        (s) => GroupFormScreen(groupId: s.pathParameters['groupId'])),
  ]),
  _section('/admin/courses', 'Курсы', Icons.menu_book_outlined,
      () => const CoursesListScreen(), sub: [
    _child('new', (s) => const CourseFormScreen()),
    _child(
      ':courseId',
      (s) => CourseCardScreen(courseId: s.pathParameters['courseId']!),
      sub: [
        _child('edit',
            (s) => CourseFormScreen(courseId: s.pathParameters['courseId'])),
      ],
    ),
  ]),
  _section('/admin/stats', 'Статистика', Icons.bar_chart_outlined,
      () => const GroupStatsScreen()),
  _section('/admin/audit', 'Журнал', Icons.history_outlined,
      () => const AuditLogScreen()),
  _section('/admin/settings', 'Настройки', Icons.settings_outlined,
      () => const SettingsScreen()),
];

/// Разделы преподавателя (ТЗ §6.4).
final List<_SectionRoute> _teacherSections = [
  _section('/teacher', 'Главная', Icons.dashboard_outlined,
      () => const TeacherDashboard()),
  _section('/teacher/courses', 'Мои курсы', Icons.menu_book_outlined,
      () => const MyCoursesScreen(), sub: [
    _child('new', (s) => const TeacherCourseFormScreen()),
    _child(
      ':id',
      (s) => CoursePageScreen(courseId: s.pathParameters['id']!),
      sub: [
        _child('edit',
            (s) => TeacherCourseFormScreen(courseId: s.pathParameters['id'])),
        _child(
          'weeks',
          (s) => WeeksManageScreen(courseId: s.pathParameters['id']!),
          sub: [
            _child('new',
                (s) => WeekFormScreen(courseId: s.pathParameters['id']!)),
            _child(
              ':weekId/edit',
              (s) => WeekFormScreen(
                courseId: s.pathParameters['id']!,
                weekId: s.pathParameters['weekId'],
              ),
            ),
            _child(
              ':weekId/materials',
              (s) => WeekMaterialsScreen(
                courseId: s.pathParameters['id']!,
                weekId: s.pathParameters['weekId']!,
              ),
              sub: [
                _child(
                  'new',
                  (s) => MaterialFormScreen(
                    courseId: s.pathParameters['id']!,
                    weekId: s.pathParameters['weekId']!,
                  ),
                ),
                _child(
                  ':materialId/edit',
                  (s) => MaterialFormScreen(
                    courseId: s.pathParameters['id']!,
                    weekId: s.pathParameters['weekId']!,
                    materialId: s.pathParameters['materialId'],
                  ),
                ),
              ],
            ),
            _child(
              ':weekId/assignments',
              (s) => CourseAssignmentsScreen(
                courseId: s.pathParameters['id']!,
                weekId: s.pathParameters['weekId']!,
              ),
              sub: [
                _child(
                  'new',
                  (s) => AssignmentFormScreen(
                    courseId: s.pathParameters['id']!,
                    weekId: s.pathParameters['weekId']!,
                  ),
                ),
                _child(
                  ':aid/edit',
                  (s) => AssignmentFormScreen(
                    courseId: s.pathParameters['id']!,
                    weekId: s.pathParameters['weekId']!,
                    assignmentId: s.pathParameters['aid'],
                  ),
                ),
                _child(
                  ':aid/submissions',
                  (s) => SubmissionsListScreen(
                    assignmentId: s.pathParameters['aid']!,
                    courseId: s.pathParameters['id']!,
                    maxScore:
                        int.tryParse(s.uri.queryParameters['maxScore'] ?? '') ??
                            100,
                  ),
                  sub: [
                    _child(
                      ':sid',
                      (s) => ReviewSubmissionScreen(
                        submissionId: s.pathParameters['sid']!,
                        assignmentId: s.pathParameters['aid']!,
                        studentId: s.uri.queryParameters['studentId'] ?? '',
                        courseId: s.pathParameters['id']!,
                        maxScore: int.tryParse(
                                s.uri.queryParameters['maxScore'] ?? '') ??
                            100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        _child(
          'quizzes',
          (s) => CourseQuizzesScreen(courseId: s.pathParameters['id']!),
          sub: [
            _child('new',
                (s) => QuizBuilderScreen(courseId: s.pathParameters['id']!)),
            _child(
              ':quizId',
              (s) => QuizBuilderScreen(
                courseId: s.pathParameters['id']!,
                quizId: s.pathParameters['quizId'],
              ),
            ),
            _child(
              ':quizId/results',
              (s) => QuizResultsScreen(quizId: s.pathParameters['quizId']!),
            ),
          ],
        ),
      ],
    ),
  ]),
  _section('/teacher/groups', 'Мои группы', Icons.group_work_outlined,
      () => const TeacherGroupsScreen(), sub: [
    _child(
      ':groupId',
      (s) => TeacherGroupDetailScreen(groupId: s.pathParameters['groupId']!),
    ),
  ]),
  _section('/teacher/questions', 'Банк вопросов', Icons.quiz_outlined,
      () => const QuestionBankScreen(), sub: [
    _child('new', (s) => const QuestionFormScreen()),
    _child('import', (s) => const QuestionImportScreen()),
    _child(':id',
        (s) => QuestionFormScreen(questionId: s.pathParameters['id'])),
  ]),
  _section('/teacher/quizzes', 'Квизы', Icons.assignment_outlined,
      () => TeacherCoursePickerScreen(
            title: 'Квизы',
            emptyMessage: 'Нет курсов с квизами — создайте курс',
            routeForCourse: (c) => '/teacher/courses/${c.courseId}/quizzes',
          )),
  _section('/teacher/assignments', 'Задания', Icons.assignment_turned_in_outlined,
      () => TeacherCoursePickerScreen(
            title: 'Задания',
            emptyMessage: 'Нет курсов с заданиями — создайте курс',
            routeForCourse: (c) => '/teacher/courses/${c.courseId}',
          )),
  _section('/teacher/grades', 'Оценки', Icons.grade_outlined,
      () => const GradebookHomeScreen(), sub: [
    _child(':courseId',
        (s) => GradebookScreen(courseId: s.pathParameters['courseId'])),
  ]),
  _section('/teacher/stats', 'Статистика', Icons.bar_chart_outlined,
      () => const GroupStatsScreen()),
  _section('/teacher/import', 'Импорт/Экспорт', Icons.import_export_outlined,
      () => const QuestionImportScreen()),
  _section('/teacher/profile', 'Профиль', Icons.person_outline,
      () => const ProfileScreen(), sub: [
    _child('edit', (s) => const EditProfileScreen()),
  ]),
];

/// Разделы студента (ТЗ §6.5).
final List<_SectionRoute> _studentSections = [
  _section('/student', 'Главная', Icons.dashboard_outlined,
      () => const StudentDashboard()),
  _section('/student/courses', 'Мои курсы', Icons.menu_book_outlined,
      () => const StudentCoursesScreen(), sub: [
    _child('join', (s) => const JoinGroupScreen()),
    _child(
      ':id',
      (s) => StudentCoursePageScreen(courseId: s.pathParameters['id']!),
      sub: [
        _child(
          'weeks/:weekId',
          (s) => StudentWeekPageScreen(
            courseId: s.pathParameters['id']!,
            weekId: s.pathParameters['weekId']!,
          ),
        ),
        _child(
          'materials/:materialId',
          (s) => StudentMaterialViewScreen(
            courseId: s.pathParameters['id']!,
            materialId: s.pathParameters['materialId']!,
          ),
        ),
      ],
    ),
  ]),
  _section('/student/assignments', 'Мои задания', Icons.assignment_outlined,
      () => const StudentAssignmentsScreen(), sub: [
    _child(
      'course/:courseId',
      (s) => StudentCourseAssignmentsScreen(
          courseId: s.pathParameters['courseId']!),
    ),
    _child(
      ':aid',
      (s) => StudentAssignmentPageScreen(assignmentId: s.pathParameters['aid']!),
      sub: [
        _child(
          'submit',
          (s) => SubmitScreen(
            assignmentId: s.pathParameters['aid']!,
            courseId: s.uri.queryParameters['courseId'] ?? '',
            submissionType: s.uri.queryParameters['type'] ?? 'text',
          ),
        ),
      ],
    ),
  ]),
  _section('/student/quizzes', 'Мои квизы', Icons.quiz_outlined,
      () => const StudentQuizzesScreen(), sub: [
    _child(
      'course/:courseId',
      (s) => StudentCourseQuizzesScreen(courseId: s.pathParameters['courseId']!),
    ),
    _child(
      ':quizId/start',
      (s) => QuizStartScreen(
        quizId: s.pathParameters['quizId']!,
        courseId: s.uri.queryParameters['courseId'] ?? '',
      ),
    ),
    _child(
      ':quizId/attempt/:attemptId',
      (s) => QuizTakingScreen(
        quizId: s.pathParameters['quizId']!,
        attemptId: s.pathParameters['attemptId']!,
      ),
    ),
  ]),
  _section('/student/grades', 'Мои оценки', Icons.grade_outlined,
      () => const StudentGradesScreen()),
  _section('/student/stats', 'Статистика', Icons.bar_chart_outlined,
      () => const StudentStatsScreen()),
  _section('/student/notifications', 'Уведомления', Icons.notifications_none,
      () => const NotificationsScreen()),
  _section('/student/profile', 'Профиль', Icons.person_outline,
      () => const ProfileScreen(), sub: [
    _child('edit', (s) => const EditProfileScreen()),
  ]),
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
              routes: i.sub,
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
