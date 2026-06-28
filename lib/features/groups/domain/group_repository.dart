import 'group.dart';

/// Контракт доступа к группам (ТЗ §7.3). Реализация — поверх Firestore (data/).
///
/// Расширяется в шаге 13 при необходимости; админ — первый потребитель (шаг 12).
abstract class GroupRepository {
  /// Поток одной группы по id.
  Stream<Group?> watchGroup(String groupId);

  /// Разовое чтение группы.
  Future<Group?> getGroup(String groupId);

  /// Постраничный список групп (курсор `startAfter`, ТЗ §10).
  /// `includeArchived` по умолчанию false — архивные скрыты из активных списков.
  Future<List<Group>> fetchGroups({
    int limit = 20,
    String? startAfterId,
    bool includeArchived = false,
  });

  /// Поток списка групп (для реактивных экранов небольшого объёма).
  Stream<List<Group>> watchGroups({bool includeArchived = false});

  /// Группы, где пользователь — преподаватель.
  Stream<List<Group>> watchGroupsForTeacher(String teacherId);

  /// Группы, где пользователь — студент.
  Stream<List<Group>> watchGroupsForStudent(String studentId);

  /// Группы, связанные с любым из курсов (для «Моих групп» преподавателя —
  /// его курсы; `group.teacherIds` не заполняется, поэтому идём через курсы).
  Stream<List<Group>> watchGroupsForCourses(List<String> courseIds);

  /// Создаёт группу, возвращает id.
  Future<String> createGroup(Group group);

  /// Обновляет редактируемые поля группы.
  Future<void> updateGroup(Group group);

  /// Архивация (status → archived), без жёсткого удаления.
  Future<void> archiveGroup(String groupId);

  /// Добавляет студента в группу и зеркалит в `profiles.groupIds` (атомарно).
  Future<void> addStudent(String groupId, String studentId);

  /// Удаляет студента из группы и из зеркала `profiles.groupIds`.
  Future<void> removeStudent(String groupId, String studentId);

  /// Связывает группу и курс с двух сторон (`groups.courseIds` ↔ `courses.groupIds`).
  Future<void> linkCourse(String groupId, String courseId);

  /// Снимает связь группы и курса с двух сторон.
  Future<void> unlinkCourse(String groupId, String courseId);
}
