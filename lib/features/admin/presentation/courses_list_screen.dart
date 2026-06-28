import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../courses/data/course_providers.dart';

/// Список курсов для админки (ТЗ §7.4). Создание — через FAB.
class CoursesListScreen extends ConsumerWidget {
  const CoursesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(adminCoursesProvider());

    return AppScaffold(
      title: 'Курсы',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/courses/new'),
        icon: const Icon(Icons.add),
        label: const Text('Создать курс'),
      ),
      body: coursesAsync.when(
        data: (courses) {
          if (courses.isEmpty) {
            return const AppEmptyView(message: 'Курсов пока нет');
          }
          return ListView.separated(
            itemCount: courses.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) {
              final course = courses[index];
              return AppCard(
                onTap: () => context.push('/admin/courses/${course.courseId}'),
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
                    Text(
                      'Групп: ${course.groupIds.length}',
                      style: Theme.of(context).textTheme.bodySmall,
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
          onRetry: () => ref.invalidate(adminCoursesProvider),
        ),
      ),
    );
  }
}
