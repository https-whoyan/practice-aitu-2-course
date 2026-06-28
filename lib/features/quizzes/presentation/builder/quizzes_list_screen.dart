import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../data/quiz_providers.dart';

/// Список квизов курса (преподаватель, конструктор — шаг 22).
class CourseQuizzesScreen extends ConsumerWidget {
  const CourseQuizzesScreen({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzesAsync = ref.watch(courseQuizzesProvider(courseId));

    return AppScaffold(
      title: 'Квизы',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            context.push('/teacher/courses/$courseId/quizzes/new'),
        icon: const Icon(Icons.add),
        label: const Text('Создать квиз'),
      ),
      body: quizzesAsync.when(
        data: (quizzes) {
          if (quizzes.isEmpty) {
            return const AppEmptyView(message: 'Квизов пока нет');
          }
          return ListView(
            children: [
              for (final quiz in quizzes)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    onTap: () => context.push(
                      '/teacher/courses/$courseId/quizzes/${quiz.quizId}',
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                quiz.title.isEmpty
                                    ? 'Без названия'
                                    : quiz.title,
                                style:
                                    Theme.of(context).textTheme.titleMedium,
                              ),
                              AppSpacing.gapXs,
                              Text(
                                'Вопросов: ${quiz.questionIds.length}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.gapMd,
                        Chip(
                          label: Text(
                            quiz.isPublished ? 'Опубликован' : 'Черновик',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.bar_chart),
                          tooltip: 'Результаты',
                          onPressed: () => context.push(
                            '/teacher/courses/$courseId/quizzes/${quiz.quizId}/results',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(courseQuizzesProvider(courseId)),
        ),
      ),
    );
  }
}
