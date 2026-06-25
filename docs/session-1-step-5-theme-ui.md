# Сессия 1 · Шаг 5 — Тема и базовые UI-компоненты

Детализация шага 5 из [`session-1-foundation.md`](session-1-foundation.md), блок A (Инфраструктура).

> **Статус: ✅ Реализовано** (пост-аудит 2026-06-25). Код: `lib/theme/`,
> `lib/shared/widgets/`, `lib/shared/responsive/`.

> Формат: **Цель** · **Действия** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Единая визуальная система приложения: светлая/тёмная тема и набор переиспользуемых
виджетов, из которых дальше собираются все экраны. UI выглядит цельно и адаптивно
(ТЗ §6.1 — адаптивность, единый стиль, минимализм, поддержка light/dark).

## Действия

1. **Дизайн-токены** в `theme/`: палитра (`AppColors`), типографика (`AppTextStyles`),
   отступы/радиусы/размеры (`AppSpacing`, `AppRadius`). Никаких «магических» чисел и цветов
   в экранах — только токены (ТЗ §15: отсутствие хардкода).
2. **ThemeData light/dark** на основе `ColorScheme.fromSeed` (Material 3): собрать
   `AppTheme.light` и `AppTheme.dark`, прокинуть в `MaterialApp.router`
   (`theme` / `darkTheme` / `themeMode`).
3. **Переключатель темы** через Riverpod: `themeModeProvider` (system/light/dark) +
   персист выбора (позже — в профиле/`shared_preferences`); пока system по умолчанию.
4. **Адаптивный слой**: хелперы брейкпоинтов (`mobile / tablet / desktop`) и виджет
   `ResponsiveBuilder` / extension на `BuildContext` — основа для «sidebar на web, bottom
   nav на mobile» (используется в шаге 9).
5. **UI-кит** в `shared/widgets/` — минимально необходимый набор:
   - кнопки: `PrimaryButton`, `SecondaryButton`, `AppTextButton` (с состоянием loading);
   - поля ввода: `AppTextField`, `AppPasswordField` (с валидацией/ошибкой);
   - обратная связь: `AppLoader`, `AppErrorView` (принимает `Failure` из шага 4),
     `AppEmptyView`, скелетоны (`SkeletonBox`/shimmer);
   - контейнеры: `AppScaffold` (единый каркас экрана), `AppCard`, `SectionHeader`;
   - утилиты: `AppSnackbar`/`AppDialog`-хелперы.
6. **Связка с обработкой ошибок (шаг 4):** `AppErrorView` и хелперы умеют отрисовать
   `Failure` единообразно — экраны не парсят исключения сами.
7. **Витрина компонентов** (storybook-lite): один debug-экран `WidgetGalleryScreen`, где
   собраны все компоненты в light/dark — для визуальной проверки и регресса.
8. Прогнать `flutter analyze`; снять скриншоты галереи в обеих темах.

## Решения

- **Material 3 + `ColorScheme.fromSeed`** — быстрый старт, консистентные light/dark из одного
  seed-цвета; точечные переопределения токенами.
- **Все экраны только через `AppScaffold` и UI-кит** — единый стиль и одна точка правок
  (ТЗ §15: переиспользуемые компоненты).
- **Адаптивность через брейкпоинты-хелперы**, а не `MediaQuery` россыпью по коду.
- **`themeModeProvider` на Riverpod**, персист добавим, когда появится профиль (шаги 6–7).
- **Темизация раньше фич** — чтобы фичи Сессии 2 сразу собирались из готовых компонентов.

## Артефакты

`theme/app_colors.dart`, `theme/app_text_styles.dart`, `theme/app_spacing.dart`,
`theme/app_theme.dart`, `theme/theme_mode_provider.dart`,
`shared/widgets/` (кнопки, поля, лоадеры, error/empty-вью, скелетоны, `AppScaffold`, карточки),
`shared/responsive/` (брейкпоинты, `ResponsiveBuilder`),
debug-экран `WidgetGalleryScreen`, скриншоты light/dark.

## Готово, когда

`MaterialApp.router` применяет light/dark тему, переключение темы работает; галерея
компонентов отрисовывается корректно в обеих темах; экраны можно собирать только из
`shared/widgets/` без локального хардкода цветов/отступов; `AppErrorView` показывает
`Failure` из шага 4; `flutter analyze` чисто.

---

**Зависимости:** [шаг 4](session-1-step-4-stack-di.md) (Riverpod, `Failure`, роутер).
**Дальше:** [шаг 6 — Модель пользователя и данных](session-1-step-6-user-model.md).
