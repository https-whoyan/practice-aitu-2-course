import 'package:json_annotation/json_annotation.dart';

/// Роль пользователя (ТЗ §3). Источник истины — поле `role` в коллекции `users`;
/// дублируется в custom claims для серверных проверок (шаг 8 / Сессия 2).
enum UserRole {
  @JsonValue('admin')
  admin('admin'),
  @JsonValue('teacher')
  teacher('teacher'),
  @JsonValue('student')
  student('student');

  const UserRole(this.code);

  /// Строковый код для Firestore/claims (без «магических строк» в коде).
  final String code;

  /// Безопасный разбор кода (например, из custom claims). По умолчанию — student.
  static UserRole fromCode(String? code) => UserRole.values.firstWhere(
        (role) => role.code == code,
        orElse: () => UserRole.student,
      );

  bool get isAdmin => this == UserRole.admin;
  bool get isTeacher => this == UserRole.teacher;
  bool get isStudent => this == UserRole.student;
}
