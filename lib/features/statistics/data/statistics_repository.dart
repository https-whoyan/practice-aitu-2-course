import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../firebase/firebase_providers.dart';
import '../../auth/data/auth_providers.dart';
import '../domain/course_summary.dart';
import '../domain/group_summary.dart';
import '../domain/student_summary.dart';

part 'statistics_repository.g.dart';

/// Чтение сводной статистики студента из `studentSummaries` (шаг 25).
///
/// Документы пишутся Cloud Function'ом (docId = `studentId`); клиент
/// работает только на чтение.
class StatisticsRepository {
  StatisticsRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<StudentSummary> get _summaries =>
      _db.collection('studentSummaries').withConverter<StudentSummary>(
            fromFirestore: (snap, _) =>
                StudentSummary.fromJson({...?snap.data(), 'studentId': snap.id}),
            toFirestore: (summary, _) => summary.toJson()..remove('studentId'),
          );

  /// Сводка одного студента (`null`, если документа ещё нет).
  Stream<StudentSummary?> watchStudentSummary(String studentId) => _summaries
      .doc(studentId)
      .snapshots()
      .map((snap) => snap.data())
      .mapFailures();

  /// Сводка группы (P3-2).
  Stream<GroupSummary?> watchGroupSummary(String groupId) => _db
      .collection('groupSummaries')
      .doc(groupId)
      .snapshots()
      .map((s) => s.exists ? GroupSummary.fromMap(groupId, s.data()!) : null)
      .mapFailures();

  /// Сводка курса (P3-3).
  Stream<CourseSummary?> watchCourseSummary(String courseId) => _db
      .collection('courseSummaries')
      .doc(courseId)
      .snapshots()
      .map((s) => s.exists ? CourseSummary.fromMap(courseId, s.data()!) : null)
      .mapFailures();
}

/// Репозиторий статистики (read-only).
@Riverpod(keepAlive: true)
StatisticsRepository statisticsRepository(Ref ref) =>
    StatisticsRepository(ref.watch(firestoreProvider));

/// Сводка конкретного студента по id.
@riverpod
Stream<StudentSummary?> studentSummary(Ref ref, String studentId) =>
    ref.watch(statisticsRepositoryProvider).watchStudentSummary(studentId);

/// Сводка текущего пользователя (по `appUserProvider`).
@riverpod
Stream<StudentSummary?> mySummary(Ref ref) {
  final uid = ref.watch(appUserProvider).valueOrNull?.uid;
  if (uid == null) return Stream.value(null);
  return ref.watch(statisticsRepositoryProvider).watchStudentSummary(uid);
}

/// Сводка группы по id (P3-2).
@riverpod
Stream<GroupSummary?> groupSummary(Ref ref, String groupId) =>
    ref.watch(statisticsRepositoryProvider).watchGroupSummary(groupId);

/// Сводка курса по id (P3-3).
@riverpod
Stream<CourseSummary?> courseSummary(Ref ref, String courseId) =>
    ref.watch(statisticsRepositoryProvider).watchCourseSummary(courseId);
