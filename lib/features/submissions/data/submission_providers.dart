import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../../auth/data/auth_providers.dart';
import '../domain/submission.dart';
import '../domain/submission_repository.dart';
import 'firestore_submission_repository.dart';

part 'submission_providers.g.dart';

/// Репозиторий ответов студентов (общий для шагов 18 и 19).
@Riverpod(keepAlive: true)
SubmissionRepository submissionRepository(Ref ref) =>
    FirestoreSubmissionRepository(
      ref.watch(firestoreProvider),
      ref.watch(firebaseStorageProvider),
    );

/// Ответ текущего студента на задание (для экрана отправки).
/// Если пользователь не определён — поток `null` (нечего показывать).
@riverpod
Stream<Submission?> mySubmission(Ref ref, String assignmentId) {
  final uid = ref.watch(appUserProvider).valueOrNull?.uid;
  if (uid == null) return Stream.value(null);
  return ref
      .watch(submissionRepositoryProvider)
      .watchMySubmission(assignmentId, uid);
}

/// Все ответы на задание (для преподавателя, шаг 19).
@riverpod
Stream<List<Submission>> submissionsForAssignment(
  Ref ref,
  String assignmentId,
) =>
    ref
        .watch(submissionRepositoryProvider)
        .watchSubmissionsForAssignment(assignmentId);
