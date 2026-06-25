import 'package:json_annotation/json_annotation.dart';

/// Статус аккаунта (ТЗ §5.1.2). Управляется системой/админом, пользователь сам
/// его не меняет (защищается Security Rules, шаг 8).
enum AccountStatus {
  @JsonValue('active')
  active('active'),
  @JsonValue('blocked')
  blocked('blocked'),
  @JsonValue('pendingVerification')
  pendingVerification('pendingVerification');

  const AccountStatus(this.code);

  final String code;

  static AccountStatus fromCode(String? code) => AccountStatus.values.firstWhere(
        (status) => status.code == code,
        orElse: () => AccountStatus.pendingVerification,
      );

  bool get isActive => this == AccountStatus.active;
  bool get isBlocked => this == AccountStatus.blocked;
}
