import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/error/error_mapper.dart';

part 'example_provider.g.dart';

/// ЭТАЛОН стиля «репозиторий + Riverpod-провайдер + Failure».
///
/// Все фичи Сессии 2 копируют эту структуру:
///   * `domain` — контракт репозитория (abstract interface);
///   * `data`   — реализация поверх провайдеров инстансов (`firestoreProvider`
///                и т.п. из `firebase/firebase_providers.dart`);
///   * `presentation` — провайдер состояния (`AsyncNotifier`) + экран.
///
/// Правила: доступ к данным только через репозиторий; ошибки маппятся в
/// [Failure] (`mapErrorToFailure`); UI работает с `AsyncValue`, а не с
/// сырыми исключениями.
abstract interface class ExampleRepository {
  Future<String> ping();
}

class StaticExampleRepository implements ExampleRepository {
  const StaticExampleRepository();

  @override
  Future<String> ping() async => 'pong';
}

@riverpod
ExampleRepository exampleRepository(Ref ref) =>
    const StaticExampleRepository();

/// Демонстрирует обработку ошибок: исключение → [Failure] → `AsyncValue.error`.
@riverpod
Future<String> examplePing(Ref ref) async {
  try {
    return await ref.watch(exampleRepositoryProvider).ping();
  } catch (error, stackTrace) {
    throw mapErrorToFailure(error, stackTrace);
  }
}
