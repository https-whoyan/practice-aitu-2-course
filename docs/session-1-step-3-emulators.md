# Сессия 1 · Шаг 3 — Firebase Emulator Suite

Детализация шага 3 из [`session-1-foundation.md`](session-1-foundation.md), блок A (Инфраструктура).

> **Статус: ✅ Реализовано** (пост-аудит 2026-06-25). Код: `firebase.json`,
> `firestore.rules`, `storage.rules`, `firestore.indexes.json`,
> `lib/firebase/emulators.dart`, `functions/`. Запуск — [`dev-runbook.md`](dev-runbook.md).

> Формат: **Цель** · **Действия** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Вся разработка идёт локально против эмуляторов (Auth/Firestore/Storage/Functions),
прод и dev-данные не трогаются; Security Rules можно писать и тестировать офлайн.

## Действия

1. Инициализировать Firebase в репозитории: `firebase init` → выбрать Firestore, Storage,
   Functions, **Emulators**. Появятся `firebase.json`, `.firebaserc`, `firestore.rules`,
   `firestore.indexes.json`, `storage.rules`, папка `functions/`.
2. Настроить порты эмуляторов в `firebase.json` (Auth, Firestore, Storage, Functions,
   плюс **Emulator UI** на :4000 для просмотра данных).
3. В коде — подключать эмуляторы **только когда `config.useEmulators == true`** (флейвор dev):
   ```dart
   if (config.useEmulators) {
     await FirebaseAuth.instance.useAuthEmulator(config.emulatorHost, 9099);
     FirebaseFirestore.instance.useFirestoreEmulator(config.emulatorHost, 8080);
     await FirebaseStorage.instance.useStorageEmulator(config.emulatorHost, 9199);
     FirebaseFunctions.instance.useFunctionsEmulator(config.emulatorHost, 5001);
   }
   ```
4. Настроить запуск: `firebase emulators:start` (опц. `--import=./.emulator-data
   --export-on-exit` — чтобы сохранять/восстанавливать данные между сессиями).
5. Положить базовый `firestore.rules` (каркас «всё закрыто», откроем по ролям в шаге 8) и
   `storage.rules`.
6. Описать в доке короткий dev-флоу: «поднять эмуляторы → запустить app в dev».

## Решения

- **Хост эмулятора зависит от платформы:** web/desktop → `localhost`, Android-эмулятор →
  `10.0.2.2`. Вынести в `AppConfig` (`emulatorHost`) — определяется по платформе в bootstrap.
- **Импорт/экспорт данных эмулятора** — включаем (`--export-on-exit`), чтобы тестовые
  пользователи/курсы не пропадали между запусками; папку `.emulator-data` — в `.gitignore`.
- **Functions в эмуляторе** пишем на TypeScript (`functions/` наполняется в Сессии 2, но
  эмулятор настраиваем уже сейчас).

## Артефакты

`firebase.json`, `.firebaserc`, `firestore.rules` (каркас), `firestore.indexes.json`,
`storage.rules`, папка `functions/` (заготовка), правка bootstrap для подключения
эмуляторов, запись в `.gitignore` (`.emulator-data/`), краткий dev-runbook в доке.

## Готово, когда

`firebase emulators:start` поднимает все эмуляторы, Emulator UI открывается; приложение в
dev-флейворе пишет/читает данные **в эмулятор** (видно в UI), а не в облако; переключение
«эмулятор ↔ реальный Firebase» управляется одним флагом конфига.

---

**Зависимости:** [шаг 2](session-1-step-2-firebase.md) (Firebase подключён, провайдеры инстансов).
**Дальше:** [шаг 4 — Каркас стека и DI](session-1-step-4-stack-di.md).
