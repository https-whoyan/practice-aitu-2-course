# Документация проекта

Кроссплатформенное учебное приложение (Flutter + Firebase) для управления курсами,
группами, заданиями, квизами, оценками и статистикой.

Исходное ТЗ: `../ТЗ_учебное_приложение_Flutter_Firebase.docx`

> **Статус:** Сессия 1 (Фундамент, ~35%) — ✅ реализована и проверена
> (пост-аудит 2026-06-25: `dart analyze` чисто, 14 Flutter-тестов + 11 тестов
> Security Rules зелёные). Сессия 2 (~65%) — в планах.

## Содержание

- [`plan-overview.md`](plan-overview.md) — обзор плана, разбивка 35/65 на 2 сессии
- [`session-1-foundation.md`](session-1-foundation.md) — Сессия 1: Фундамент (~35%)
- [`session-2-features.md`](session-2-features.md) — Сессия 2: Основная функциональность (~65%)

### Детализация Сессии 1 (по шагам)

- [`session-1-step-1-project-init.md`](session-1-step-1-project-init.md) — Шаг 1: Инициализация проекта
- [`session-1-step-2-firebase.md`](session-1-step-2-firebase.md) — Шаг 2: Подключение Firebase
- [`session-1-step-3-emulators.md`](session-1-step-3-emulators.md) — Шаг 3: Firebase Emulator Suite
- [`session-1-step-4-stack-di.md`](session-1-step-4-stack-di.md) — Шаг 4: Каркас стека и DI
- [`session-1-step-5-theme-ui.md`](session-1-step-5-theme-ui.md) — Шаг 5: Тема и базовые UI-компоненты
- [`session-1-step-6-user-model.md`](session-1-step-6-user-model.md) — Шаг 6: Модель пользователя и данных
- [`session-1-step-7-auth.md`](session-1-step-7-auth.md) — Шаг 7: Авторизация
- [`session-1-step-8-roles-guards.md`](session-1-step-8-roles-guards.md) — Шаг 8: Роли и редирект
- [`session-1-step-9-navigation.md`](session-1-step-9-navigation.md) — Шаг 9: Скелет навигации и dashboard'ы

### Разработка

- [`dev-runbook.md`](dev-runbook.md) — локальный запуск: эмуляторы, приложение, тесты
- [`git-workflow.md`](git-workflow.md) — структура веток, что сделано, инструкция для команды
