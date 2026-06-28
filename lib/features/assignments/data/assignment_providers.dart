import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../domain/assignment.dart';
import '../domain/assignment_repository.dart';
import 'firestore_assignment_repository.dart';

part 'assignment_providers.g.dart';

/// Репозиторий заданий (общий для шагов 17 и 18).
@Riverpod(keepAlive: true)
AssignmentRepository assignmentRepository(Ref ref) =>
    FirestoreAssignmentRepository(ref.watch(firestoreProvider));

/// Все задания курса (преподаватель).
@riverpod
Stream<List<Assignment>> assignmentsForCourse(Ref ref, String courseId) =>
    ref.watch(assignmentRepositoryProvider).watchAssignmentsForCourse(courseId);

/// Только опубликованные задания курса (студент, ТЗ §5.6.4).
@riverpod
Stream<List<Assignment>> publishedAssignmentsForCourse(
  Ref ref,
  String courseId,
) =>
    ref
        .watch(assignmentRepositoryProvider)
        .watchPublishedAssignmentsForCourse(courseId);

/// Задания конкретной недели.
@riverpod
Stream<List<Assignment>> assignmentsForWeek(Ref ref, String weekId) =>
    ref.watch(assignmentRepositoryProvider).watchAssignmentsForWeek(weekId);

/// Одно задание по id (форма редактирования / просмотр).
@riverpod
Stream<Assignment?> assignmentById(Ref ref, String id) =>
    ref.watch(assignmentRepositoryProvider).watchAssignment(id);
