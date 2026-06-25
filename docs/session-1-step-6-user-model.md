# Сессия 1 · Шаг 6 — Модель пользователя и данных

Детализация шага 6 из [`session-1-foundation.md`](session-1-foundation.md), блок B (Авторизация и роли).

> Формат: **Цель** · **Действия** · **Модель данных** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Описаны доменные модели пользователя и профиля, enum'ы ролей и статусов, и репозиторий
доступа к коллекциям `users` / `profiles` в Firestore. Это фундамент авторизации (шаг 7) и
ролевого доступа (шаг 8). Соответствие ТЗ §5.2, §7.1, §7.2.

## Действия

1. **Enum'ы** в `features/auth/domain/` (или `core/`):
   - `UserRole { admin, teacher, student }` — со строковыми кодами для Firestore;
   - `AccountStatus { active, blocked, pendingVerification }`.
2. **freezed-модели** (шаг 4, code-gen):
   - `AppUser` ← коллекция `users` (ТЗ §7.1): `uid`, `email`, `role`, `status`,
     `createdAt`, `lastLoginAt`, `emailVerified`.
   - `UserProfile` ← коллекция `profiles` (ТЗ §7.2): `uid`, `firstName`, `lastName`,
     `displayName`, `photoUrl`, `groupIds`, `courseIds`, `teacherCourseIds`,
     `createdAt`, `updatedAt`.
   - `fromJson/toJson` + конвертеры `Timestamp ↔ DateTime` (из `core/utils/` шага 4).
3. **Контракт репозитория** в `domain/`: `UserRepository` —
   `watchUser(uid)`, `getUser(uid)`, `watchProfile(uid)`, `createUserWithProfile(...)`,
   `updateProfile(...)`, `updateLastLogin(uid)`.
4. **Реализация** в `data/`: `FirestoreUserRepository` поверх `firestoreProvider` (шаг 2),
   типобезопасные `withConverter` для коллекций, ошибки → `Failure` (шаг 4).
5. **Riverpod-провайдеры**: `userRepositoryProvider`, `currentUserProvider`,
   `currentProfileProvider` (стримы по `uid` текущего пользователя — свяжем в шаге 7).
6. **Сидер тестовых данных** для эмулятора: скрипт/функция, создающая по одному
   admin/teacher/student с профилями — для локальной отладки шагов 7–9.
7. **Заметка по консистентности:** `users` + `profiles` пишутся вместе (batch/transaction),
   чтобы не было пользователя без профиля.

## Модель данных (соответствие ТЗ)

| Коллекция | Документ | Ключевые поля |
|-----------|----------|---------------|
| `users` | `AppUser` | `uid, email, role, status, createdAt, lastLoginAt, emailVerified` |
| `profiles` | `UserProfile` | `uid, firstName, lastName, displayName, photoUrl, groupIds, courseIds, teacherCourseIds, createdAt, updatedAt` |

> Роль и статус хранятся в `users` (защищается Security Rules, шаг 8). Профиль —
> редактируемые пользователем данные (имя, фамилия, фото); роль/статус/email юзер сам менять
> не может (ТЗ §5.2).

## Решения

- **Разделение `users` (системное) и `profiles` (редактируемое)** — как в ТЗ §7; разрешает
  разные права в Security Rules: профиль юзер правит, `users.role/status` — нет.
- **Роль и статус — enum'ы со строковыми кодами**, не «магические строки» в коде.
- **Доступ только через `UserRepository`**, фичи не лезут в `FirebaseFirestore` напрямую
  (эталон-шаблон из шага 4).
- **`role` дублируется в custom claims** (понадобится в шаге 8 для Security Rules/Functions);
  источник истины — `users.role`, claims синхронизируются Cloud Function в Сессии 2.
- **Запись пары `users`+`profiles` атомарно** (batch/transaction).

## Артефакты

`features/auth/domain/user_role.dart`, `account_status.dart`,
`features/auth/domain/app_user.dart`, `user_profile.dart` (+ сгенерированные
`*.freezed.dart`/`*.g.dart`), `features/auth/domain/user_repository.dart` (контракт),
`features/auth/data/firestore_user_repository.dart`, провайдеры
`features/auth/data/user_providers.dart`, dev-сидер тестовых пользователей.

## Готово, когда

Модели сериализуются/десериализуются из Firestore (проверено на эмуляторе);
`UserRepository` создаёт и читает пару `users`+`profiles`; провайдеры отдают
`AppUser`/`UserProfile` по `uid`; сидер наполняет эмулятор тремя ролями; `flutter analyze`
и unit-тесты сериализации проходят.

---

**Зависимости:** [шаг 4](session-1-step-4-stack-di.md) (freezed, Failure, провайдеры),
[шаг 2](session-1-step-2-firebase.md) (Firestore). **Дальше:** [шаг 7 — Авторизация](session-1-step-7-auth.md).
