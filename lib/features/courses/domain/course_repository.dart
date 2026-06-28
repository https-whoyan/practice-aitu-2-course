import 'course.dart';
import 'course_status.dart';

/// Контракт доступа к курсам (ТЗ §7.4). Реализация — поверх Firestore (data/).
///
/// Вводится в админке (шаг 12), расширяется неделями/контентом в шаге 13.
abstract class CourseRepository {
  Stream<Course?> watchCourse(String courseId);

  Future<Course?> getCourse(String courseId);

  /// Курсы преподавателя-владельца (ТЗ §5.4.1, шаг 14).
  Stream<List<Course>> watchCoursesByOwner(String teacherId);

  /// Курсы, доступные по группам студента (ТЗ §5.6.1, шаг 16).
  Stream<List<Course>> watchCoursesByGroups(List<String> groupIds);

  /// Постраничный список курсов (курсор `startAfter`, ТЗ §10).
  Future<List<Course>> fetchCourses({
    int limit = 20,
    String? startAfterId,
    bool includeArchived = false,
  });

  Stream<List<Course>> watchCourses({bool includeArchived = false});

  /// Курсы, которые ведёт преподаватель (в `teacherIds`).
  Stream<List<Course>> watchCoursesForTeacher(String teacherId);

  /// Курсы по списку id (для студента — из его групп/профиля).
  Stream<List<Course>> watchCoursesByIds(List<String> courseIds);

  Future<String> createCourse(Course course);

  Future<void> updateCourse(Course course);

  /// Меняет статус курса (черновик/активный/архивный, ТЗ §5.4.3).
  Future<void> setStatus(String courseId, CourseStatus status);

  Future<void> archiveCourse(String courseId);

  /// Полностью удаляет курс с неделями/материалами и снимает связи с группами
  /// (ТЗ §5.4.3). Запрещено, если есть оценки/отправки — такой курс архивируют.
  Future<void> deleteCourse(String courseId);

  /// Дублирует курс вместе с неделями и материалами; копия — черновик
  /// (ТЗ §5.4.3). Возвращает id нового курса. `copyToNewPeriod` — частный
  /// случай с очисткой дат недель.
  Future<String> duplicateCourse(String courseId, {bool resetWeekDates = false});
}
