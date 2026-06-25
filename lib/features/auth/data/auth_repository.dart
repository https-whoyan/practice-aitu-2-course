import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/error_mapper.dart';
import '../domain/account_status.dart';
import '../domain/app_user.dart';
import '../domain/auth_repository.dart';
import '../domain/user_profile.dart';
import '../domain/user_repository.dart';
import '../domain/user_role.dart';

/// Реализация [AuthRepository] поверх Firebase Auth + [UserRepository].
///
/// Все ошибки `FirebaseAuthException` маппятся в `Failure` (шаг 4).
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({
    required FirebaseAuth auth,
    required UserRepository users,
  })  :
        // ignore: prefer_initializing_formals
        _auth = auth,
        // ignore: prefer_initializing_formals
        _users = users;

  final FirebaseAuth _auth;
  final UserRepository _users;

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final uid = credential.user!.uid;
      final now = DateTime.now().toUtc();

      // Самостоятельная регистрация всегда создаёт student (ТЗ §5.1.1).
      await _users.createUserWithProfile(
        user: AppUser(
          uid: uid,
          email: email.trim(),
          role: UserRole.student,
          status: AccountStatus.pendingVerification,
          createdAt: now,
          emailVerified: false,
        ),
        profile: UserProfile(
          uid: uid,
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          displayName: '${firstName.trim()} ${lastName.trim()}'.trim(),
          createdAt: now,
          updatedAt: now,
        ),
      );

      await credential.user!.sendEmailVerification();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<bool> reloadAndCheckVerified() async {
    try {
      await _auth.currentUser?.reload();
      return _auth.currentUser?.emailVerified ?? false;
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}
