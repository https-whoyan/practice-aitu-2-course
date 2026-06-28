import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../firebase/firebase_providers.dart';

part 'group_functions.g.dart';

/// Клиентские обёртки над групповыми Cloud Functions (шаг 16).
///
/// Проверка кода приглашения — на сервере (срок/лимит/привязка к группе);
/// клиент только вызывает callable и маппит ошибку в `Failure`.
class GroupFunctions {
  GroupFunctions(this._functions);

  final FirebaseFunctions _functions;

  /// Вступление в группу по коду. Возвращает `{groupId, title, courseIds}`.
  Future<Map<String, dynamic>> joinGroupByCode(String code) async {
    try {
      final res = await _functions
          .httpsCallable('joinGroupByCode')
          .call<Map<Object?, Object?>>({'code': code});
      return Map<String, dynamic>.from(res.data);
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }

  /// Создание кода приглашения (преподаватель/админ). Возвращает `{code, ...}`.
  Future<Map<String, dynamic>> createInviteCode({
    required String groupId,
    int? expiresInDays,
    int? maxUses,
  }) async {
    try {
      final res = await _functions.httpsCallable('createInviteCode').call<
          Map<Object?, Object?>>({
        'groupId': groupId,
        'expiresInDays': ?expiresInDays,
        'maxUses': ?maxUses,
      });
      return Map<String, dynamic>.from(res.data);
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}

@Riverpod(keepAlive: true)
GroupFunctions groupFunctions(Ref ref) =>
    GroupFunctions(ref.watch(firebaseFunctionsProvider));
