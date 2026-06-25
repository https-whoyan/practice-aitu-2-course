# Сессия 1 · Шаг 8 — Роли и редирект

Детализация шага 8 из [`session-1-foundation.md`](session-1-foundation.md), блок B (Авторизация и роли).

> Формат: **Цель** · **Действия** · **Security Rules (каркас)** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

После входа приложение определяет роль и направляет пользователя в его интерфейс; маршруты
защищены guard'ами; на стороне Firestore стоят каркасные Security Rules с проверкой ролей.
Безопасность не держится на скрытии кнопок (ТЗ §8.1). Соответствие ТЗ §3, §5.1.2, §8.1–8.2.

## Действия

1. **Определение роли**: `appUserProvider` (шаг 7) отдаёт `AppUser.role`; завести
   `currentRoleProvider`. Источник истины — `users.role`; для серверной проверки роль
   дублируется в **custom claims** (синхронизируется Cloud Function в Сессии 2, здесь —
   договорённость и чтение claim на клиенте при наличии).
2. **Редирект по роли** в go_router `redirect` (шаг 4):
   - не залогинен → `/login` (кроме auth-маршрутов);
   - залогинен, но `status == blocked` → выход + экран-заглушка;
   - залогинен → корневой маршрут роли: `admin → /admin`, `teacher → /teacher`,
     `student → /student` (dashboard'ы реализуются в шаге 9);
   - учесть состояние «loading профиля» → `/splash`, чтобы не моргать редиректами.
3. **Route guards**: хелпер `requireRole(Set<UserRole>)` для подразделов; попытка зайти не на
   свой раздел → редирект на свой dashboard (или 403-заглушка).
4. **Каркасные Firestore Security Rules** (`firestore.rules`, шаг 3): функции-хелперы
   `isSignedIn()`, `getRole()`, `isAdmin()`, `isTeacher()`, `isStudent()`, `isOwner(uid)`;
   базовые правила для `users`/`profiles` (см. ниже). Полные правила по всем коллекциям —
   Сессия 2 (этап 8 ТЗ), но каркас и принцип «default deny» закладываем сейчас.
5. **Тесты Security Rules** через эмулятор (`@firebase/rules-unit-testing`): студент не читает
   чужой `users`-документ, не меняет свою `role`/`status`; админ читает всё. Это якорь, к
   которому будут добавляться правила в Сессии 2.
6. **Согласовать клиент ↔ правила**: UI прячет недоступное (UX), но это лишь дублирование —
   реальный запрет на сервере (ТЗ §8.1).

## Security Rules — каркас (принципы)

```
// псевдокод направления, не финал
function isSignedIn()  { return request.auth != null; }
function getRole()     { return get(/databases/$(db)/documents/users/$(request.auth.uid)).data.role; }
function isAdmin()     { return isSignedIn() && getRole() == 'admin'; }
function isOwner(uid)  { return isSignedIn() && request.auth.uid == uid; }

match /users/{uid} {
  allow read:  if isOwner(uid) || isAdmin();
  allow create: if isOwner(uid);                 // создаётся при регистрации
  allow update: if isAdmin();                    // role/status меняет только админ
}
match /profiles/{uid} {
  allow read:  if isSignedIn();
  allow update: if isOwner(uid) || isAdmin();    // юзер правит свой профиль
}
// всё остальное — default deny, открывается по мере фич в Сессии 2
```

> Здесь `getRole()` читает `users.role`. В Сессии 2 для производительности и Functions
> переключимся на **custom claims** (`request.auth.token.role`), чтобы не делать `get()` на
> каждый запрос.

## Решения

- **Редирект централизованно в `redirect` go_router**, а не в каждом экране — одна точка
  правды для навигационной защиты.
- **Три корневых раздела по ролям** (`/admin`, `/teacher`, `/student`) — изолированные
  навигационные деревья (раскрываются в шаге 9).
- **Двухуровневая защита**: клиентские guard'ы (UX) + Security Rules (реальная граница).
  ТЗ §8.1 запрещает полагаться только на клиент.
- **Роль в custom claims** — для серверной проверки и быстрых правил; синхронизация —
  Cloud Function (Сессия 2). В Сессии 1 правила читают `users.role` через `get()` как
  временный вариант.
- **Default deny** в правилах с самого начала — открываем коллекции точечно.

## Артефакты

`features/auth/data/role_providers.dart` (`currentRoleProvider`),
`routing/app_router.dart` (логика `redirect` + `requireRole`),
`routing/role_guard.dart`, обновлённый `firestore.rules` (хелперы + правила users/profiles),
`test/security/firestore_rules_test.*` (тесты правил на эмуляторе),
`/splash` и `/blocked` экраны-заглушки.

## Готово, когда

После входа пользователь автоматически попадает на корневой маршрут своей роли;
заблокированный — не пускается; попытка зайти в чужой раздел редиректит на свой;
тесты Security Rules на эмуляторе зелёные (студент не лезет в чужое/не меняет роль,
админ видит всё); `flutter analyze` чисто.

---

**Зависимости:** [шаг 7](session-1-step-7-auth.md) (auth-состояние), [шаг 6](session-1-step-6-user-model.md) (роль/статус), [шаг 3](session-1-step-3-emulators.md) (эмулятор для тестов правил).
**Дальше:** [шаг 9 — Скелет навигации и dashboard'ы](session-1-step-9-navigation.md).
