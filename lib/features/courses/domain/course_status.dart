import 'package:json_annotation/json_annotation.dart';

/// Статус курса (ТЗ §5.4.3): черновик → активный → архивный.
///
/// Отдельно от `EntityStatus` (группы), т.к. у курса есть промежуточный
/// «черновик» до публикации преподавателем.
enum CourseStatus {
  @JsonValue('draft')
  draft('draft', 'Черновик'),
  @JsonValue('active')
  active('active', 'Активный'),
  @JsonValue('archived')
  archived('archived', 'В архиве');

  const CourseStatus(this.code, this.label);

  final String code;
  final String label;

  static CourseStatus fromCode(String? code) => CourseStatus.values.firstWhere(
        (s) => s.code == code,
        orElse: () => CourseStatus.draft,
      );

  bool get isDraft => this == CourseStatus.draft;
  bool get isActive => this == CourseStatus.active;
  bool get isArchived => this == CourseStatus.archived;
}
