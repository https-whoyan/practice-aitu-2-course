import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../../auth/data/auth_providers.dart';
import '../../../courses/data/course_providers.dart';

/// Список курсов студента для перехода к квизам (ТЗ §5.7, шаг 23).
///
/// Курсы берутся по группам студента; выбор курса ведёт к его квизам.
class StudentQuizzesScreen extends ConsumerWidget {
  const StudentQuizzesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(appProfileProvider).valueOrNull;
    if (profile == null) {
      return const AppScaffold(title: 'Мои квизы', body: AppLoader());
    }

    final coursesAsync = ref.watch(coursesByGroupsProvider(profile.groupIds));

    return AppScaffold(
      title: 'Мои квизы',
      body: coursesAsync.when(
        data: (courses) {
          if (courses.isEmpty) {
            return const AppEmptyView(message: 'Нет доступных курсов');
          }
          return ListView.separated(
            itemCount: courses.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) {
              final course = courses[index];
              return AppCard(
                onTap: () => context.push(
                  '/student/quizzes/course/${course.courseId}',
                ),
                child: Text(
                  course.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            },
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
