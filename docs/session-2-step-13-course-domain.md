# Сессия 2 · Шаг 13 — Домен курсов, групп и недель

Детализация шага 13 из [`session-2-features.md`](session-2-features.md), блок 5 (Курсы, группы, материалы).

> **Статус: 📋 Запланировано** (Сессия 2). Реализуется в Prct_46.
> Планируемые пути: `lib/features/courses/domain/`, `lib/features/groups/domain/`
> (модель `course_week`, репозитории `course_repository`, `group_repository`,
> `course_week_repository`). ТЗ §5.4.3, §5.4.4, §7.3, §7.4, §7.5.

> Формат: **Цель** · **Действия** · **Модель данных** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Доменный слой контента курса: модель `CourseWeek` и общие репозитории/провайдеры курсов,
групп и недель, которыми пользуются преподаватель (шаг 14) и студент (шаг 16). Модели
`Course` и `Group` уже введены в шаге 12 (админ — первый потребитель); здесь они расширяются
доменными методами публикации, а недели вводятся впервые. Соответствие ТЗ §5.4.3, §5.4.4,
§7.3, §7.4, §7.5.

## Действия

1. **Модель `CourseWeek`** (freezed, шаг 4) ← коллекция `courseWeeks` (ТЗ §7.5):
   `weekId`, `courseId`, `title`, `description`, `orderIndex`, `startDate`, `endDate`,
   `isPublished`, `createdAt`, `updatedAt`; конвертеры `Timestamp ↔ DateTime` (шаг 4).
2. **Enum `CourseStatus { draft, active, archived }`** со строковыми кодами для Firestore;
   подключить к `Course` (введён в шаге 12) — статус черновик/активный/архивный (ТЗ §5.4.3).
3. **Расширить `CourseRepository`** (контракт из шага 12): `watchCourse(id)`,
   `watchCoursesByOwner(teacherId)`, `watchCoursesByGroups(groupIds)`, `createCourse`,
   `updateCourse`, `setStatus(id, status)`, `duplicateCourse(id)`,
   `copyToNewPeriod(id)` — для преподавателя (шаг 14) и доступа студента (шаг 16).
4. **Контракт `CourseWeekRepository`** в `domain/`: `watchWeeks(courseId)`, `getWeek(id)`,
   `addWeek(...)`, `updateWeek(...)`, `deleteWeek(id)`, `reorderWeeks(courseId, order)`,
   `setPublished(id, value)` — недели сортируются по `orderIndex`.
5. **Контракт `GroupRepository`** (расширение шага 12) для чтения групп студента/преподавателя:
   `watchGroup(id)`, `watchGroupsByTeacher`, `watchGroupsByStudent`, `addStudent`,
   `removeStudent` — понадобится для назначений курса и доступа студента.
6. **Реализации в `data/`** поверх `firestoreProvider` (шаг 2): типобезопасные `withConverter`
   для `courses` / `courseWeeks` / `groups`, ошибки → `Failure` (шаг 4).
7. **Riverpod-провайдеры** (`@riverpod`, шаг 4): `courseRepositoryProvider`,
   `courseWeekRepositoryProvider`, `groupRepositoryProvider` + стрим-провайдеры
   (`courseWeeksProvider(courseId)` и т.п.), общие для шагов 14 и 16.

## Модель данных (ТЗ §7.5)

| Коллекция | Документ | Ключевые поля |
|-----------|----------|---------------|
| `courseWeeks` | `CourseWeek` | `weekId, courseId, title, description, orderIndex, startDate, endDate, isPublished, createdAt, updatedAt` |

> `courses` (`courseId, title, description, ownerTeacherId, teacherIds, groupIds, coverUrl,
> status, createdAt, updatedAt`, ТЗ §7.4) и `groups` (`groupId, title, description,
> teacherIds, studentIds, courseIds, status, createdAt, updatedAt`, ТЗ §7.3) введены в
> [шаге 12](session-2-step-12-admin-groups-courses.md); здесь добавляется `CourseStatus` и
> доменные методы публикации/дублирования.

## Решения

- **Недели — отдельная коллекция `courseWeeks`** (не вложенный массив в `Course`) — как в
  ТЗ §7.5; позволяет правила видимости и сортировку `orderIndex` без перезаписи курса.
- **`CourseStatus` — enum со строковыми кодами**, не «магические строки»; статусы из ТЗ §5.4.3
  (черновик/активный/архивный).
- **Публикация недели — флаг `isPublished`** на документе недели; реальный запрет на чтение
  скрытых недель — Security Rules ([шаг 27](session-2-step-27-security-rules.md)), клиент
  дублирует фильтрацию (ТЗ §8.1, §8.3).
- **Общие репозитории в `courses`/`groups`** — преподаватель (шаг 14) и студент (шаг 16) ходят
  через один контракт, фичи не лезут в `FirebaseFirestore` напрямую (эталон шага 4/6).
- **`orderIndex` как явное поле** — порядок недель меняется без переиндексации остальных полей.

## Артефакты

`features/courses/domain/course_week.dart`, `course_status.dart`,
`course_repository.dart`, `course_week_repository.dart` (контракты, +`*.freezed.dart`/`*.g.dart`),
`features/courses/data/firestore_course_repository.dart`,
`firestore_course_week_repository.dart`, `course_providers.dart`,
`features/groups/domain/group_repository.dart`,
`features/groups/data/firestore_group_repository.dart`, `group_providers.dart`,
`test/features/courses/course_week_serialization_test.dart`.

## Готово, когда

`CourseWeek` сериализуется/десериализуется из `courseWeeks` (проверено на эмуляторе);
`CourseWeekRepository` создаёт/читает/переупорядочивает недели; `CourseRepository` отдаёт
курсы по владельцу и по группам, меняет статус и дублирует курс; провайдеры общие для шагов
14 и 16; `dart analyze` чисто, unit-тесты сериализации проходят.

---

**Зависимости:** [шаг 12](session-2-step-12-admin-groups-courses.md) (модели `Course`/`Group`),
[шаг 6](session-1-step-6-user-model.md) (профиль, `groupIds`/`courseIds`). **Дальше:** [шаг 14 — Преподаватель: курсы и недели](session-2-step-14-teacher-courses-weeks.md).
