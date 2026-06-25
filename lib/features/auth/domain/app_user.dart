import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';
import 'account_status.dart';
import 'user_role.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// Системные данные пользователя ← коллекция `users` (ТЗ §7.1).
///
/// Роль и статус хранятся здесь и защищаются Security Rules (шаг 8):
/// пользователь не может сам поменять свою `role`/`status`/`email`.
/// Редактируемые данные (имя, фото) — в [UserProfile].
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String email,
    @Default(UserRole.student) UserRole role,
    @Default(AccountStatus.pendingVerification) AccountStatus status,
    @TimestampConverter() required DateTime createdAt,
    @NullableTimestampConverter() DateTime? lastLoginAt,
    @Default(false) bool emailVerified,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
