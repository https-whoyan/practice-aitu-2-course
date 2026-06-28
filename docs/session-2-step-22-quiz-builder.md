# Сессия 2 · Шаг 22 — Создание квиза и рандомайзер

Детализация шага 22 из [`session-2-features.md`](session-2-features.md), блок 7 (Банк вопросов и квизы).

> **Статус: 📋 Запланировано** (Сессия 2). Реализуется в Prct_46.
> Планируемые пути: `lib/features/quizzes/{domain,data,presentation}/`, коллекция `quizzes`.
> Соответствие ТЗ §5.5.14, §5.5.15, §5.5.16, §7.11.

> Формат: **Цель** · **Действия** · **Модель данных** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Преподаватель собирает квиз внутри курса/недели: задаёт метаданные, выбирает вопросы вручную
и/или настраивает рандомайзер (количество вопросов по теме/типу/сложности, случайный порядок
вопросов и вариантов) и категории (ТЗ §5.5.14–5.5.16). `Quiz`-модель покрывает все 17 полей
коллекции `quizzes` (ТЗ §7.11). Здесь только **настройки**: фактический набор вопросов
фиксируется снапшотом при старте попытки студента ([шаг 23](session-2-step-23-quiz-taking.md),
§5.5.15 п.9). Соответствие ТЗ §5.5.14, §5.5.15, §5.5.16, §7.11.

## Действия

1. **Фича `quizzes`** в `lib/features/quizzes/{domain,data,presentation}/` (эталон фич шага 4).
2. **freezed-модель `Quiz`** ← коллекция `quizzes` (ТЗ §7.11): `quizId`, `courseId`, `weekId`,
   `title`, `description`, `questionIds`, `randomizerSettings`, `categorySettings`, `startDate`,
   `deadline`, `timeLimitMinutes`, `attemptsAllowed`, `showResultMode`, `maxScore`,
   `isPublished`, `createdAt`, `updatedAt` (см. таблицу «Модель данных»). Конвертеры
   `Timestamp ↔ DateTime` (шаг 4).
3. **Enum `ShowResultMode`** (§5.5.17 пп.9–11): `none`, `scoreOnly`, `scoreAndAnswers`,
   `scoreAnswersExplanations` — определяет, что студент увидит после попытки (применяется на
   сервере в [шаге 24](session-2-step-24-quiz-scoring.md)). Строковые коды.
4. **freezed `RandomizerSettings`** (ТЗ §5.5.15): `totalQuestions`,
   `byTopic: Map<topic,int>`, `byType: Map<QuestionType,int>`,
   `byDifficulty: Map<difficulty,int>`, `minHard`, `maxBasic`, `shuffleQuestions`,
   `shuffleOptions`, `excludeDuplicates`. См. таблицу «Настройки рандомайзера».
5. **freezed `CategorySettings`** (ТЗ §5.5.16): список `QuizCategory` с полями `basis`
   (тема/тип/сложность/тег/неделя/модуль/ручная подборка), `questionCount`, `pointsPerQuestion`,
   `required`, `order` — категории можно добавлять, переупорядочивать, исключать, обновлять без
   пересборки квиза.
6. **Контракт `QuizRepository`** в `domain/`: `watchQuizzes(courseId)`, `getQuiz(id)`,
   `createQuiz(...)`, `updateQuiz(...)`, `publishQuiz(id)` / `unpublishQuiz(id)`,
   `deleteQuiz(id)`. Реализация `FirestoreQuizRepository` в `data/` поверх `firestoreProvider`
   (шаг 2), `withConverter`, ошибки → `Failure` (шаг 4); `@riverpod`-провайдеры.
7. **Превью-резолвер рандомайзера** (клиентский, только для предпросмотра): по
   `RandomizerSettings` + `CategorySettings` и доступному банку (шаг 20) показывает, сколько
   вопросов наберётся, и предупреждает о нехватке (например, «нужно 5 из темы Git, доступно 3»).
   **Фактическая выборка вопросов выполняется на сервере при старте попытки** (шаг 23), здесь —
   только валидация настроек.
8. **Экран сборки квиза** (`/teacher/courses/:id/quizzes/new` и `/:quizId`, go_router шаг 9,
   UI-кит шаг 5): метаданные (название, описание, привязка к неделе), даты/время/попытки/режим
   показа, ручной выбор `questionIds` из банка (с фильтрами шага 20), редактор настроек
   рандомайзера и категорий, переключатель публикации.
9. **`maxScore`** считается из выбранных вопросов/категорий (сумма баллов); при рандомайзере —
   из фактического снапшота на сервере (шаг 24). На этапе сборки показываем расчётный максимум.
10. **Тесты:** сериализация `Quiz` ↔ Firestore (включая вложенные `randomizerSettings`/
    `categorySettings`), unit-тесты превью-резолвера рандомайзера (счётчики, нехватка вопросов).

## Модель данных (ТЗ §7.11)

| Коллекция | Документ | Ключевые поля |
|-----------|----------|---------------|
| `quizzes` | `Quiz` | `quizId, courseId, weekId, title, description, questionIds, randomizerSettings, categorySettings, startDate, deadline, timeLimitMinutes, attemptsAllowed, showResultMode, maxScore, isPublished, createdAt, updatedAt` |

> `questionIds` — ручной пул вопросов; `randomizerSettings`/`categorySettings` — правила выборки
> из банка (шаг 20). Что увидит студент после попытки, определяет `showResultMode`; сама проверка
> ответов и расчёт `maxScore` для рандомных квизов — на сервере (шаг 24, §8.5).

## Настройки рандомайзера (ТЗ §5.5.15)

| Настройка | Поле `RandomizerSettings` | Назначение |
|-----------|---------------------------|------------|
| Всего вопросов | `totalQuestions` | Размер квиза |
| По темам | `byTopic` (`{Git: 5, Databases: 3, ...}`) | Сколько из каждой темы |
| По типам | `byType` | Сколько каждого типа вопроса (§5.5.2) |
| По сложности | `byDifficulty`, `minHard`, `maxBasic` | Напр. «мин. 2 сложных, макс. 4 простых» |
| Случайный порядок вопросов | `shuffleQuestions` | Перемешивание вопросов |
| Случайный порядок вариантов | `shuffleOptions` | Перемешивание ответов внутри вопроса |
| Без повторов | `excludeDuplicates` | Исключить повторяющиеся вопросы |
| Разные варианты студентам | (следствие выборки на сервере) | Свой набор каждому |
| Фиксация после старта | (снапшот, шаг 23) | Набор не меняется после начала попытки |

## Решения

- **Выборка по рандомайзеру — на сервере при старте попытки** (шаг 23), не при сборке: иначе у
  всех студентов был бы один набор, нарушая §5.5.15 пп.8–9 («разные варианты», «фиксация после
  старта»). На этапе сборки — только превью и валидация настроек.
- **`randomizerSettings` и `categorySettings` — отдельные вложенные freezed-объекты**, а не
  плоские поля `Quiz` — настройки сложные и переиспользуются в логике старта попытки.
- **Категории обновляются без пересоздания квиза** (§5.5.16 п.7) — `CategorySettings` правится
  отдельно от `questionIds`; уже завершённые попытки защищены снапшотом (шаг 23).
- **`ShowResultMode` хранится в квизе, применяется на сервере** (шаг 24) — клиент не решает, что
  показать; раскрытие правильных ответов контролирует Cloud Function (§8.5 п.1).
- **`isPublished` — единственный признак доступности студенту** (UI студента и Security Rules
  шага 27 фильтруют по нему вместе со `startDate`/`deadline`); неопубликованный квиз студент не
  видит (§5.6.3).
- **Доступ только через `QuizRepository`** (эталон шага 4).

## Артефакты

`features/quizzes/domain/quiz.dart`, `randomizer_settings.dart`, `category_settings.dart`,
`show_result_mode.dart`, `quiz_repository.dart` (контракт) (+ `*.freezed.dart`/`*.g.dart`);
`features/quizzes/data/firestore_quiz_repository.dart`, `quiz_providers.dart`,
`features/quizzes/domain/randomizer_preview.dart` (превью-резолвер);
`features/quizzes/presentation/builder/` (экран сборки: метаданные, выбор вопросов, рандомайзер,
категории, публикация); маршруты квизов в `routing/app_router.dart`;
`test/features/quizzes/quiz_serialization_test.dart`,
`test/features/quizzes/randomizer_preview_test.dart`.

## Готово, когда

`Quiz` со вложенными `randomizerSettings`/`categorySettings` сериализуется ↔ `quizzes` (на
эмуляторе); преподаватель собирает квиз вручную и через рандомайзер/категории, превью корректно
считает набор и предупреждает о нехватке вопросов; даты/время/попытки/режим показа сохраняются;
публикация/снятие работают; `dart analyze` чисто, тесты сериализации и превью-резолвера зелёные.

---

**Зависимости:** [шаг 20](session-2-step-20-question-bank.md) (банк вопросов, `QuestionType`),
[шаг 13](session-2-step-13-course-domain.md) (курсы/недели для `courseId`/`weekId`),
[шаг 4](session-1-step-4-stack-di.md) (freezed, Failure, провайдеры).
**Дальше:** [шаг 23 — Прохождение квиза студентом](session-2-step-23-quiz-taking.md).
