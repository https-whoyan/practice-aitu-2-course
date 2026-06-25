# Сессия 1 · Шаг 1 — Инициализация проекта

Детализация шага 1 из [`session-1-foundation.md`](session-1-foundation.md), блок A (Инфраструктура).

> **Статус: ✅ Реализовано** (пост-аудит 2026-06-25). Код: структура `lib/`,
> flavors `lib/main.dart` · `lib/main_staging.dart` · `lib/main_prod.dart`,
> `lib/core/config/app_config.dart`, `analysis_options.yaml`.

> Формат: **Цель** · **Действия** · **Структура** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Есть пустой, но правильно структурированный Flutter-проект, который собирается на
web/Android/iOS, лежит под git и умеет переключать окружения dev/staging/prod.

## Действия

1. Проверить окружение: `flutter --version` (стабильный канал), `flutter doctor` — закрыть
   все красные пункты для нужных платформ (web, Android SDK, Xcode при наличии Mac).
2. Создать проект:
   ```bash
   flutter create --org com.example.eduapp \
     --platforms=web,android,ios \
     --project-name edu_app .
   ```
   (`edu_app` и `org` — заменить на финальные; `.` = текущая папка проекта).
3. Зафиксировать версию Flutter для команды через `fvm` (опционально, но желательно):
   `fvm use stable` → создаёт `.fvmrc`, гарантирует одинаковую версию у всех.
4. Развернуть структуру папок (см. ниже) — пока пустые папки с `.gitkeep` или placeholder.
5. Настроить git: `git init`, `.gitignore` (Flutter-шаблон + `*.env`, `.fvm/`,
   при необходимости платформенные секреты), первый коммит.
6. Настроить три окружения (см. **Решения**).
7. Подключить линтер: `flutter_lints` (или строже — `very_good_analysis`), привести
   `analysis_options.yaml`, прогнать `flutter analyze`.

## Структура папок

Из ТЗ §15 (рекомендованная структура) + feature-first внутри `lib/`:

```
lib/
  core/              # базовые утилиты, константы, расширения, Result/Failure, типы
    config/          # env-конфиг, флаги окружения
    error/           # Failure, exceptions, маппинг ошибок
    utils/           # хелперы, форматтеры, валидаторы
  shared/            # переиспользуемые виджеты, общие провайдеры
    widgets/         # кнопки, поля, лоадеры, скелетоны
  theme/             # ThemeData, цвета, типографика, light/dark
  routing/           # go_router, маршруты, guards
  services/          # обёртки над внешними сервисами
  firebase/          # firebase_options, инициализация, провайдеры инстансов
  features/          # фичи по доменам (auth, profile, courses, quizzes, ...)
    <feature>/
      data/          # DTO-модели, реализации репозиториев, источники данных
      domain/        # сущности, контракты репозиториев, use-cases (если нужны)
      presentation/  # экраны, виджеты фичи, провайдеры состояния
  app.dart           # корневой виджет (MaterialApp.router)
  main.dart          # bootstrap по умолчанию (dev)
  main_staging.dart  # entrypoint для staging (если flavors)
  main_prod.dart     # entrypoint для prod
test/                # зеркалит lib/ по структуре
```

> Слои `data / domain / presentation` живут **внутри каждой фичи**, а не глобально — так
> фича остаётся самодостаточной. Глобальные `data/domain` из ТЗ — это `core` + `services`.

## Решения (зафиксировать)

- **Окружения dev/staging/prod.** Способ: **Flutter flavors** + отдельный entrypoint на
  каждое окружение (`main.dart` / `main_staging.dart` / `main_prod.dart`). Каждое окружение
  → отдельный проект Firebase (шаг 2). Лёгкая альтернатива на старте —
  `--dart-define=ENV=dev|staging|prod` и выбор конфига в рантайме; но flavors чище для
  раздельных Firebase-проектов и app id (`com.example.eduapp.dev`). **Берём flavors.**
- **Конфиг окружения** — класс `AppConfig` в `core/config/` с полями (`env`, `useEmulators`,
  `emulatorHost`, `firebaseOptions`), собирается в bootstrap по флейвору.
- **Линтер** — `flutter_lints` на старте, ужесточаем позже при необходимости.
- **Версия Flutter** — пинуем через `fvm` (`.fvmrc` в репо).

## Артефакты

`pubspec.yaml`, дерево папок `lib/`, `.gitignore`, `analysis_options.yaml`, `.fvmrc`,
три entrypoint-файла, заготовка `core/config/app_config.dart`, первый git-коммит.

## Готово, когда

`flutter run -d chrome` и `flutter run` (эмулятор Android) запускают пустое приложение;
`flutter analyze` — без ошибок; структура папок на месте; репозиторий под git с первым
коммитом; флейворы переключаются (хотя бы на уровне разного app id / названия).

---

**Зависимости:** ничего не требует. **Дальше:** [шаг 2 — Подключение Firebase](session-1-step-2-firebase.md).
