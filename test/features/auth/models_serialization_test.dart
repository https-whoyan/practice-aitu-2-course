import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/features/auth/domain/account_status.dart';
import 'package:edu_app/features/auth/domain/app_user.dart';
import 'package:edu_app/features/auth/domain/user_profile.dart';
import 'package:edu_app/features/auth/domain/user_role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserRole', () {
    test('коды и разбор', () {
      expect(UserRole.admin.code, 'admin');
      expect(UserRole.fromCode('teacher'), UserRole.teacher);
      expect(UserRole.fromCode(null), UserRole.student); // дефолт
      expect(UserRole.fromCode('garbage'), UserRole.student);
    });
  });

  group('AccountStatus', () {
    test('коды и разбор', () {
      expect(AccountStatus.blocked.code, 'blocked');
      expect(AccountStatus.fromCode('active'), AccountStatus.active);
      expect(AccountStatus.fromCode(null), AccountStatus.pendingVerification);
    });
  });

  group('AppUser', () {
    test('round-trip toJson/fromJson с Timestamp', () {
      final created = DateTime.utc(2026, 1, 2, 3, 4, 5);
      final user = AppUser(
        uid: 'u1',
        email: 'a@b.dev',
        role: UserRole.admin,
        status: AccountStatus.active,
        createdAt: created,
        emailVerified: true,
      );

      final json = user.toJson();
      // Конвертер превратил DateTime в Firestore Timestamp.
      expect(json['createdAt'], isA<Timestamp>());
      expect(json['role'], 'admin');
      expect(json['status'], 'active');

      final restored = AppUser.fromJson(json);
      expect(restored, user);
      expect(restored.createdAt, created);
    });

    test('fromJson похожего на Firestore документа (дефолты)', () {
      final user = AppUser.fromJson({
        'uid': 'u2',
        'email': 's@b.dev',
        'role': 'student',
        'status': 'pendingVerification',
        'createdAt': Timestamp.fromDate(DateTime.utc(2026)),
        'lastLoginAt': null,
        'emailVerified': false,
      });
      expect(user.role, UserRole.student);
      expect(user.status, AccountStatus.pendingVerification);
      expect(user.lastLoginAt, isNull);
    });
  });

  group('UserProfile', () {
    test('round-trip и fullName', () {
      final now = DateTime.utc(2026, 5, 5);
      final profile = UserProfile(
        uid: 'u1',
        firstName: 'Иван',
        lastName: 'Иванов',
        groupIds: const ['g1'],
        createdAt: now,
        updatedAt: now,
      );

      final restored = UserProfile.fromJson(profile.toJson());
      expect(restored, profile);
      expect(restored.fullName, 'Иван Иванов');
      expect(restored.groupIds, ['g1']);
    });

    test('fullName предпочитает displayName', () {
      final now = DateTime.utc(2026);
      final profile = UserProfile(
        uid: 'u1',
        firstName: 'Иван',
        lastName: 'Иванов',
        displayName: 'Ваня',
        createdAt: now,
        updatedAt: now,
      );
      expect(profile.fullName, 'Ваня');
    });
  });
}
