import 'package:firebase_auth/firebase_auth.dart';

import 'failure.dart';

/// Маппит любое исключение в единый [Failure].
///
/// Точка преобразования сырых ошибок Firebase/Dart в доменный тип, с которым
/// дальше работает весь UI.
Failure mapErrorToFailure(Object error, [StackTrace? stackTrace]) {
  if (error is Failure) return error;

  if (error is FirebaseAuthException) {
    return Failure.auth(message: _authMessage(error), code: error.code);
  }

  if (error is FirebaseException) {
    switch (error.code) {
      case 'permission-denied':
        return Failure.permission(message: error.message);
      case 'not-found':
        return Failure.notFound(message: error.message);
      case 'unavailable':
      case 'network-request-failed':
      case 'deadline-exceeded':
        return Failure.network(message: error.message);
      default:
        return Failure.unknown(message: error.message, error: error);
    }
  }

  return Failure.unknown(error: error);
}

/// Переводит коды `FirebaseAuthException` в дружелюбные сообщения (ТЗ §5.1).
String _authMessage(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      return 'Некорректный email.';
    case 'user-disabled':
      return 'Аккаунт заблокирован.';
    case 'user-not-found':
    case 'wrong-password':
    case 'invalid-credential':
      return 'Неверный email или пароль.';
    case 'email-already-in-use':
      return 'Этот email уже зарегистрирован.';
    case 'weak-password':
      return 'Слишком простой пароль (минимум 6 символов).';
    case 'too-many-requests':
      return 'Слишком много попыток. Попробуйте позже.';
    case 'network-request-failed':
      return 'Проблема с сетью. Проверьте подключение.';
    case 'operation-not-allowed':
      return 'Этот способ входа отключён.';
    default:
      return e.message ?? 'Ошибка аутентификации.';
  }
}
