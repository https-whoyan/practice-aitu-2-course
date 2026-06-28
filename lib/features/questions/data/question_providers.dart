import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../domain/question.dart';
import '../domain/question_repository.dart';
import 'firestore_question_repository.dart';

part 'question_providers.g.dart';

/// Репозиторий банка вопросов.
@Riverpod(keepAlive: true)
QuestionRepository questionRepository(Ref ref) =>
    FirestoreQuestionRepository(ref.watch(firestoreProvider));

/// Все вопросы преподавателя (новые сверху).
@riverpod
Stream<List<Question>> questionList(Ref ref, String ownerTeacherId) =>
    ref.watch(questionRepositoryProvider).watchQuestions(ownerTeacherId);

/// Один вопрос по id (форма редактирования).
@riverpod
Future<Question?> questionById(Ref ref, String id) =>
    ref.watch(questionRepositoryProvider).getQuestion(id);
