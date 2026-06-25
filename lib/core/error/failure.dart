import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Единый тип ошибок приложения.
///
/// Весь UI работает с [Failure] (через `AsyncValue`/обработчики), а не с сырыми
/// исключениями. Сырые `FirebaseException`/`Exception` маппятся в [Failure]
/// функцией `mapErrorToFailure` (см. `error_mapper.dart`).
@freezed
sealed class Failure with _$Failure {
  const Failure._();

  /// Проблема сети/доступности сервиса.
  const factory Failure.network({String? message}) = NetworkFailure;

  /// Ошибка аутентификации (с дружелюбным сообщением и кодом провайдера).
  const factory Failure.auth({
    required String message,
    String? code,
  }) = AuthFailure;

  /// Недостаточно прав (Security Rules / отказ доступа).
  const factory Failure.permission({String? message}) = PermissionFailure;

  /// Запрашиваемые данные не найдены.
  const factory Failure.notFound({String? message}) = NotFoundFailure;

  /// Непредвиденная ошибка.
  const factory Failure.unknown({String? message, Object? error}) =
      UnknownFailure;

  /// Человекочитаемое сообщение для отображения в UI.
  String get displayMessage => switch (this) {
        NetworkFailure(:final message) =>
          message ?? 'Проблема с подключением. Проверьте интернет и повторите.',
        AuthFailure(:final message) => message,
        PermissionFailure(:final message) =>
          message ?? 'Недостаточно прав для этого действия.',
        NotFoundFailure(:final message) => message ?? 'Данные не найдены.',
        UnknownFailure(:final message) =>
          message ?? 'Произошла непредвиденная ошибка. Попробуйте позже.',
      };
}
