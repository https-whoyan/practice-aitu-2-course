import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../domain/course_week.dart';
import '../domain/course_week_repository.dart';
import 'firestore_course_week_repository.dart';

part 'course_week_providers.g.dart';

/// Репозиторий недель курса (общий для шагов 14 и 16).
@Riverpod(keepAlive: true)
CourseWeekRepository courseWeekRepository(Ref ref) =>
    FirestoreCourseWeekRepository(ref.watch(firestoreProvider));

/// Все недели курса по порядку (преподаватель).
@riverpod
Stream<List<CourseWeek>> courseWeeks(Ref ref, String courseId) =>
    ref.watch(courseWeekRepositoryProvider).watchWeeks(courseId);

/// Только опубликованные недели (студент, ТЗ §5.6.3).
@riverpod
Stream<List<CourseWeek>> publishedCourseWeeks(Ref ref, String courseId) =>
    ref.watch(courseWeekRepositoryProvider).watchPublishedWeeks(courseId);

/// Одна неделя по id (форма редактирования).
@riverpod
Future<CourseWeek?> weekById(Ref ref, String weekId) =>
    ref.watch(courseWeekRepositoryProvider).getWeek(weekId);
