import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/data/user_providers.dart';
import '../../courses/data/course_providers.dart';
import '../../courses/domain/course.dart';
import '../../groups/data/group_providers.dart';
import '../../groups/domain/group.dart';
import '../data/statistics_repository.dart';
import 'risk_indicator.dart';

/// Статистика преподавателя: сводки по курсам и группам + мониторинг студентов
/// (ТЗ §5.7.1–5.7.3, P3-2/3/4). Данные — денормализованные summary с сервера.
class GroupStatsScreen extends ConsumerWidget {
  const GroupStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    if (uid == null) {
      return const AppScaffold(title: 'Статистика', body: AppLoader());
    }
    final courses =
        ref.watch(teacherCoursesProvider(uid)).valueOrNull ?? const <Course>[];
    final groups = ref.watch(teacherGroupsByCoursesProvider(uid)).valueOrNull ??
        const <Group>[];

    return AppScaffold(
      title: 'Статистика',
      body: ListView(
        children: [
          const SectionHeader(title: 'Курсы'),
          if (courses.isEmpty)
            const AppCard(child: Text('Нет курсов'))
          else
            for (final c in courses) _CourseStatCard(course: c),
          AppSpacing.gapLg,
          const SectionHeader(title: 'Группы и мониторинг'),
          if (groups.isEmpty)
            const AppCard(child: Text('Нет групп'))
          else
            for (final g in groups) _GroupStatTile(group: g),
        ],
      ),
    );
  }
}

class _CourseStatCard extends ConsumerWidget {
  const _CourseStatCard({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary =
        ref.watch(courseSummaryProvider(course.courseId)).valueOrNull;
    return AppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(course.title.isEmpty ? course.courseId : course.title,
                style: Theme.of(context).textTheme.titleMedium),
          ),
          if (summary == null)
            Text('—', style: Theme.of(context).textTheme.bodySmall)
          else
            Text(
              'Средний: ${summary.averagePercent}% · оценок: ${summary.gradedCount}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}

/// Карточка группы со сводкой и раскрытием мониторинга студентов (P3-4).
class _GroupStatTile extends ConsumerWidget {
  const _GroupStatTile({required this.group});

  final Group group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(groupSummaryProvider(group.groupId)).valueOrNull;
    return Card(
      child: ExpansionTile(
        title: Text(group.title.isEmpty ? group.groupId : group.title),
        subtitle: Text(summary == null
            ? 'Студентов: ${group.studentIds.length}'
            : 'Средний: ${summary.averagePercent}% · в зоне риска: ${summary.atRiskCount}'),
        children: [
          if (group.studentIds.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('В группе нет студентов'),
            )
          else
            for (final uid in group.studentIds) _StudentMonitorRow(uid: uid),
        ],
      ),
    );
  }
}

class _StudentMonitorRow extends ConsumerWidget {
  const _StudentMonitorRow({required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileStreamProvider(uid)).valueOrNull;
    final summary = ref.watch(studentSummaryProvider(uid)).valueOrNull;
    final name = (profile?.fullName.trim().isNotEmpty ?? false)
        ? profile!.fullName
        : uid;
    return ListTile(
      dense: true,
      title: Text(name),
      subtitle: summary == null
          ? const Text('Нет данных')
          : Text(
              'Средний: ${summary.averagePercent}% · просрочено: ${summary.overdueCount}'),
      trailing:
          summary == null ? null : RiskIndicator(level: summary.riskLevel),
    );
  }
}
