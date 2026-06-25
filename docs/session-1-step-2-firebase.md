# Сессия 1 · Шаг 2 — Подключение Firebase

Детализация шага 2 из [`session-1-foundation.md`](session-1-foundation.md), блок A (Инфраструктура).

> Формат: **Цель** · **Действия** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Flutter-приложение инициализирует Firebase и видит Auth/Firestore/Storage/Functions
на каждом окружении.

## Действия

1. Установить инструменты: `firebase-tools` (`npm i -g firebase-tools`, затем
   `firebase login`) и `flutterfire_cli` (`dart pub global activate flutterfire_cli`).
2. Создать проекты Firebase под окружения (раздельные проекты = чистая изоляция данных):
   - `eduapp-dev`, `eduapp-staging`, `eduapp-prod` (имена примерные).
   - На старте допустимо начать с одного `eduapp-dev` и добавить остальные перед релизом —
     но структуру кода сразу делаем мультиокруженческой.
3. Включить в консоли нужные сервисы: **Authentication** (провайдер Email/Password),
   **Cloud Firestore**, **Storage**, **Functions** (деплой требует плана Blaze; для
   эмулятора не обязателен).
4. Прописать конфиги клиента под каждый флейвор:
   ```bash
   flutterfire configure --project=eduapp-dev \
     --out=lib/firebase/firebase_options_dev.dart \
     --ios-bundle-id=com.example.eduapp.dev \
     --android-package-name=com.example.eduapp.dev
   ```
   (повторить для staging/prod; на iOS/Android появятся `GoogleService-Info.plist` /
   `google-services.json` — по флейворам).
5. Добавить зависимости в `pubspec.yaml`:
   `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`,
   `cloud_functions` (позже — `firebase_messaging`, `firebase_analytics`,
   `firebase_crashlytics`; в этом шаге не обязательны).
6. Инициализация в bootstrap: `WidgetsFlutterBinding.ensureInitialized()` →
   `Firebase.initializeApp(options: config.firebaseOptions)` до запуска `runApp`.
7. Завести провайдеры инстансов в `firebase/`:
   `firebaseAuthProvider`, `firestoreProvider`, `firebaseStorageProvider`,
   `functionsProvider` — чтобы фичи зависели от провайдеров, а не от глобальных синглтонов
   (упрощает тесты и подмену на эмулятор).
8. Smoke-тест: записать/прочитать тестовый документ Firestore, проверить, что Auth доступен.

## Решения

- **Раздельные Firebase-проекты на окружение** (а не один проект с префиксами). Причина:
  изоляция данных, отдельные Security Rules и квоты, безопаснее для prod.
- **Инстансы Firebase — через Riverpod-провайдеры**, не через `FirebaseFirestore.instance`
  напрямую в коде фич. Так в шаге 3 легко переключить их на эмулятор.
- **Файлы `firebase_options_*.dart`** — генерируются flutterfire, лежат под флейворы;
  по политике безопасности решить, коммитить ли (это публичные клиентские ключи, обычно
  можно; платформенные `google-services.json`/`plist` лучше не светить в публичном репо).

## Артефакты

`lib/firebase/firebase_options_{dev,staging,prod}.dart`, провайдеры инстансов
`lib/firebase/firebase_providers.dart`, обновлённые entrypoint'ы с инициализацией,
платформенные конфиги, секция `firebase` в `pubspec.yaml`.

## Готово, когда

Приложение стартует с реальной инициализацией Firebase без ошибок на web и Android;
smoke-тест чтения/записи Firestore проходит; нужный проект Firebase подхватывается по
флейвору.

---

**Зависимости:** [шаг 1](session-1-step-1-project-init.md) (проект и флейворы).
**Дальше:** [шаг 3 — Firebase Emulator Suite](session-1-step-3-emulators.md).
