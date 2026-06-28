import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../../courses/data/course_providers.dart';

/// Выбор курса для журнала оценок преподавателя (ТЗ §5.5, шаг 25).
class GradebookHomeScreen extends ConsumerWidget {
  const GradebookHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    if (uid == null) {
      return const AppScaffold(title: 'Журнал оценок', body: AppLoader());
    }

    final coursesAsync = ref.watch(ownerCoursesProvider(uid));

    return AppScaffold(
      title: 'Журнал оценок',
      body: coursesAsync.when(
        data: (courses) {
          if (courses.isEmpty) {
            return const AppEmptyView(message: 'Нет курсов');
          }
          return ListView.separated(
            itemCount: courses.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) {
              final course = courses[index];
              return AppCard(
                onTap: () =>
                    context.push('/teacher/grades/${course.courseId}'),
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
          onRetry: () => ref.invalidate(ownerCoursesProvider(uid)),
        ),
      ),
    );
  }
}
