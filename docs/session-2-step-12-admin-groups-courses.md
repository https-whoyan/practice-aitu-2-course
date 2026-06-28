# Сессия 2 · Шаг 12 — Админка: группы и курсы

Детализация шага 12 из [`session-2-features.md`](session-2-features.md), блок 4 (Админка).

> **Статус: 📋 Запланировано** (Сессия 2). Реализуется в Prct_46.
> Планируемые артефакты: `lib/features/groups/{domain,data,presentation}/`,
> `lib/features/courses/{domain,data,presentation}/`, `lib/features/admin/presentation/`,
> `test/features/{groups,courses}/`. ТЗ §5.3.4, §5.3.5, §7.3 (groups), §7.4 (courses), §17.1.

> Формат: **Цель** · **Действия** · **Модель данных** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Дать администратору управление группами и курсами: CRUD, архивацию, назначение преподавателей,
связывание групп ↔ курсов и состав студентов в группах. Шаг **вводит freezed-модели `groups` и
`courses` и их репозитории** — админ их первый потребитель; [шаг 13](session-2-step-13-course-domain.md)
затем **расширяет** эти модели (`courseWeeks` и репозитории контента для преподавателя/студента).
Соответствие ТЗ §5.3.4–5.3.5, §7.3–7.4.

## Действия

1. **freezed-модели** (шаг 4, code-gen): `Group` ← коллекция `groups` (ТЗ §7.3) и `Course` ←
   коллекция `courses` (ТЗ §7.4), с `fromJson/toJson` и конвертерами `Timestamp ↔ DateTime`
   (шаг 4). Enum статуса `EntityStatus { active, archived }`.
2. **Репозитории** `GroupRepository` и `CourseRepository` (контракты в `domain/`, реализация в
   `data/` поверх `firestoreProvider`, шаг 2): чтение/запись с `withConverter`, пагинация и
   фильтры (ТЗ §10), ошибки → `Failure` (шаг 4). **Эти контракты — общая основа**: шаг 13
   добавит к ним методы для недель и контента, не переписывая существующие.
3. **Riverpod-провайдеры** (`@riverpod`): `groupRepositoryProvider`, `courseRepositoryProvider`,
   списки `adminGroupsProvider`/`adminCoursesProvider`, карточки `groupProvider(id)`/
   `courseProvider(id)`.
4. **Админ-CRUD групп** (ТЗ §5.3.4): создание/редактирование/архивация; назначение
   преподавателей (`teacherIds`); добавление/удаление студентов (`studentIds`); просмотр состава
   и связанных курсов.
5. **Админ-CRUD курсов** (ТЗ §5.3.5): создание/редактирование/архивация; назначение
   преподавателей (`teacherIds`, владелец `ownerTeacherId`); назначение групп на курс
   (`groupIds`); просмотр структуры.
6. **Двустороннее связывание групп ↔ курсов**: при связке обновляются `groups.courseIds` и
   `courses.groupIds` атомарно (batch/transaction), чтобы списки не расходились. Перенос/удаление
   студентов из группы — обновление `studentIds` и зеркального `profiles.groupIds` (шаг 6).
7. **Экраны** под `/admin` (шаг 9, ТЗ §14.2 п.8–12): список групп, создание/редактирование
   группы, список курсов, карточка курса — на UI-ките шага 5, с пустыми/загрузочными состояниями.
8. **Журналирование критичных действий** (создание/архивация курса) — через `writeAuditLog`
   шага 10 (ТЗ §7.13 п.4–5); создание преподавателя для назначения идёт сценарием §17.1 (шаг 11).

## Модель данных (ТЗ §7.3–7.4)

| Коллекция | Документ | Ключевые поля |
|-----------|----------|---------------|
| `groups` | `Group` | `groupId, title, description, teacherIds, studentIds, courseIds, status, createdAt, updatedAt` |
| `courses` | `Course` | `courseId, title, description, ownerTeacherId, teacherIds, groupIds, coverUrl, status, createdAt, updatedAt` |

> Модели вводятся здесь и **расширяются в [шаге 13](session-2-step-13-course-domain.md)**
> (`courseWeeks` + методы репозиториев для контента преподавателя/студента). Имена коллекций — точно
> по ТЗ §7.

## Решения

- **Модели/репозитории `groups` и `courses` рождаются в админке, а не дублируются**: админ —
  первый потребитель, поэтому контракт заводится здесь и переиспользуется преподавателем/студентом
  в шаге 13 — без второй копии моделей.
- **Связь группа↔курс хранится с двух сторон** (`courseIds` и `groupIds`) и пишется атомарно:
  денормализация ускоряет выборки «курсы группы»/«группы курса» (ТЗ §10), а транзакция не даёт
  спискам разойтись.
- **Архивация вместо удаления** (ТЗ §5.3.4 п.3, §5.3.5 п.3): сохраняет связанные недели,
  материалы, оценки; согласуется с мягким удалением пользователей (шаг 10).
- **`ownerTeacherId` отдельно от `teacherIds`**: владелец курса нужен для проверки прав в Security
  Rules (ТЗ §8.3 п.7 «проверка владельца») — шаг 13/27 опирается на это поле.
- **Состав студентов зеркалится в `profiles.groupIds`**: студент быстро получает свои группы/курсы
  без обратного запроса по всем группам (шаг 16).

## Артефакты

`features/groups/domain/{group,group_repository}.dart`,
`features/groups/data/firestore_group_repository.dart`,
`features/courses/domain/{course,course_repository}.dart`,
`features/courses/data/firestore_course_repository.dart`,
провайдеры `features/{groups,courses}/data/*_providers.dart`,
`features/admin/presentation/{groups_list,group_form,courses_list,course_card}_screen.dart`,
`test/features/groups/group_repository_test.dart`, `test/features/courses/course_repository_test.dart`.

## Готово, когда

Админ создаёт/редактирует/архивирует группы и курсы; назначает преподавателей; связывает группы и
курсы (обе стороны согласованы); добавляет/удаляет/переводит студентов с зеркалированием в
`profiles`; критичные действия попадают в `auditLogs`; `dart analyze` чисто, тесты репозиториев на
эмуляторе зелёные. Введённые модели готовы к расширению неделями в шаге 13.

---

**Зависимости:** [шаг 11](session-2-step-11-admin-users.md) (раздел админки, назначение пользователей),
[шаг 10](session-2-step-10-cloud-functions-admin.md) (`writeAuditLog`, серверные операции).
**Дальше:** [шаг 13](session-2-step-13-course-domain.md).
