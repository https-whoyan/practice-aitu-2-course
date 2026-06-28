import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../firebase/firebase_providers.dart';
import '../../auth/domain/user_role.dart';

part 'admin_functions.g.dart';

/// Тонкие клиентские обёртки над admin-callable функциями (шаг 10).
///
/// Все критичные мутации над пользователями идут через сервер (`assertAdmin`),
/// а не записью в `users` с клиента (ТЗ §8.1). Ошибки маппятся в `Failure`.
class AdminFunctions {
  AdminFunctions(this._functions);

  final FirebaseFunctions _functions;

  Future<R> _call<R>(String name, [Map<String, dynamic>? data]) async {
    try {
      final result = await _functions.httpsCallable(name).call<R>(data);
      return result.data;
    } on FirebaseFunctionsException catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  /// Создаёт пользователя с указанной ролью (письмо установки пароля — ТЗ §17.1).
  Future<Map<String, dynamic>> createUser({
    required String email,
    required String firstName,
    required String lastName,
    required UserRole role,
  }) async {
    final res = await _call<Map<Object?, Object?>>('createUser', {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role.code,
    });
    return Map<String, dynamic>.from(res);
  }

  /// Создаёт преподавателя (роль фиксирована на сервере).
  Future<Map<String, dynamic>> createTeacher({
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    final res = await _call<Map<Object?, Object?>>('createTeacher', {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    });
    return Map<String, dynamic>.from(res);
  }

  Future<void> setUserRole({required String uid, required UserRole role}) =>
      _call<dynamic>('setUserRole', {'uid': uid, 'role': role.code});

  /// Сброс пароля существующему пользователю (P2-7). Возвращает reset-ссылку.
  Future<Map<String, dynamic>> resetUserPassword(String uid) async {
    final res = await _call<Map<Object?, Object?>>(
        'resetUserPassword', {'uid': uid});
    return Map<String, dynamic>.from(res);
  }

  Future<void> blockUser(String uid) => _call<dynamic>('blockUser', {'uid': uid});

  Future<void> unblockUser(String uid) =>
      _call<dynamic>('unblockUser', {'uid': uid});

  Future<void> softDeleteUser(String uid) =>
      _call<dynamic>('softDeleteUser', {'uid': uid});
}

@Riverpod(keepAlive: true)
AdminFunctions adminFunctions(Ref ref) =>
    AdminFunctions(ref.watch(firebaseFunctionsProvider));
