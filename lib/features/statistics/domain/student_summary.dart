import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'risk_level.dart';

part 'student_summary.freezed.dart';
part 'student_summary.g.dart';

/// Сводная статистика студента ← коллекция `studentSummaries` (шаг 25).
///
/// Документ пишется Cloud Function'ом (docId = `studentId`); клиент читает
/// только для чтения. `averagePercentage` хранится в долях (0..1).
@freezed
abstract class StudentSummary with _$StudentSummary {
  const StudentSummary._();

  const factory StudentSummary({
    required String studentId,
    @Default(0) int totalGrades,
    @Default(0) int gradedQuizzes,
    @Default(0) int gradedAssignments,
    @Default(0) num averagePercentage,
    @Default(0) num averageQuizPercentage,
    @Default(0) int overdueCount,
    @Default(0) int upcomingCount,
    @Default(RiskLevel.low) RiskLevel riskLevel,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _StudentSummary;

  factory StudentSummary.fromJson(Map<String, dynamic> json) =>
      _$StudentSummaryFromJson(json);

  /// Средний результат в процентах (0..100) для отображения.
  int get averagePercent => (averagePercentage * 100).round();
}
