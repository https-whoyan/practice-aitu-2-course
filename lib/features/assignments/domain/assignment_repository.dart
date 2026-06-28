import 'assignment.dart';

/// Контракт доступа к заданиям курса (ТЗ §7.7, §5.4.5).
///
/// Общий контракт для преподавателя (шаг 17) и студента (шаг 18) — различие
/// только в правах и в том, видит ли студент неопубликованные задания
/// (правила шага 27).
abstract class AssignmentRepository {
  /// Все задания курса (для преподавателя).
  Stream<List<Assignment>> watchAssignmentsForCourse(String courseId);

  /// Только опубликованные задания курса (для студента, ТЗ §5.6.4).
  Stream<List<Assignment>> watchPublishedAssignmentsForCourse(String courseId);

  /// Задания конкретной недели.
  Stream<List<Assignment>> watchAssignmentsForWeek(String weekId);

  Stream<Assignment?> watchAssignment(String id);

  Future<Assignment?> getAssignment(String id);

  /// Добавляет задание, возвращает id.
  Future<String> createAssignment(Assignment a);

  Future<void> updateAssignment(Assignment a);

  Future<void> setPublished(String id, bool value);

  Future<void> deleteAssignment(String id);
}
