import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../theme/app_spacing.dart';
import '../../data/quiz_providers.dart';

/// Список опубликованных квизов курса для студента (ТЗ §5.7, шаг 23).
///
/// `publishedCourseQuizzesProvider` и модель `Quiz` объявлены в основной части
/// фичи квизов (другой агент). Выбор квиза ведёт к экрану старта попытки.
class StudentCourseQuizzesScreen extends ConsumerWidget {
  const StudentCourseQuizzesScreen({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzesAsync = ref.watch(publishedCourseQuizzesProvider(courseId));

    return AppScaffold(
      title: 'Квизы курса',
      body: quizzesAsync.when(
        data: (quizzes) {
          if (quizzes.isEmpty) {
            return const AppEmptyView(message: 'Квизов нет');
          }
          return ListView.separated(
            itemCount: quizzes.length,
            separatorBuilder: (_, _) => AppSpacing.gapSm,
            itemBuilder: (context, index) {
              final quiz = quizzes[index];
              final isRandom = quiz.randomizerSettings.totalQuestions > 0;
              final questionsLabel = isRandom
                  ? 'Вопросов: ${quiz.randomizerSettings.totalQuestions} '
                      '(случайные)'
                  : 'Вопросов: ${quiz.questionIds.length}';
              return AppCard(
                onTap: () => context.push(
                  '/student/quizzes/${quiz.quizId}/start?courseId=$courseId',
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    AppSpacing.gapXs,
                    Text(
                      questionsLabel,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Попыток: ${quiz.attemptsAllowed}',
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
          onRetry: () =>
              ref.invalidate(publishedCourseQuizzesProvider(courseId)),
        ),
      ),
    );
  }
}
