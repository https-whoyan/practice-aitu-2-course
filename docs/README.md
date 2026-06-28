# Документация проекта

Кроссплатформенное учебное приложение (Flutter + Firebase) для управления курсами,
группами, заданиями, квизами, оценками и статистикой.

Исходное ТЗ: `../ТЗ_учебное_приложение_Flutter_Firebase.docx`

> **Статус:** Сессия 1 (Фундамент, ~35%) — ✅ реализована и проверена.
> Сессия 2 (~65%) — реализована; пройден аудит по ТЗ и исправление дефектов
> (2026-06-28…29): **P0 безопасность, P1 подключение бэкенда, P2 корректность
> данных, P3 заглушки→данные — закрыты**; P4/P5 — частично (см. ниже).
> Проверки: `flutter analyze` чисто (на ASCII-пути), `npm run build` в
> `functions/` чисто, Security Rules — 31/31 зелёные.
>
> Карта прогресса исправлений → [`session-2-fixes-checklist.md`](session-2-fixes-checklist.md).

## Содержание

- [`plan-overview.md`](plan-overview.md) — обзор плана, разбивка 35/65 на 2 сессии
- [`session-1-foundation.md`](session-1-foundation.md) — Сессия 1: Фундамент (~35%)
- [`session-2-features.md`](session-2-features.md) — Сессия 2: Основная функциональность (~65%)

### Аудит и исправление дефектов Сессии 2

- [`session-2-fixes-plan.md`](session-2-fixes-plan.md) — паттерн и приоритизированный план исправлений (P0–P5)
- [`session-2-fixes-checklist.md`](session-2-fixes-checklist.md) — чек-лист прогресса по задачам (актуальный статус)

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

### Детализация Сессии 2 (по шагам)

**Блок 4 — Админка**
- [`session-2-step-10-cloud-functions-admin.md`](session-2-step-10-cloud-functions-admin.md) — Шаг 10: Cloud Functions — каркас и admin-операции
- [`session-2-step-11-admin-users.md`](session-2-step-11-admin-users.md) — Шаг 11: Управление пользователями
- [`session-2-step-12-admin-groups-courses.md`](session-2-step-12-admin-groups-courses.md) — Шаг 12: Управление группами и курсами

**Блок 5 — Курсы, группы, материалы**
- [`session-2-step-13-course-domain.md`](session-2-step-13-course-domain.md) — Шаг 13: Домен курсов/групп/недель
- [`session-2-step-14-teacher-courses-weeks.md`](session-2-step-14-teacher-courses-weeks.md) — Шаг 14: Преподаватель — курсы и недели
- [`session-2-step-15-materials.md`](session-2-step-15-materials.md) — Шаг 15: Материалы курса
- [`session-2-step-16-student-courses-enrollment.md`](session-2-step-16-student-courses-enrollment.md) — Шаг 16: Студент — доступ к курсам и вступление в группу

**Блок 6 — Задания и оценки**
- [`session-2-step-17-assignments.md`](session-2-step-17-assignments.md) — Шаг 17: Задания
- [`session-2-step-18-submissions.md`](session-2-step-18-submissions.md) — Шаг 18: Отправки студента
- [`session-2-step-19-grading.md`](session-2-step-19-grading.md) — Шаг 19: Проверка и оценки

**Блок 7 — Банк вопросов и квизы ⭐**
- [`session-2-step-20-question-bank.md`](session-2-step-20-question-bank.md) — Шаг 20: Банк вопросов и типы вопросов
- [`session-2-step-21-question-import.md`](session-2-step-21-question-import.md) — Шаг 21: Импорт вопросов из TXT
- [`session-2-step-22-quiz-builder.md`](session-2-step-22-quiz-builder.md) — Шаг 22: Создание квиза и рандомайзер
- [`session-2-step-23-quiz-taking.md`](session-2-step-23-quiz-taking.md) — Шаг 23: Прохождение квиза студентом
- [`session-2-step-24-quiz-scoring.md`](session-2-step-24-quiz-scoring.md) — Шаг 24: Расчёт баллов на сервере

**Блок 8 — Статистика, уведомления, безопасность, тесты**
- [`session-2-step-25-statistics.md`](session-2-step-25-statistics.md) — Шаг 25: Статистика
- [`session-2-step-26-notifications.md`](session-2-step-26-notifications.md) — Шаг 26: Уведомления (in-app + push)
- [`session-2-step-27-security-rules.md`](session-2-step-27-security-rules.md) — Шаг 27: Полные Security Rules и Storage Rules
- [`session-2-step-28-testing-release.md`](session-2-step-28-testing-release.md) — Шаг 28: Тестирование и релизные сборки

### Разработка

- [`dev-runbook.md`](dev-runbook.md) — локальный запуск: эмуляторы, приложение, тесты
- [`git-workflow.md`](git-workflow.md) — структура веток, что сделано, сборка в Prct_46

### Персональные инструкции (заливка в Prct_46)

- [`teammate-yan.md`](teammate-yan.md) — Yan (ветки `yan` / `yan-s2`, заливает первым)
- [`teammate-beksultan.md`](teammate-beksultan.md) — Beksultan (ветки `beksultan` / `beksultan-s2`, второй)
- [`teammate-duran.md`](teammate-duran.md) — Duran (ветки `duran` / `duran-s2`, последний)

> Сессия 1 уже собрана в `main` Prct_46. Распределение и сборка Сессии 2
> (ветки `*-s2`) — в [`git-workflow.md`](git-workflow.md), раздел «Сессия 2».
> Каждый заливает свою ветку **сам**, по очереди `yan-s2 → beksultan-s2 → duran-s2`.
