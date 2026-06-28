# Сессия 2 — Основная функциональность (~65%)

**Цель:** рабочее приложение по критериям приёмки. Идём по сущностям сверху вниз.

> **Статус: ✅ реализовано (MVP) + пройден аудит по ТЗ и исправление дефектов
> (2026-06-28…29).** Все блоки 4–8 реализованы: Cloud Functions (admin, инвайты,
> импорт вопросов, старт/расчёт квизов, аудит, уведомления, summary), доменные
> модели и репозитории на freezed/Riverpod, экраны преподавателя/студента/админа,
> Security и Storage Rules, индексы. `flutter analyze` — чисто; `tsc` функций —
> чисто; Security Rules — 31/31 зелёные.
>
> **После аудита (см. [`session-2-fixes-checklist.md`](session-2-fixes-checklist.md)):**
> закрыты P0 (безопасность: лок попыток квиза, дедлайны квиза/задания, сужение
> доступа преподавателя, isPublished для студента, анти-перебор кодов), P1
> (подключены коды приглашения, группы преподавателя, действия над вопросами,
> ручные оценки, reveal квиза, edit-профиль, email-верификация), P2 (соавторы/
> группы/удаление/даты/обложка курса, штраф за просрочку, статусы отправок,
> `groupId` оценок, фильтры, сброс пароля, уведомления студентам курса, выбор
> вопросов в квиз + `maxScore`, экран результатов квиза), P3 (dashboard'ы с
> данными, **статистика группы/курса больше не заглушка**, мониторинг студентов,
> фикс метрики просрочек).
>
> **MVP-срез / остаётся на согласование:** 4 типа вопросов (single/multiple/
> trueFalse/shortText — расширение до 12 в P4), push/FCM и offline (P4), in-app
> YouTube — превью+открытие (полноценный iframe-плеер блокирует build_runner,
> см. `docs/dev-runbook.md`), системные настройки типов вопросов + журнал ошибок
> (P3-8). Детализация по шагам — в `session-2-step-10..28-*.md`.

## 4. Админка

- [x] Управление пользователями (создание преподавателей через Cloud Function,
      блокировка, назначение ролей)
- [x] Управление группами и курсами (CRUD, назначения)

Детализация:

- [`session-2-step-10-cloud-functions-admin.md`](session-2-step-10-cloud-functions-admin.md) — Шаг 10: Cloud Functions — каркас и admin-операции
- [`session-2-step-11-admin-users.md`](session-2-step-11-admin-users.md) — Шаг 11: Админка — управление пользователями
- [`session-2-step-12-admin-groups-courses.md`](session-2-step-12-admin-groups-courses.md) — Шаг 12: Админка — группы и курсы

## 5. Курсы, группы, материалы

- [x] Группы, курсы, недели курса (CRUD)
- [x] Материалы (текст, ссылка, файл, YouTube-видео внутри приложения)
- [x] Публикация/скрытие, доступ студентов к курсам

Детализация:

- [`session-2-step-13-course-domain.md`](session-2-step-13-course-domain.md) — Шаг 13: Домен курсов/групп/недель (модели + репозитории)
- [`session-2-step-14-teacher-courses-weeks.md`](session-2-step-14-teacher-courses-weeks.md) — Шаг 14: Преподаватель — курсы и недели
- [`session-2-step-15-materials.md`](session-2-step-15-materials.md) — Шаг 15: Материалы курса (текст/ссылка/файл/YouTube)
- [`session-2-step-16-student-courses-enrollment.md`](session-2-step-16-student-courses-enrollment.md) — Шаг 16: Студент — доступ к курсам и вступление в группу

## 6. Задания и оценки

- [x] Создание заданий, дедлайны
- [x] Отправка студентом (текст/файл/ссылка)
- [x] Проверка, выставление оценок, комментарии, журнал оценок

Детализация:

- [`session-2-step-17-assignments.md`](session-2-step-17-assignments.md) — Шаг 17: Задания (создание, дедлайны, публикация)
- [`session-2-step-18-submissions.md`](session-2-step-18-submissions.md) — Шаг 18: Отправки студента
- [`session-2-step-19-grading.md`](session-2-step-19-grading.md) — Шаг 19: Проверка и оценки (журнал оценок)

## 7. Банк вопросов и квизы ⭐ (самый объёмный блок, ~половина сессии)

- [x] Банк вопросов + основные типы (single / multiple / true-false / текст —
      остальные при наличии времени)
- [x] Импорт TXT с предпросмотром и валидацией
- [x] Создание квиза, рандомайзер по категориям
- [x] Прохождение квиза студентом, snapshot вопросов
- [x] Расчёт баллов на сервере (Cloud Function)

Детализация:

- [`session-2-step-20-question-bank.md`](session-2-step-20-question-bank.md) — Шаг 20: Банк вопросов и типы вопросов
- [`session-2-step-21-question-import.md`](session-2-step-21-question-import.md) — Шаг 21: Импорт вопросов из TXT
- [`session-2-step-22-quiz-builder.md`](session-2-step-22-quiz-builder.md) — Шаг 22: Создание квиза и рандомайзер
- [`session-2-step-23-quiz-taking.md`](session-2-step-23-quiz-taking.md) — Шаг 23: Прохождение квиза студентом
- [`session-2-step-24-quiz-scoring.md`](session-2-step-24-quiz-scoring.md) — Шаг 24: Расчёт баллов на сервере

## 8. Статистика, уведомления, безопасность, тесты

- [x] Статистика студента / группы / курса
- [x] Уведомления (in-app + push)
- [x] Доработать и протестировать Security Rules
- [x] Тестирование (web / Android / iOS), фиксы, релизные сборки

Детализация:

- [`session-2-step-25-statistics.md`](session-2-step-25-statistics.md) — Шаг 25: Статистика (студент/группа/курс)
- [`session-2-step-26-notifications.md`](session-2-step-26-notifications.md) — Шаг 26: Уведомления (in-app + push)
- [`session-2-step-27-security-rules.md`](session-2-step-27-security-rules.md) — Шаг 27: Полные Security Rules и Storage Rules
- [`session-2-step-28-testing-release.md`](session-2-step-28-testing-release.md) — Шаг 28: Тестирование и релизные сборки

## MVP-приоритет (если время поджимает)

Блок 7 — кандидат №1 на сокращение: оставить 4 типа вопросов вместо 12.
Остальные блоки тоже резать до базового CRUD без «продвинутых» опций
(штрафы за просрочку, частичное начисление баллов, связанные копии вопросов).

## Карта шагов Сессии 2

| Блок | Шаги | Сущности / коллекции |
|------|------|----------------------|
| 4. Админка | 10–12 | Cloud Functions, `users`, `profiles`, `roles`, `groups`, `courses`, `auditLogs` |
| 5. Курсы и материалы | 13–16 | `courses`, `groups`, `courseWeeks`, `materials`, `inviteCodes` |
| 6. Задания и оценки | 17–19 | `assignments`, `submissions`, `grades` |
| 7. Банк вопросов и квизы ⭐ | 20–24 | `questionBank`, `quizzes`, `quizAttempts` |
| 8. Статистика, уведомления, безопасность | 25–28 | `notifications`, summary-документы, Security/Storage Rules, релиз |
