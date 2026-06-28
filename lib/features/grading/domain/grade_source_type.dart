import 'package:json_annotation/json_annotation.dart';

/// Источник оценки (ТЗ §7.9). Хранится в поле `sourceType` коллекции `grades`.
///
/// Различает происхождение оценки: автоматическая (за задание/квиз) или
/// проставленная преподавателем вручную. По умолчанию — [GradeSourceType.manual].
enum GradeSourceType {
  @JsonValue('assignment')
  assignment('assignment'),
  @JsonValue('quiz')
  quiz('quiz'),
  @JsonValue('manual')
  manual('manual');

  const GradeSourceType(this.code);

  /// Строковый код для Firestore (без «магических строк» в коде).
  final String code;

  /// Человекочитаемая подпись для UI.
  String get label {
    switch (this) {
      case GradeSourceType.assignment:
        return 'За задание';
      case GradeSourceType.quiz:
        return 'За квиз';
      case GradeSourceType.manual:
        return 'Вручную';
    }
  }

  /// Безопасный разбор кода. По умолчанию — [GradeSourceType.manual].
  static GradeSourceType fromCode(String? code) =>
      GradeSourceType.values.firstWhere(
        (type) => type.code == code,
        orElse: () => GradeSourceType.manual,
      );
}
