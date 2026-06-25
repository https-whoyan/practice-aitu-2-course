# Сессия 1 · Шаг 4 — Каркас стека и DI

Детализация шага 4 из [`session-1-foundation.md`](session-1-foundation.md), блок A (Инфраструктура).

> **Статус: ✅ Реализовано** (пост-аудит 2026-06-25). Код: `pubspec.yaml` (Riverpod
> code-gen + go_router + freezed), `lib/core/error/` (`Failure`), `lib/routing/`,
> `lib/services/`, эталон в `lib/shared/example/`.

> Формат: **Цель** · **Действия** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Зафиксированы и заведены базовые библиотеки — Riverpod (состояние/DI), go_router
(навигация), freezed + json_serializable (модели), плюс единый контракт обработки ошибок.
После этого все фичи пишутся по одному шаблону.

## Действия

1. Добавить зависимости:
   - state/DI: `flutter_riverpod`, `riverpod_annotation`;
   - роутинг: `go_router`;
   - модели/сериализация: `freezed_annotation`, `json_annotation`;
   - dev: `build_runner`, `freezed`, `json_serializable`, `riverpod_generator`,
     `custom_lint`, `riverpod_lint`.
2. Обернуть приложение в `ProviderScope` в bootstrap.
3. Настроить кодогенерацию: проверить
   `dart run build_runner build --delete-conflicting-outputs` на одном демо-freezed-классе;
   договориться о режиме `watch` при разработке.
4. **go_router**: создать `routing/app_router.dart` — провайдер роутера, корневые маршруты
   (пока: `/splash`, `/login`, `/home` — заглушки), точку для будущих guard'ов
   (`redirect`), типобезопасные пути через константы. `MaterialApp.router` в `app.dart`.
5. **Контракт ошибок** в `core/error/`: `Failure` (freezed union: `network`, `auth`,
   `permission`, `notFound`, `unknown`), функция-маппер `FirebaseException`/`Exception` →
   `Failure`. Опционально тип `Result<T>` (часто заменяется `AsyncValue` Riverpod).
6. **Базовый слой фичи (шаблон):** определить, как выглядит репозиторий и провайдер, на
   мини-примере (напр. `health`/`ping`-провайдер), чтобы у команды был эталон стиля.
7. **Логирование ошибок** — простой `AppLogger` (обёртка над `dart:developer log`), позже
   подключим Crashlytics; единая точка для необработанных ошибок (`FlutterError.onError`,
   `PlatformDispatcher.instance.onError`).
8. Прогнать `flutter analyze` + `custom_lint` (riverpod_lint) — чисто.

## Решения

- **State management — Riverpod** (зафиксировано в плане). Используем code-gen вариант
  (`@riverpod`) — меньше boilerplate, типобезопасно.
- **Роутинг — go_router**, декларативный, с `redirect` под role-guard'ы (реализуем в шаге 8).
- **Модели — freezed + json_serializable**, неизменяемые, с `fromJson/toJson`; для Firestore
  `Timestamp` — конвертеры в `core/utils/`.
- **Обработка ошибок — единый `Failure`-union + маппер**, UI работает с `AsyncValue`/`Failure`,
  а не с сырыми исключениями.
- **Кодогенерация** — `build_runner`; договорённость гонять `watch` локально, `build` в CI.

## Артефакты

Обновлённый `pubspec.yaml` (runtime + dev-зависимости), `ProviderScope` в bootstrap,
`routing/app_router.dart` + заглушки маршрутов, `core/error/failure.dart` + маппер,
`core/utils/` (конвертеры Timestamp), `services/logger.dart`, демо-провайдер-эталон,
сгенерированные `*.freezed.dart` / `*.g.dart`.

## Влияние на дальнейшие шаги

- Шаблон «фича = data/domain/presentation + Riverpod-провайдеры + freezed-модели + Failure»
  становится обязательным для всех фич Сессии 2.
- `redirect` в go_router — точка интеграции ролевых guard'ов (шаг 8).
- Провайдеры инстансов Firebase (шаг 2) + флаг эмулятора (шаг 3) + Failure-маппер (шаг 4) =
  готовая «труба» данных, по которой пойдут репозитории фич.

## Готово, когда

Приложение запускается через `MaterialApp.router` с go_router; есть рабочий freezed-класс с
прошедшей кодогенерацией; `ProviderScope` на месте; есть `Failure` и маппер; есть эталонный
провайдер/репозиторий, демонстрирующий стиль; `flutter analyze` + `custom_lint` проходят чисто.

---

**Зависимости:** [шаг 3](session-1-step-3-emulators.md) (и шаги 1–2). **Дальше:** шаг 5 —
Тема и базовые UI-компоненты (детализация позже), затем блок B (шаги 6–8: модель
пользователя, авторизация, роли).
