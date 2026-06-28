# Сессия 2 · Шаг 10 — Cloud Functions: каркас и admin-операции

Детализация шага 10 из [`session-2-features.md`](session-2-features.md), блок 4 (Админка).

> **Статус: 📋 Запланировано** (Сессия 2). Реализуется в Prct_46.
> Планируемые артефакты: `functions/src/` (TypeScript: `index.ts`, `admin/`, `lib/auth.ts`,
> `lib/audit.ts`), `test/functions/admin_callable.test.mjs`. ТЗ §9, §5.3.1, §5.3.2, §8.1, §8.6, §7.13 (auditLogs).

> Формат: **Цель** · **Действия** · **Cloud Functions** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Развернуть каркас Cloud Functions (TypeScript) и реализовать серверные admin-операции, которые
нельзя безопасно выполнять с клиента: создание аккаунтов, назначение ролей, блокировку и мягкое
удаление пользователей. Здесь же закладывается синхронизация **custom claims** ↔ `users.role` —
будущая опора Security Rules вместо `get(users/role)` из шага 8 — и хелпер журналирования в
`auditLogs`. Соответствие ТЗ §9, §5.3.1–5.3.2, §8.1, §8.6, §7.13.

## Действия

1. **Организация `functions/src` по доменам**: `index.ts` (экспорт всех функций), `admin/`
   (пользователи), `lib/` (общие хелперы), далее — `content/`, `quiz/`, `stats/`, `notifications/`
   по мере Сессии 2. Инициализация `firebase-admin` один раз, регион функций задаётся явно
   (`europe-west1` или согласованный), TypeScript-строгий режим.
2. **Хелпер авторизации вызывающего** `lib/auth.ts`: `assertAdmin(context)` — проверяет
   `context.auth.token.role == 'admin'` (custom claim), иначе `HttpsError('permission-denied')`.
   Все admin-callable начинаются с этой проверки (ТЗ §8.1: серверная проверка прав).
3. **`createUser` / `createTeacher`** (callable): валидирует вход (имя, фамилия, email, роль),
   создаёт Auth-аккаунт (`auth().createUser`), атомарно пишет пару `users`+`profiles` (шаг 6),
   выставляет custom claim роли, генерирует ссылку установки пароля
   (`generatePasswordResetLink`) и отправляет письмо — сценарий ТЗ §17.1. `createTeacher` —
   тонкая обёртка над `createUser` с предустановленной ролью `teacher`.
4. **`setUserRole`** (callable): меняет `users.role` и синхронизирует custom claim
   (`auth().setCustomUserClaims`). Это **становится опорой Security Rules** — правила в шаге 27
   читают `request.auth.token.role` вместо `get()` (см. заметку в шаге 8).
5. **`blockUser` / `unblockUser`** (callable): переключают `users.status` между `active` и
   `blocked` (шаг 6); при блокировке — `auth().revokeRefreshTokens(uid)`, чтобы сессия
   завершилась на сервере, а не только пряталась UI.
6. **`softDeleteUser`** (callable): мягкое удаление (ТЗ §5.3.1) — выставляет `status` в
   `archived`/`deleted` и флаг, скрывающий из активных списков; связанные `grades`,
   `quizAttempts`, `auditLogs` **сохраняются**. Жёсткого удаления документов нет.
7. **Хелпер `writeAuditLog`** `lib/audit.ts` (ТЗ §7.13, §8.6): пишет документ в `auditLogs`
   (`userId`, `role`, `actionType`, `entityType`, `entityId`, `oldValue`, `newValue`,
   `createdAt`). Вызывается из каждой критичной функции (создание пользователя, смена роли,
   блокировка).
8. **Тесты на эмуляторе** (шаг 3): через Functions/Auth/Firestore-эмуляторы проверить, что
   не-админ получает `permission-denied`, что `createUser` создаёт Auth+`users`+`profiles` и
   claim, а каждая операция пишет запись в `auditLogs`.

## Cloud Functions

| Функция | Назначение | Проверки |
|---------|-----------|----------|
| `createUser` | Создаёт Auth-аккаунт + `users`+`profiles`, шлёт письмо установки пароля (ТЗ §17.1) | `assertAdmin`; валидация полей; уникальность email; атомарная запись пары |
| `createTeacher` | Обёртка `createUser` с ролью `teacher` (ТЗ §5.3.2) | `assertAdmin`; роль фиксирована |
| `setUserRole` | Меняет `users.role` + синхронизирует custom claim (опора Security Rules) | `assertAdmin`; роль ∈ {admin, teacher, student}; запрет снять последнего админа |
| `blockUser` | `status → blocked`, отзыв refresh-токенов | `assertAdmin`; запрет блокировать себя |
| `unblockUser` | `status → active` | `assertAdmin` |
| `softDeleteUser` | Мягкое удаление: скрыть из активных, сохранить связанные данные (ТЗ §5.3.1) | `assertAdmin`; запрет удалять себя; данные не стираются |
| `writeAuditLog` (хелпер) | Запись критичного действия в `auditLogs` (ТЗ §7.13, §8.6) | Вызывается из доверенного серверного кода |

## Решения

- **Callable-функции, а не HTTP**: автоматически прокидывают `context.auth` и токен с claims —
  не нужно вручную парсить и верифицировать заголовки, проверка `assertAdmin` тривиальна.
- **Custom claims как источник для правил**: смена роли идёт только через `setUserRole`, поэтому
  claim и `users.role` не расходятся; Security Rules перестают делать `get()` на каждый запрос
  (производительность, ТЗ §10) — это плановый переход относительно шага 8.
- **Мягкое удаление по умолчанию** (ТЗ §5.3.1): жёсткое удаление рвало бы ссылки в `grades`,
  `quizAttempts`, `auditLogs` и ломало бы разбор спорных ситуаций (§8.6).
- **Отзыв токенов при блокировке** — реальная серверная граница (ТЗ §8.1), а не только редирект
  на клиенте (шаг 8).
- **Единый `writeAuditLog`** вместо разрозненных записей — один формат документа §7.13, легче
  фильтровать журнал в админке (шаг 11) и расширять на контент/оценки в следующих блоках.
- **Регион и инициализация в одном месте** — предсказуемая латентность и отсутствие повторной
  инициализации `firebase-admin`.

## Артефакты

`functions/src/index.ts` (реэкспорт), `functions/src/admin/users.ts`
(`createUser`/`createTeacher`/`setUserRole`/`blockUser`/`unblockUser`/`softDeleteUser`),
`functions/src/lib/auth.ts` (`assertAdmin`), `functions/src/lib/audit.ts` (`writeAuditLog`),
`functions/src/lib/region.ts`, `functions/package.json`/`tsconfig.json`,
`test/functions/admin_callable.test.mjs` (тесты на эмуляторе).

## Готово, когда

На эмуляторе (шаг 3) `createUser` создаёт Auth-аккаунт, пару `users`+`profiles` и custom claim,
`setUserRole` синхронно меняет роль и claim, `blockUser` отзывает токены, а каждая критичная
операция оставляет запись в `auditLogs`; не-админ получает `permission-denied`; сборка функций
(`tsc`) и тесты callable на эмуляторе проходят.

---

**Зависимости:** [шаг 6](session-1-step-6-user-model.md) (модели `users`/`profiles`, статусы),
[шаг 8](session-1-step-8-roles-guards.md) (роли, custom claims), [шаг 2](session-1-step-2-firebase.md) (Firebase/эмулятор).
**Дальше:** [шаг 11](session-2-step-11-admin-users.md).
