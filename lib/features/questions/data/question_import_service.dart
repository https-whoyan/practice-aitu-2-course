import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../firebase/firebase_providers.dart';

part 'question_import_service.g.dart';

/// Клиентская обёртка над callable-функцией `importQuestions` (ТЗ §5.5.11).
///
/// Массовое создание вопросов идёт через сервер (валидация + запись пачкой),
/// а не множеством клиентских записей. Ошибки маппятся в `Failure`.
class QuestionImportService {
  QuestionImportService(this._functions);

  final FirebaseFunctions _functions;

  /// [questions] — список плоских map с ключами questionBank
  /// (text, type, topic, tags, difficulty, points, explanation, options,
  /// correctIndex, correctIndexes, correctBool, acceptedAnswers, caseSensitive,
  /// partialScoring, courseIds). Возвращает ответ функции (сводка импорта).
  Future<Map<String, dynamic>> importQuestions(
    List<Map<String, dynamic>> questions,
  ) async {
    try {
      final result = await _functions
          .httpsCallable('importQuestions')
          .call<Map<Object?, Object?>>({'questions': questions});
      return Map<String, dynamic>.from(result.data);
    } catch (error, stackTrace) {
      throw mapErrorToFailure(error, stackTrace);
    }
  }
}

@Riverpod(keepAlive: true)
QuestionImportService questionImportService(Ref ref) =>
    QuestionImportService(ref.watch(firebaseFunctionsProvider));
