import 'material.dart';

/// Контракт доступа к учебным материалам недели (ТЗ §7.6).
///
/// Материалы сортируются по `orderIndex`. Общий контракт для преподавателя
/// (все материалы) и студента (только опубликованные) — различие в правах
/// (правила шага 27).
abstract class MaterialRepository {
  /// Все материалы недели по порядку (для преподавателя).
  Stream<List<CourseMaterial>> watchMaterials(String weekId);

  /// Только опубликованные материалы недели (для студента).
  Stream<List<CourseMaterial>> watchPublishedMaterials(String weekId);

  Future<CourseMaterial?> getMaterial(String id);

  /// Добавляет материал, возвращает id.
  Future<String> addMaterial(CourseMaterial m);

  Future<void> updateMaterial(CourseMaterial m);

  Future<void> deleteMaterial(String id);

  /// Переупорядочивает материалы недели: `orderedIds` в новом порядке.
  Future<void> reorder(String weekId, List<String> orderedIds);

  Future<void> setPublished(String id, bool value);
}
