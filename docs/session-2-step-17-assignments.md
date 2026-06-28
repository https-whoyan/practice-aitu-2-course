# Сессия 2 · Шаг 17 — Задания

Детализация шага 17 из [`session-2-features.md`](session-2-features.md), блок 6 (Задания и оценки).

> **Статус: 📋 Запланировано** (Сессия 2). Реализуется в Prct_46.
> Планируемые пути: `lib/features/assignments/{domain,data,presentation}/`, `firestore.rules`
> (коллекция `assignments`). Соответствие ТЗ §5.4.6, §7.7. НЕ реализовано — план.

> Формат: **Цель** · **Действия** · **Модель данных и статусы** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Преподаватель создаёт, редактирует и публикует задания с дедлайном, максимальным баллом и
типом ответа студента; задание привязано к курсу (шаг 13) и неделе (шаг 14). Студент видит
задание со статусом своего прохождения. Это фундамент для отправок (шаг 18) и оценок
(шаг 19). Соответствие ТЗ §5.4.6, §7.7.

## Действия

1. **Фича `assignments`**: создать `lib/features/assignments/{domain,data,presentation}/` по
   эталон-шаблону репозитория поверх `firestoreProvider` (шаг 4).
2. **freezed-модель `Assignment`** (шаг 4) ← коллекция `assignments` (ТЗ §7.7): `assignmentId`,
   `courseId`, `weekId`, `title`, `description`, `instruction`, `deadline`, `maxScore`,
   `submissionType`, `allowLateSubmission`, `isPublished`, `createdAt`, `updatedAt`;
   `fromJson/toJson` + конвертеры `Timestamp ↔ DateTime` (шаг 4).
3. **Enum `SubmissionType`** со строковыми кодами (ТЗ §5.4.6): `text`, `file`, `link`,
   `combined`, `none` (информационное задание без отправки).
4. **Enum `StudentAssignmentStatus`** (ТЗ §5.4.6) — производный статус задания для студента,
   вычисляется из его отправки и дедлайна (см. ниже); сама отправка — шаг 18.
5. **Контракт `AssignmentRepository`** в `domain/`: `watchAssignmentsForCourse(courseId)`,
   `watchAssignmentsForWeek(weekId)`, `getAssignment(id)`, `createAssignment(...)`,
   `updateAssignment(...)`, `publish(id)` / `unpublish(id)`, `deleteAssignment(id)`.
6. **Реализация `FirestoreAssignmentRepository`** в `data/`: типобезопасный `withConverter`,
   ошибки → `Failure` (шаг 4); `@riverpod`-провайдеры `assignmentRepositoryProvider` и
   стримы списков по курсу/неделе.
7. **Экраны преподавателя** (UI-кит шага 5): создание/редактирование задания и публикация —
   форма с полями ТЗ §7.7, выбор `submissionType`, переключатели `allowLateSubmission` и
   `isPublished`, валидация дедлайна и `maxScore > 0` (см. таблицу «Экраны»).
8. **Привязка к курсу/неделе** (шаги 13–14): задание создаётся только в контексте своей недели
   своего курса; список заданий встроен в страницу курса/недели преподавателя (шаг 14).
9. **Маршруты** go_router (шаг 9): подразделы преподавателя для создания и проверки задания
   (проверка детально — шаг 19); guard `requireRole({teacher, admin})`.
10. **Видимость для студента**: студент видит только `isPublished == true` задания своих курсов
    (черновики скрыты Security Rules — шаг 27).

## Модель данных (ТЗ §7.7)

| Коллекция | Документ | Ключевые поля |
|-----------|----------|---------------|
| `assignments` | `Assignment` | `assignmentId, courseId, weekId, title, description, instruction, deadline, maxScore, submissionType, allowLateSubmission, isPublished, createdAt, updatedAt` |

**`SubmissionType` (ТЗ §5.4.6):** `text` (текст) · `file` (файл) · `link` (ссылка) ·
`combined` (комбинированный) · `none` (без отправки, информационное задание).

**Статусы задания для студента — `StudentAssignmentStatus` (ТЗ §5.4.6):**

| Код | Значение | Когда |
|-----|----------|-------|
| `notOpened` | Не открыто | задание ещё не доступно студенту |
| `available` | Доступно | опубликовано, отправки нет, дедлайн не прошёл |
| `submitted` | Отправлено | студент отправил ответ |
| `inReview` | Проверяется | преподаватель начал проверку |
| `accepted` | Принято | задание принято преподавателем |
| `returned` | Возвращено на доработку | требуется повторная отправка (шаг 18) |
| `overdue` | Просрочено | дедлайн прошёл, отправки нет |
| `graded` | Оценено | выставлена оценка (шаг 19) |

> Статус для студента **вычисляемый**, не хранится в `assignments`: считается из его
> `submission` (шаг 18), наличия `grade` (шаг 19) и сравнения `deadline` с текущим временем.

## Решения

- **Тип ответа — enum `SubmissionType`, не флаги:** комбинированный (`combined`) включает
  текст+файл+ссылку одной опцией, `none` отражает информационное задание (ТЗ §5.4.6).
- **`allowLateSubmission` хранится на задании**, но сама отметка «после дедлайна» проверяется
  на сервере (Rules/Function, шаг 18, §8.1) — клиент не источник истины.
- **Статус студента не денормализуется в `assignments`** — он зависит от пары
  студент×задание и живёт в отправке/оценке; иначе документ задания пришлось бы писать по
  каждому студенту.
- **Черновики (`isPublished == false`) скрыты от студента на сервере** (Security Rules,
  шаг 27) — клиентский фильтр лишь дублирует (ТЗ §8.1).
- **`maxScore` обязателен и > 0** — нужен для процента в журнале оценок (шаг 19).

## Артефакты

`lib/features/assignments/domain/assignment.dart` (+ `submission_type.dart`,
`student_assignment_status.dart`, `assignment_repository.dart` — контракт),
`lib/features/assignments/data/firestore_assignment_repository.dart`,
`lib/features/assignments/data/assignment_providers.dart`,
`lib/features/assignments/presentation/` (экраны создания/редактирования/публикации задания
+ контроллеры), правила для `assignments` в `firestore.rules` (детально — шаг 27),
`test/features/assignments/` (сериализация модели, вычисление статуса).

## Экраны (ТЗ §14.3)

| Маршрут | Экран | Назначение |
|---------|-------|------------|
| `/teacher/courses/:id/assignments/new` | Создание задания | поля §7.7, тип ответа, дедлайн, `maxScore` |
| `/teacher/courses/:id/assignments/:aid/edit` | Редактирование задания | правка полей, публикация/снятие |

## Готово, когда

`Assignment` сериализуется/десериализуется из Firestore (проверено на эмуляторе);
`AssignmentRepository` создаёт, правит, публикует и снимает задания; преподаватель создаёт
задание в своей неделе, студент видит только опубликованные; `StudentAssignmentStatus`
корректно вычисляется для базовых случаев; `dart analyze` чисто, unit-тесты и тесты Rules на
эмуляторе зелёные.

---

**Зависимости:** [шаг 13](session-2-step-13-course-domain.md) (домен курсов/недель),
[шаг 14](session-2-step-14-teacher-courses-weeks.md) (курсы и недели преподавателя),
[шаг 4](session-1-step-4-stack-di.md) (freezed/Failure/провайдеры),
[шаг 5](session-1-step-5-theme-ui.md) (UI-кит). **Дальше:** [шаг 18 — Отправки студента](session-2-step-18-submissions.md).
