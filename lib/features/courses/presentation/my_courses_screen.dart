import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../data/course_providers.dart';

/// Список курсов преподавателя-владельца (ТЗ §5.4.1, шаг 14).
/// Создание нового курса — через FAB.
class MyCoursesScreen extends ConsumerWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    if (uid == null) {
      return const AppScaffold(title: 'Мои курсы', body: AppLoader());
    }

    final coursesAsync = ref.watch(ownerCoursesProvider(uid));

    return AppScaffold(
      title: 'Мои курсы',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/teacher/courses/new'),
        icon: const Icon(Icons.add),
        label: const Text('Создать курс'),
      ),
      body: coursesAsync.when(
        data: (courses) {
          if (courses.isEmpty) {
            return const AppEmptyView(message: 'У вас пока нет курсов');
          }
          return ListView.separated(
            itemCount: courses.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) {
              final course = courses[index];
              return AppCard(
                onTap: () =>
                    context.push('/teacher/courses/${course.courseId}'),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (course.description.isNotEmpty) ...[
                            AppSpacing.gapXs,
                            Text(
                              course.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ),
                    ),
                    AppSpacing.gapMd,
                    Chip(
                      label: Text(course.status.label),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
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
