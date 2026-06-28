import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../domain/course.dart';
import '../domain/course_repository.dart';
import 'firestore_course_repository.dart';

part 'course_providers.g.dart';

/// Репозиторий курсов поверх `firestoreProvider` (шаг 2).
@Riverpod(keepAlive: true)
CourseRepository courseRepository(Ref ref) =>
    FirestoreCourseRepository(ref.watch(firestoreProvider));

/// Список курсов для админки (активные по умолчанию).
@riverpod
Stream<List<Course>> adminCourses(Ref ref, {bool includeArchived = false}) =>
    ref.watch(courseRepositoryProvider).watchCourses(includeArchived: includeArchived);

/// Один курс по id (карточка/форма).
@riverpod
Stream<Course?> courseById(Ref ref, String courseId) =>
    ref.watch(courseRepositoryProvider).watchCourse(courseId);

/// Курсы, которые ведёт преподаватель (по `teacherIds`).
@riverpod
Stream<List<Course>> teacherCourses(Ref ref, String teacherId) =>
    ref.watch(courseRepositoryProvider).watchCoursesForTeacher(teacherId);

/// Курсы преподавателя-владельца (ТЗ §5.4.1, шаг 14).
@riverpod
Stream<List<Course>> ownerCourses(Ref ref, String teacherId) =>
    ref.watch(courseRepositoryProvider).watchCoursesByOwner(teacherId);

/// Активные курсы по группам студента (ТЗ §5.6.1, шаг 16).
@riverpod
Stream<List<Course>> coursesByGroups(Ref ref, List<String> groupIds) =>
    ref.watch(courseRepositoryProvider).watchCoursesByGroups(groupIds);

/// Курсы по списку id (для студента).
@riverpod
Stream<List<Course>> coursesByIds(Ref ref, List<String> courseIds) =>
    ref.watch(courseRepositoryProvider).watchCoursesByIds(courseIds);
