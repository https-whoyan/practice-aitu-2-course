import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../../courses/data/course_providers.dart';
import '../domain/group.dart';
import '../domain/group_repository.dart';
import 'firestore_group_repository.dart';

part 'group_providers.g.dart';

/// Репозиторий групп поверх `firestoreProvider` (шаг 2).
@Riverpod(keepAlive: true)
GroupRepository groupRepository(Ref ref) =>
    FirestoreGroupRepository(ref.watch(firestoreProvider));

/// Список групп для админки (активные по умолчанию).
@riverpod
Stream<List<Group>> adminGroups(Ref ref, {bool includeArchived = false}) =>
    ref.watch(groupRepositoryProvider).watchGroups(includeArchived: includeArchived);

/// Одна группа по id (карточка/форма).
@riverpod
Stream<Group?> groupById(Ref ref, String groupId) =>
    ref.watch(groupRepositoryProvider).watchGroup(groupId);

/// Группы текущего преподавателя.
@riverpod
Stream<List<Group>> teacherGroups(Ref ref, String teacherId) =>
    ref.watch(groupRepositoryProvider).watchGroupsForTeacher(teacherId);

/// Группы текущего студента.
@riverpod
Stream<List<Group>> studentGroups(Ref ref, String studentId) =>
    ref.watch(groupRepositoryProvider).watchGroupsForStudent(studentId);

/// «Мои группы» преподавателя — группы, связанные с его курсами (P1-3).
/// `group.teacherIds` не заполняется, поэтому идём через курсы преподавателя.
@riverpod
Stream<List<Group>> teacherGroupsByCourses(Ref ref, String teacherId) {
  final courses =
      ref.watch(teacherCoursesProvider(teacherId)).valueOrNull ?? const [];
  final courseIds = courses.map((c) => c.courseId).toList();
  return ref.watch(groupRepositoryProvider).watchGroupsForCourses(courseIds);
}

/// Группы, связанные с конкретным курсом (для состава студентов курса).
@riverpod
Stream<List<Group>> courseGroups(Ref ref, String courseId) =>
    ref.watch(groupRepositoryProvider).watchGroupsForCourses([courseId]);
