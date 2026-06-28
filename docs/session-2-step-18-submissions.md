# Сессия 2 · Шаг 18 — Отправки студента

Детализация шага 18 из [`session-2-features.md`](session-2-features.md), блок 6 (Задания и оценки).

> **Статус: 📋 Запланировано** (Сессия 2). Реализуется в Prct_46.
> Планируемые пути: `lib/features/submissions/{domain,data,presentation}/`, `storage.rules`,
> `firestore.rules` (коллекция `submissions`). Соответствие ТЗ §5.6.4, §7.8, §8.4, §11. НЕ
> реализовано — план.

> Формат: **Цель** · **Действия** · **Модель данных и статусы** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Студент отправляет ответ на задание (текст / файл / ссылка / комбинированный), загружает файлы
в Firebase Storage, сохраняет черновик офлайн, редактирует отправку до дедлайна и
переотправляет при возврате на доработку. Соблюдение дедлайна проверяется на сервере, а не на
клиенте. Соответствие ТЗ §5.6.4, §7.8, §8.4, §11.

## Действия

1. **Фича `submissions`**: создать `lib/features/submissions/{domain,data,presentation}/`
   поверх `firestoreProvider` и `firebaseStorageProvider` (шаг 2).
2. **freezed-модель `Submission`** (шаг 4) ← коллекция `submissions` (ТЗ §7.8): `submissionId`,
   `assignmentId`, `courseId`, `studentId`, `textAnswer`, `fileUrls`, `linkAnswer`, `status`,
   `submittedAt`, `updatedAt`, `teacherComment`, `gradeId`; `fromJson/toJson` + конвертеры
   `Timestamp ↔ DateTime` (шаг 4).
3. **Enum `SubmissionStatus`** со строковыми кодами (см. ниже) — статус отправки, согласован со
   `StudentAssignmentStatus` задания (шаг 17).
4. **Контракт `SubmissionRepository`** в `domain/`: `watchMySubmission(assignmentId)`,
   `watchSubmissionsForAssignment(assignmentId)` (для преподавателя, шаг 19),
   `submit(...)`, `updateDraft(...)`, `resubmit(...)`, `uploadFile(...)` / `removeFile(...)`.
5. **Реализация `FirestoreSubmissionRepository`** в `data/`: `withConverter`, загрузка файлов в
   Storage по пути `submissions/{assignmentId}/{studentId}/{fileId}` (привязка к пользователю и
   сущности — ТЗ §8.4), ошибки → `Failure` (шаг 4); `@riverpod`-провайдеры.
6. **Экран отправки задания** (UI-кит шага 5): поля по `submissionType` задания (шаг 17) —
   текст, выбор/загрузка файла, ссылка; индикатор прогресса загрузки; кнопка отправки активна
   по типу ответа (см. таблицу «Экраны»).
7. **Черновик ответа (офлайн, ТЗ §11)**: сохранять `textAnswer`/`linkAnswer` локально и в
   `submissions` со статусом `draft`; кэш Firestore (шаг 2) отдаёт черновик офлайн;
   уведомлять, что отправка требует интернета (ТЗ §11 — критичное действие).
8. **Редактирование до дедлайна**: пока `deadline` не прошёл и отправка не принята/не оценена,
   студент правит ответ (`updateDraft`/повторный `submit`).
9. **Повторная отправка при возврате**: если задание `returned` (шаг 17), студент
   переотправляет — статус идёт `returned → submitted`, `submittedAt` обновляется.
10. **Серверная проверка дедлайна (§8.1)**: разрешать `submit/resubmit` после дедлайна только
    при `allowLateSubmission == true`, и помечать просрочку — через Security Rules и/или Cloud
    Function (шаг 10), не на клиенте; клиентская блокировка — лишь UX.
11. **Связь с заданием/оценкой**: `gradeId` заполняется на шаге 19; `teacherComment` пишется
    преподавателем при проверке (шаг 19).

## Модель данных (ТЗ §7.8)

| Коллекция | Документ | Ключевые поля |
|-----------|----------|---------------|
| `submissions` | `Submission` | `submissionId, assignmentId, courseId, studentId, textAnswer, fileUrls, linkAnswer, status, submittedAt, updatedAt, teacherComment, gradeId` |

**Статусы отправки — `SubmissionStatus` (согласованы с ТЗ §5.4.6):**

| Код | Значение | Переход |
|-----|----------|---------|
| `draft` | Черновик (офлайн §11) | сохранён локально/в кэше, не отправлен |
| `submitted` | Отправлено | студент отправил ответ |
| `inReview` | Проверяется | преподаватель начал проверку (шаг 19) |
| `returned` | Возвращено на доработку | требует повторной отправки → `submitted` |
| `accepted` | Принято | принято преподавателем |
| `graded` | Оценено | выставлена оценка (шаг 19) |

> `fileUrls` — список ссылок Storage; пути привязаны к `studentId`+`assignmentId` (ТЗ §8.4).
> Проверка дедлайна и просрочки — серверная (Rules/Function), клиент ей не доверяет (§8.1).

## Решения

- **Storage-путь `submissions/{assignmentId}/{studentId}/{fileId}`** — привязка файла к
  пользователю и сущности (ТЗ §8.4); правила (шаг 27) разрешают студенту писать только в свою
  папку, преподавателю — читать в своих курсах.
- **Черновик хранится в `submissions` со статусом `draft`**, опираясь на офлайн-кэш Firestore
  (шаг 2) — просмотр и правка офлайн (ТЗ §11), но `submit` требует сети.
- **Дедлайн и просрочка — на сервере** (§8.1, §11 «отправка задания» — критичное действие):
  клиентская проверка `DateTime.now()` ненадёжна, источник истины — Rules/Function (шаг 10).
- **Одна отправка на пару студент×задание** (детерминированный `submissionId`, например
  `{assignmentId}_{studentId}`) — переотправка обновляет тот же документ, история правок видна
  по `updatedAt` и статусам.
- **Тип полей отправки управляется `submissionType` задания** (шаг 17): UI и валидация
  включают только разрешённые поля (текст/файл/ссылка/комбинированный).

## Артефакты

`lib/features/submissions/domain/submission.dart` (+ `submission_status.dart`,
`submission_repository.dart` — контракт),
`lib/features/submissions/data/firestore_submission_repository.dart`,
`lib/features/submissions/data/submission_providers.dart`,
`lib/features/submissions/presentation/` (экран отправки задания, черновик, переотправка +
контроллеры), правила для `submissions` в `firestore.rules` и `storage.rules` (детально —
шаг 27), серверная проверка дедлайна (шаг 10),
`test/features/submissions/` (сериализация, переходы статусов), тест Rules на эмуляторе
(чужую отправку не пишут, после дедлайна без `allowLateSubmission` не отправляют).

## Экраны (ТЗ §14.4)

| Маршрут | Экран | Назначение |
|---------|-------|------------|
| `/student/assignments/:aid` | Страница задания | инструкция, дедлайн, статус, оценка/комментарий |
| `/student/assignments/:aid/submit` | Отправка задания | текст/файл/ссылка по типу, черновик, переотправка |

## Готово, когда

`Submission` сериализуется/десериализуется из Firestore (проверено на эмуляторе); студент
отправляет текст/файл/ссылку по типу задания, файл попадает в Storage по привязанному пути;
черновик сохраняется и читается офлайн; редактирование до дедлайна и переотправка после
возврата работают; отправка после дедлайна без `allowLateSubmission` отклоняется сервером;
`dart analyze` чисто, unit-тесты и тесты Rules/Storage на эмуляторе зелёные.

---

**Зависимости:** [шаг 17](session-2-step-17-assignments.md) (задания),
[шаг 2](session-1-step-2-firebase.md) (Firestore/Storage/офлайн-кэш),
[шаг 4](session-1-step-4-stack-di.md) (freezed/Failure/провайдеры),
[шаг 5](session-1-step-5-theme-ui.md) (UI-кит). **Дальше:** [шаг 19 — Проверка и оценки](session-2-step-19-grading.md).
