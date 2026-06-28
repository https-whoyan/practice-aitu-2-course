import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../../auth/data/auth_providers.dart';
import '../../data/course_providers.dart';

/// Список курсов студента: активные курсы его групп (ТЗ §5.4, §12, шаг 16).
/// Поиск по названию (P2-22). Вступление в группу — через FAB/пустое состояние.
class StudentCoursesScreen extends ConsumerStatefulWidget {
  const StudentCoursesScreen({super.key});

  @override
  ConsumerState<StudentCoursesScreen> createState() =>
      _StudentCoursesScreenState();
}

class _StudentCoursesScreenState extends ConsumerState<StudentCoursesScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(appProfileProvider).valueOrNull;
    if (profile == null) {
      return const AppScaffold(title: 'Мои курсы', body: AppLoader());
    }

    final coursesAsync = ref.watch(coursesByGroupsProvider(profile.groupIds));
    final q = _search.trim().toLowerCase();

    return AppScaffold(
      title: 'Мои курсы',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/student/courses/join'),
        icon: const Icon(Icons.group_add),
        label: const Text('Вступить в группу'),
      ),
      body: coursesAsync.when(
        data: (courses) {
          if (courses.isEmpty) {
            return AppEmptyView(
              message: 'Вы пока не записаны на курсы',
              action: SecondaryButton(
                label: 'Вступить в группу',
                expand: false,
                onPressed: () => context.push('/student/courses/join'),
              ),
            );
          }
          final filtered = q.isEmpty
              ? courses
              : courses
                  .where((c) =>
                      c.title.toLowerCase().contains(q) ||
                      c.description.toLowerCase().contains(q))
                  .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: 'Поиск',
                hint: 'Название курса',
                prefixIcon: Icons.search,
                onChanged: (v) => setState(() => _search = v),
              ),
              AppSpacing.gapMd,
              Expanded(
                child: filtered.isEmpty
                    ? const AppEmptyView(message: 'Ничего не найдено')
                    : ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) => AppSpacing.gapSm,
                        itemBuilder: (context, index) {
                          final course = filtered[index];
                          return AppCard(
                            onTap: () => context
                                .push('/student/courses/${course.courseId}'),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(course.title,
                                    style:
                                        Theme.of(context).textTheme.titleMedium),
                                if (course.description.isNotEmpty) ...[
                                  AppSpacing.gapXs,
                                  Text(
                                    course.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () =>
              ref.invalidate(coursesByGroupsProvider(profile.groupIds)),
        ),
      ),
    );
  }
}
