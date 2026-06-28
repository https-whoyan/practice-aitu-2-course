import 'package:json_annotation/json_annotation.dart';

/// Статус сущности контента (группы, курсы, недели, материалы, задания, квизы).
///
/// Архивация вместо удаления (ТЗ §5.3.4 п.3, §5.3.5 п.3): сохраняет связанные
/// данные и согласуется с мягким удалением пользователей (шаг 10).
enum EntityStatus {
  @JsonValue('active')
  active('active'),
  @JsonValue('archived')
  archived('archived');

  const EntityStatus(this.code);

  final String code;

  static EntityStatus fromCode(String? code) => EntityStatus.values.firstWhere(
        (status) => status.code == code,
        orElse: () => EntityStatus.active,
      );

  bool get isActive => this == EntityStatus.active;
  bool get isArchived => this == EntityStatus.archived;
}
