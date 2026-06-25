# Dev-runbook — локальная разработка

Вся разработка Сессии 1 ведётся **против Firebase Emulator Suite** (облако не
трогаем). Переключение «эмулятор ↔ облако» — одним флагом `AppConfig.useEmulators`
(включён только в dev-флейворе).

## Предусловия (один раз)

```bash
# Flutter в PATH
export PATH="$HOME/flutter/bin:$PATH"

# Зависимости проекта
flutter pub get

# Зависимости Cloud Functions (для эмулятора Functions)
cd functions && npm install && npm run build && cd ..
```

> Web использует chromium: `export CHROME_EXECUTABLE=/usr/bin/chromium`.

## 1. Поднять эмуляторы

```bash
# Все эмуляторы (auth/firestore/storage/functions) + UI на :4000
firebase emulators:start --project demo-eduapp-dev \
  --import=./.emulator-data --export-on-exit

# Только базовые (без functions — не требует npm install):
firebase emulators:start --only auth,firestore,storage \
  --project demo-eduapp-dev --import=./.emulator-data --export-on-exit
```

Порты (см. `firebase.json` и `lib/firebase/emulators.dart`):

| Сервис    | Порт |
|-----------|------|
| Auth      | 9099 |
| Firestore | 8080 |
| Storage   | 9199 |
| Functions | 5001 |
| **UI**    | **4000** → http://localhost:4000 |

`--export-on-exit` сохраняет данные эмулятора в `.emulator-data/` (в `.gitignore`),
`--import` восстанавливает их при следующем старте — тестовые пользователи/курсы
не пропадают между сессиями.

## 2. Запустить приложение (dev)

```bash
# Web
flutter run -t lib/main.dart -d chrome

# Android-эмулятор (хост виден как 10.0.2.2 — настроено в AppConfig)
flutter run --flavor dev -t lib/main.dart
```

В dev-флейворе bootstrap автоматически подключает SDK к эмуляторам
(`connectToEmulators`), и все чтения/записи идут в Emulator UI, а не в облако.

## 3. Тесты

```bash
# Unit/serialization (Dart VM)
flutter test

# Security Rules на эмуляторе (шаг 8)
cd test/security && npm install && npm test
```

> Примечание: в этом окружении путь проекта содержит кириллицу («Документы»),
> из-за чего LSP-сервер `flutter analyze` падает. Используйте `dart analyze lib`
> и `dart run custom_lint` — они работают корректно.
