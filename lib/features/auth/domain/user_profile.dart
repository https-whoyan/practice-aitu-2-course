import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/timestamp_converter.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// Редактируемый профиль пользователя ← коллекция `profiles` (ТЗ §7.2).
///
/// Эти поля пользователь правит сам; роль/статус/email — нет (см. [AppUser]).
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    @Default('') String firstName,
    @Default('') String lastName,
    String? displayName,
    String? photoUrl,
    @Default(<String>[]) List<String> groupIds,
    @Default(<String>[]) List<String> courseIds,
    @Default(<String>[]) List<String> teacherCourseIds,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _UserProfile;

  const UserProfile._();

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// Отображаемое имя: явное `displayName` или «Имя Фамилия».
  String get fullName {
    final explicit = displayName?.trim();
    if (explicit != null && explicit.isNotEmpty) return explicit;
    return '$firstName $lastName'.trim();
  }
}
