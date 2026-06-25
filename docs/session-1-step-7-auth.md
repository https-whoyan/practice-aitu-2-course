# Сессия 1 · Шаг 7 — Авторизация

Детализация шага 7 из [`session-1-foundation.md`](session-1-foundation.md), блок B (Авторизация и роли).

> Формат: **Цель** · **Действия** · **Экраны** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Полный цикл аутентификации по email+паролю: регистрация, вход, восстановление пароля,
подтверждение email, выход. Состояние авторизации реактивно прокинуто в приложение через
Riverpod. Соответствие ТЗ §5.1.1–5.1.5.

## Действия

1. **AuthRepository** (`features/auth/domain` + `data`) поверх `firebaseAuthProvider` (шаг 2):
   - `register(email, password)` → создаёт Firebase-аккаунт, затем пару `users`+`profiles`
     через `UserRepository` (шаг 6) с ролью **student по умолчанию** (ТЗ §5.1.1);
   - `signIn(email, password)`;
   - `sendPasswordResetEmail(email)` (ТЗ §5.1.3);
   - `sendEmailVerification()` / `reloadAndCheckVerified()` (ТЗ §5.1.4);
   - `signOut()` (ТЗ §5.1.5);
   - все ошибки `FirebaseAuthException` → `Failure` (шаг 4) с человекочитаемыми сообщениями.
2. **Состояние авторизации**: `authStateProvider` — стрим `authStateChanges()`;
   производный `appUserProvider` подтягивает `AppUser`+профиль (шаг 6). Это вход для
   редиректов шага 8.
3. **Контроллеры экранов** (Riverpod `Notifier`/`AsyncNotifier`): `LoginController`,
   `RegisterController`, `ForgotPasswordController` — держат форму, валидацию, loading/ошибку.
4. **Валидация форм** (`core/utils/validators.dart`): email, пароль (мин. длина),
   совпадение «пароль / подтверждение» (ТЗ §5.1.1 — поля имя/фамилия/email/пароль/подтверждение).
5. **Экраны** (из UI-кита шага 5, см. ниже) подключить к маршрутам go_router (шаг 4):
   `/login`, `/register`, `/forgot-password`, `/verify-email`.
6. **Логика входа** (ТЗ §5.1.2): после успешного входа — проверить статус аккаунта
   (`blocked` → выйти + сообщение), обновить `lastLoginAt` (шаг 6), отдать управление
   редиректу по роли (шаг 8).
7. **Gate подтверждения email** (ТЗ §5.1.4): экран `/verify-email` для неподтверждённых;
   подтверждение требуется для отдельных действий (вступление в курс/отправка задания) —
   правило фиксируем здесь, применяем в Сессии 2.
8. Тесты на эмуляторе: регистрация → письмо-верификация (в Emulator UI) → вход → сброс
   пароля → выход.

## Экраны (ТЗ §14.1)

| Маршрут | Экран | Назначение |
|---------|-------|------------|
| `/login` | Экран входа | email+пароль, ссылки на регистрацию/восстановление |
| `/register` | Экран регистрации | имя, фамилия, email, пароль, подтверждение |
| `/forgot-password` | Восстановление пароля | ввод email, отправка письма |
| `/verify-email` | Подтверждение email | напоминание + повторная отправка письма |

> Все экраны собираются из `AppScaffold`, `AppTextField`, `AppPasswordField`,
> `PrimaryButton`, `AppErrorView` (шаг 5).

## Решения

- **Только email+пароль** в Сессии 1 (соц-логины вне MVP; архитектура провайдера это
  допускает позже).
- **Самостоятельная регистрация всегда создаёт student** (ТЗ §5.1.1); преподавателей создаёт
  админ через Cloud Function (Сессия 2) — на клиенте роль при регистрации не выбирается.
- **Источник истины авторизации — `authStateProvider`**, UI и роутер реагируют на него, а не
  дёргают `currentUser` императивно.
- **Текст ошибок маппится из `FirebaseAuthException`** в дружелюбные сообщения через `Failure`.
- **Подтверждение email — мягкий gate**: вход разрешён, но часть действий блокируется до
  верификации (ТЗ §5.1.4).

## Артефакты

`features/auth/data/auth_repository.dart` (+ контракт в `domain`),
`features/auth/data/auth_providers.dart` (`authStateProvider`, `appUserProvider`),
`features/auth/presentation/` (login/register/forgot/verify экраны + контроллеры),
`core/utils/validators.dart`, маршруты auth в `routing/app_router.dart`.

## Готово, когда

На эмуляторе проходит полный цикл: регистрация создаёт `users`+`profiles` с ролью student,
приходит письмо-верификация (Emulator UI), вход работает и обновляет `lastLoginAt`,
заблокированный аккаунт не пускает, сброс пароля отправляет письмо, выход возвращает на
`/login`; `authStateProvider` корректно отражает вход/выход; `flutter analyze` чисто.

---

**Зависимости:** [шаг 6](session-1-step-6-user-model.md) (модели/репозиторий), [шаг 5](session-1-step-5-theme-ui.md) (UI-кит), [шаг 4](session-1-step-4-stack-di.md) (роутер/Failure).
**Дальше:** [шаг 8 — Роли и редирект](session-1-step-8-roles-guards.md).
