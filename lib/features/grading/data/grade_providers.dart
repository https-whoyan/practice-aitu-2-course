import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/data/user_providers.dart';
import '../../groups/data/group_providers.dart';
import '../domain/grade.dart';
import '../domain/grade_repository.dart';
import 'firestore_grade_repository.dart';

part 'grade_providers.g.dart';

/// Студент курса для пикеров журнала: uid + отображаемое имя.
typedef CourseStudent = ({String uid, String name});

/// Репозиторий оценок (общий для проверки работ, журнала и экрана студента).
@Riverpod(keepAlive: true)
GradeRepository gradeRepository(Ref ref) =>
    FirestoreGradeRepository(ref.watch(firestoreProvider));

/// Все оценки конкретного студента (по всем курсам).
@riverpod
Stream<List<Grade>> gradesForStudent(Ref ref, String studentId) =>
    ref.watch(gradeRepositoryProvider).watchGradesForStudent(studentId);

/// Все оценки конкретного курса (журнал преподавателя).
@riverpod
Stream<List<Grade>> gradesForCourse(Ref ref, String courseId) =>
    ref.watch(gradeRepositoryProvider).watchGradesForCourse(courseId);

/// Оценки текущего студента (экран «Мои оценки»).
@riverpod
Stream<List<Grade>> myGrades(Ref ref) {
  final uid = ref.watch(appUserProvider).valueOrNull?.uid;
  if (uid == null) return Stream.value(const <Grade>[]);
  return ref.watch(gradeRepositoryProvider).watchGradesForStudent(uid);
}

/// Список студентов курса (через его группы) с именами — для пикеров журнала
/// и ручных оценок (P1-6).
@riverpod
Future<List<CourseStudent>> courseStudents(Ref ref, String courseId) async {
  final groups = await ref.watch(courseGroupsProvider(courseId).future);
  final uids = <String>{for (final g in groups) ...g.studentIds}.toList();
  final profiles = await Future.wait(
    uids.map((u) => ref.watch(profileStreamProvider(u).future)),
  );
  return [
    for (var i = 0; i < uids.length; i++)
      (
        uid: uids[i],
        name: (profiles[i]?.fullName.trim().isNotEmpty ?? false)
            ? profiles[i]!.fullName
            : uids[i],
      ),
  ];
}
