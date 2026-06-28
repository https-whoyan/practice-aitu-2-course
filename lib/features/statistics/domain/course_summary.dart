/// Сводка по курсу ← коллекция `courseSummaries` (ТЗ §5.7.2, P3-3).
///
/// Пишется Cloud Function'ом; клиент только читает.
class CourseSummary {
  const CourseSummary({
    required this.courseId,
    this.gradedCount = 0,
    this.studentCount = 0,
    this.averagePercentage = 0,
  });

  final String courseId;
  final int gradedCount;
  final int studentCount;
  final num averagePercentage;

  int get averagePercent => (averagePercentage * 100).round();

  factory CourseSummary.fromMap(String courseId, Map<String, dynamic> map) =>
      CourseSummary(
        courseId: courseId,
        gradedCount: (map['gradedCount'] as num?)?.toInt() ?? 0,
        studentCount: (map['studentCount'] as num?)?.toInt() ?? 0,
        averagePercentage: (map['averagePercentage'] as num?) ?? 0,
      );
}
