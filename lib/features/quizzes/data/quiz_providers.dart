import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase/firebase_providers.dart';
import '../domain/quiz.dart';
import '../domain/quiz_repository.dart';
import 'firestore_quiz_repository.dart';

part 'quiz_providers.g.dart';

/// Репозиторий квизов (общий для конструктора и прохождения).
@Riverpod(keepAlive: true)
QuizRepository quizRepository(Ref ref) =>
    FirestoreQuizRepository(ref.watch(firestoreProvider));

/// Все квизы курса (преподаватель, конструктор — шаг 22).
@riverpod
Stream<List<Quiz>> courseQuizzes(Ref ref, String courseId) =>
    ref.watch(quizRepositoryProvider).watchQuizzes(courseId);

/// Только опубликованные квизы (студент — шаг 23).
@riverpod
Stream<List<Quiz>> publishedCourseQuizzes(Ref ref, String courseId) =>
    ref.watch(quizRepositoryProvider).watchPublishedQuizzes(courseId);

/// Один квиз по id (форма редактирования / просмотр).
@riverpod
Stream<Quiz?> quizById(Ref ref, String id) =>
    ref.watch(quizRepositoryProvider).watchQuiz(id);
