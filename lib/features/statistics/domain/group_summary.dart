/// Сводка по группе ← коллекция `groupSummaries` (ТЗ §5.7.1, P3-2).
///
/// Пишется Cloud Function'ом; клиент только читает. Простой класс без codegen —
/// поля читаются из Map напрямую.
class GroupSummary {
  const GroupSummary({
    required this.groupId,
    this.studentCount = 0,
    this.averagePercentage = 0,
    this.atRiskCount = 0,
  });

  final String groupId;
  final int studentCount;
  final num averagePercentage;
  final int atRiskCount;

  int get averagePercent => (averagePercentage * 100).round();

  factory GroupSummary.fromMap(String groupId, Map<String, dynamic> map) =>
      GroupSummary(
        groupId: groupId,
        studentCount: (map['studentCount'] as num?)?.toInt() ?? 0,
        averagePercentage: (map['averagePercentage'] as num?) ?? 0,
        atRiskCount: (map['atRiskCount'] as num?)?.toInt() ?? 0,
      );
}
