import 'package:edu_app/features/auth/data/auth_repository.dart';
import 'package:edu_app/features/auth/domain/app_user.dart';
import 'package:edu_app/features/auth/domain/user_profile.dart';
import 'package:edu_app/features/auth/domain/user_repository.dart';
import 'package:edu_app/features/auth/domain/user_role.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFirebaseAuth extends Mock implements FirebaseAuth {}

class _MockUserCredential extends Mock implements UserCredential {}

class _MockUser extends Mock implements User {}

/// In-memory реализация репозитория — фиксирует, что записал AuthRepository.
class _FakeUserRepository implements UserRepository {
  AppUser? createdUser;
  UserProfile? createdProfile;
  String? lastLoginUid;

  @override
  Future<void> createUserWithProfile({
    required AppUser user,
    required UserProfile profile,
  }) async {
    createdUser = user;
    createdProfile = profile;
  }

  @override
  Future<AppUser?> getUser(String uid) async => createdUser;

  @override
  Stream<AppUser?> watchUser(String uid) => Stream.value(createdUser);

  @override
  Stream<UserProfile?> watchProfile(String uid) => Stream.value(createdProfile);

  @override
  Future<void> updateProfile(UserProfile profile) async {}

  @override
  Future<void> updateLastLogin(String uid) async => lastLoginUid = uid;
}

void main() {
  late _MockFirebaseAuth auth;
  late _FakeUserRepository users;
  late FirebaseAuthRepository repo;

  setUp(() {
    auth = _MockFirebaseAuth();
    users = _FakeUserRepository();
    repo = FirebaseAuthRepository(auth: auth, users: users);
  });

  test('register создаёт student + пару users/profiles и шлёт верификацию',
      () async {
    final cred = _MockUserCredential();
    final user = _MockUser();
    when(() => auth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => cred);
    when(() => cred.user).thenReturn(user);
    when(() => user.uid).thenReturn('uid1');
    when(() => user.sendEmailVerification()).thenAnswer((_) async {});

    await repo.register(
      email: 'a@b.dev',
      password: 'password123',
      firstName: 'Иван',
      lastName: 'Иванов',
    );

    expect(users.createdUser, isNotNull);
    expect(users.createdUser!.role, UserRole.student); // ТЗ §5.1.1
    expect(users.createdUser!.email, 'a@b.dev');
    expect(users.createdProfile!.firstName, 'Иван');
    expect(users.createdProfile!.displayName, 'Иван Иванов');
    verify(() => user.sendEmailVerification()).called(1);
  });

  test('signIn вызывает signInWithEmailAndPassword', () async {
    when(() => auth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => _MockUserCredential());

    await repo.signIn(email: 'a@b.dev', password: 'password123');

    verify(() => auth.signInWithEmailAndPassword(
          email: 'a@b.dev',
          password: 'password123',
        )).called(1);
  });

  test('sendPasswordResetEmail проксирует в FirebaseAuth', () async {
    when(() => auth.sendPasswordResetEmail(email: any(named: 'email')))
        .thenAnswer((_) async {});

    await repo.sendPasswordResetEmail('a@b.dev');

    verify(() => auth.sendPasswordResetEmail(email: 'a@b.dev')).called(1);
  });

  test('signOut проксирует в FirebaseAuth', () async {
    when(() => auth.signOut()).thenAnswer((_) async {});
    await repo.signOut();
    verify(() => auth.signOut()).called(1);
  });
}
