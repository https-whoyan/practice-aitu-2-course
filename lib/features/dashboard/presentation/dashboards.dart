import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../admin/data/admin_user_providers.dart';
import '../../admin/data/audit_providers.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/domain/user_role.dart';
import '../../courses/data/course_providers.dart';
import '../../grading/data/grade_providers.dart';
import '../../groups/data/group_providers.dart';
import '../../statistics/data/statistics_repository.dart';

/// Приветствие с именем текущего пользователя.
class _Greeting extends ConsumerWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(appProfileProvider).valueOrNull?.fullName ?? '';
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Text(
        name.trim().isEmpty ? 'Здравствуйте!' : 'Здравствуйте, $name!',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}

/// Карточка-секция dashboard'а с заголовком.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title),
          AppCard(child: child),
        ],
      ),
    );
  }
}

// --- Admin (ТЗ §5.3.6, P3-1/P3-7) -----------------------------------------

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(adminCoursesProvider()).valueOrNull;
    final groups = ref.watch(adminGroupsProvider()).valueOrNull;
    final admins =
        ref.watch(adminUsersByRoleProvider(UserRole.admin)).valueOrNull;
    final teachers =
        ref.watch(adminUsersByRoleProvider(UserRole.teacher)).valueOrNull;
    final students =
        ref.watch(adminUsersByRoleProvider(UserRole.student)).valueOrNull;
    final logs = ref.watch(recentAuditLogsProvider).valueOrNull;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const _Greeting(),
        _Section(
          title: 'Сводка по системе',
          child: Column(
            children: [
              _statRow(context, 'Курсов', courses?.length),
              _statRow(context, 'Групп', groups?.length),
              _statRow(context, 'Администраторов', admins?.length),
              _statRow(context, 'Преподавателей', teachers?.length),
              _statRow(context, 'Студентов', students?.length),
            ],
          ),
        ),
        _Section(
          title: 'Последние действия',
          child: (logs == null || logs.isEmpty)
              ? const Text('Журнал пуст')
              : Column(
                  children: [
                    for (final l in logs.take(8))
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text('${l.actionType} · ${l.entityType}'),
                        subtitle: Text(l.entityId),
                      ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _statRow(BuildContext context, String label, int? value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value?.toString() ?? '…',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      );
}

// --- Teacher (ТЗ §5.4.1, P3-1) --------------------------------------------

class TeacherDashboard extends ConsumerWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    final courses =
        uid == null ? null : ref.watch(teacherCoursesProvider(uid)).valueOrNull;
    final groups = uid == null
        ? null
        : ref.watch(teacherGroupsByCoursesProvider(uid)).valueOrNull;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const _Greeting(),
        _Section(
          title: 'Мои курсы',
          child: (courses == null)
              ? const SizedBox(height: 40, child: AppLoader())
              : courses.isEmpty
                  ? const Text('Курсов пока нет')
                  : Column(
                      children: [
                        for (final c in courses)
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(c.title.isEmpty ? c.courseId : c.title),
                            onTap: () => context
                                .push('/teacher/courses/${c.courseId}'),
                          ),
                      ],
                    ),
        ),
        _Section(
          title: 'Мои группы',
          child: (groups == null)
              ? const SizedBox(height: 40, child: AppLoader())
              : groups.isEmpty
                  ? const Text('Групп пока нет')
                  : Column(
                      children: [
                        for (final g in groups)
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(g.title.isEmpty ? g.groupId : g.title),
                            subtitle: Text('Студентов: ${g.studentIds.length}'),
                            onTap: () =>
                                context.push('/teacher/groups/${g.groupId}'),
                          ),
                      ],
                    ),
        ),
      ],
    );
  }
}

// --- Student (ТЗ §5.6.1, P3-1) --------------------------------------------

class StudentDashboard extends ConsumerWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(appProfileProvider).valueOrNull;
    final courses = profile == null
        ? null
        : ref.watch(coursesByGroupsProvider(profile.groupIds)).valueOrNull;
    final grades = ref.watch(myGradesProvider).valueOrNull;
    final summary = ref.watch(mySummaryProvider).valueOrNull;

    final recentGrades = [...?grades]
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const _Greeting(),
        _Section(
          title: 'Мои курсы',
          child: (courses == null)
              ? const SizedBox(height: 40, child: AppLoader())
              : courses.isEmpty
                  ? const Text('Вы пока не записаны на курсы')
                  : Column(
                      children: [
                        for (final c in courses)
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(c.title.isEmpty ? c.courseId : c.title),
                            onTap: () => context
                                .push('/student/courses/${c.courseId}'),
                          ),
                      ],
                    ),
        ),
        _Section(
          title: 'Успеваемость',
          child: summary == null
              ? const Text('Статистика появится после первых оценок')
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Средний балл: ${summary.averagePercent}%'),
                    Text('Просрочено: ${summary.overdueCount}'),
                  ],
                ),
        ),
        _Section(
          title: 'Последние оценки',
          child: recentGrades.isEmpty
              ? const Text('Оценок пока нет')
              : Column(
                  children: [
                    for (final g in recentGrades.take(5))
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(g.sourceType.label),
                        trailing: Text('${g.score}/${g.maxScore}'),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}
