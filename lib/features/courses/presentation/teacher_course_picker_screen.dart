import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../data/course_providers.dart';
import '../domain/course.dart';

/// Агрегат-вкладка преподавателя: общий список его курсов с переходом в
/// раздел (квизы/задания) конкретного курса. Управление сущностями живёт
/// внутри курса, поэтому верхнеуровневая вкладка служит точкой входа по
/// фиче (ТЗ §6.4).
class TeacherCoursePickerScreen extends ConsumerWidget {
  const TeacherCoursePickerScreen({
    required this.title,
    required this.emptyMessage,
    required this.routeForCourse,
    super.key,
  });

  /// Заголовок раздела (например, «Квизы» или «Задания»).
  final String title;

  /// Текст пустого состояния.
  final String emptyMessage;

  /// Путь, на который ведёт тап по курсу.
  final String Function(Course course) routeForCourse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(appUserProvider).valueOrNull?.uid;
    if (uid == null) {
      return AppScaffold(title: title, body: const AppLoader());
    }

    final coursesAsync = ref.watch(teacherCoursesProvider(uid));

    return AppScaffold(
      title: title,
      body: coursesAsync.when(
        data: (courses) {
          if (courses.isEmpty) {
            return AppEmptyView(message: emptyMessage);
          }
          return ListView.separated(
            itemCount: courses.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) {
              final course = courses[index];
              return AppCard(
                onTap: () => context.push(routeForCourse(course)),
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
                    const Icon(Icons.chevron_right),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(teacherCoursesProvider(uid)),
        ),
      ),
    );
  }
}
