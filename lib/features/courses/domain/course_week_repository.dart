import 'course_week.dart';

/// Контракт доступа к неделям курса (ТЗ §7.5, §5.4.4).
///
/// Недели сортируются по `orderIndex`. Общий контракт для преподавателя
/// (шаг 14) и студента (шаг 16) — различие только в правах (правила шага 27).
abstract class CourseWeekRepository {
  /// Все недели курса по порядку (для преподавателя).
  Stream<List<CourseWeek>> watchWeeks(String courseId);

  /// Только опубликованные недели (для студента, ТЗ §5.6.3).
  Stream<List<CourseWeek>> watchPublishedWeeks(String courseId);

  Future<CourseWeek?> getWeek(String weekId);

  /// Добавляет неделю, возвращает id (orderIndex проставляется вызывающим).
  Future<String> addWeek(CourseWeek week);

  Future<void> updateWeek(CourseWeek week);

  Future<void> deleteWeek(String weekId);

  /// Переупорядочивает недели: `orderedWeekIds` в новом порядке.
  Future<void> reorderWeeks(String courseId, List<String> orderedWeekIds);

  Future<void> setPublished(String weekId, bool value);
}
