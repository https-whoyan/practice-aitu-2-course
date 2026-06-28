# Сессия 2 · Шаг 20 — Банк вопросов и типы вопросов

Детализация шага 20 из [`session-2-features.md`](session-2-features.md), блок 7 (Банк вопросов и квизы).

> **Статус: 📋 Запланировано** (Сессия 2). Реализуется в Prct_46.
> Планируемые пути: `lib/features/questions/{domain,data,presentation}/`, коллекция
> `questionBank`. Соответствие ТЗ §5.5.1, §5.5.2, §5.5.3–5.5.9, §7.10, §12.

> Формат: **Цель** · **Действия** · **Типы вопросов** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

У каждого преподавателя — личный банк вопросов с CRUD, архивированием, дублированием,
повторным использованием и привязкой вопроса к нескольким курсам (ТЗ §5.5.1). Доменная
модель `Question` покрывает все 15 полей коллекции `questionBank` (ТЗ §7.10) и описывает
разнотипные ответы через freezed-union по типу вопроса (шаг 4). В MVP реализуем 4 из 12 типов
(single / multiple / trueFalse / shortText), остальные 8 закладываем как расширение модели без
UI. Банк фильтруется по типу, теме, сложности, тегам и дате (ТЗ §12). Соответствие ТЗ §5.5.1,
§5.5.2, §5.5.3–5.5.9, §7.10, §12.

## Действия

1. **Фича `questions`** в `lib/features/questions/{domain,data,presentation}/` —
   по эталон-шаблону фич Сессии 1 (шаг 4).
2. **Enum `QuestionType`** в `domain/` со строковыми кодами для Firestore (совпадают с кодами
   TXT-импорта шага 21): `single`, `multiple`, `trueFalse`, `shortText` — **MVP**; плюс
   `matching`, `dragDrop`, `ordering`, `fillBlank`, `numeric`, `image`, `code`, `multiCategory` —
   объявлены, но без UI прохождения (расширение). См. таблицу «Типы вопросов».
3. **Enum `QuestionStatus { active, draft, archived }`** и
   `QuestionDifficulty { basic, medium, hard }` — строковые коды, без «магических строк».
4. **freezed-модель `Question`** (шаг 4, code-gen) ← коллекция `questionBank` (ТЗ §7.10):
   общие поля `questionId`, `text`, `type`, `topic`, `tags`, `difficulty`, `points`,
   `explanation`, `status`, `ownerTeacherId`, `courseIds`, `createdAt`, `updatedAt`;
   тип-специфичные поля `options`, `correctAnswer`, `pairs`, `categories`, `orderItems`
   (см. таблицу «Модель данных»). `fromJson/toJson` + конвертеры `Timestamp ↔ DateTime`
   (`core/utils/`, шаг 4).
5. **freezed-union `AnswerSpec`** по типу ответа (шаг 4) — типобезопасная замена «плоских»
   nullable-полей: `SingleAnswer(options, correctIndex)`,
   `MultipleAnswer(options, correctIndexes, partialScoring)` (§5.5.4),
   `TrueFalseAnswer(correct)`, `ShortTextAnswer(acceptedAnswers, caseSensitive)` — MVP;
   `MatchingAnswer(pairs)`, `OrderingAnswer(orderItems)`,
   `DragDropAnswer(categories, items)`, `FillBlankAnswer`, `NumericAnswer(value, tolerance)`
   — заглушки расширения. Маппинг union ↔ «плоские» поля `questionBank` (`options`,
   `correctAnswer`, `pairs`, `categories`, `orderItems`) — в `data/`.
6. **Контракт `QuestionRepository`** в `domain/`: `watchQuestions(filter)`, `getQuestion(id)`,
   `createQuestion(...)`, `updateQuestion(...)`, `archiveQuestion(id)`, `deleteQuestion(id)`,
   `duplicateQuestion(id)` (независимая копия — новый `questionId`, §5.5.13),
   `attachToCourses(id, courseIds)` (привязка к нескольким курсам, §5.5.1 п.9).
7. **Реализация `FirestoreQuestionRepository`** в `data/` поверх `firestoreProvider` (шаг 2),
   `withConverter` для `questionBank`, ошибки → `Failure` (шаг 4). Запросы строятся под
   составные индексы Firestore (по `ownerTeacherId` + фильтры).
8. **`QuestionFilter`** (value-object) и `@riverpod`-провайдеры: `questionListProvider(filter)`,
   `questionRepositoryProvider`. Фильтры: тип, тема, сложность, теги, дата создания (ТЗ §12).
9. **Экраны банка** (UI-кит шага 5) на маршрутах преподавателя (go_router, шаг 9):
   список с фильтрами и поиском, форма создания/редактирования (поля адаптируются под
   `QuestionType`), действия «дублировать», «архивировать», «привязать к курсам». Маршруты —
   `/teacher/questions`, `/teacher/questions/new`, `/teacher/questions/:id`.
10. **Серверная граница (§8.1):** правильные ответы (`correctAnswer`, `pairs`, `orderItems`)
    читаются только владельцем-преподавателем/админом; студент к `questionBank` доступа не
    имеет — Security Rules детализируются в [шаге 27](session-2-step-27-security-rules.md).
11. **Тесты:** сериализация `Question` ↔ Firestore для 4 MVP-типов, маппинг union ↔ плоские
    поля, корректность фильтров (на эмуляторе).

## Типы вопросов (ТЗ §5.5.2)

| № | Тип | Код `QuestionType` | MVP | Тип-специфичные поля |
|---|-----|--------------------|-----|----------------------|
| 1 | Один правильный ответ | `single` | ✅ | `options`, `correctAnswer` |
| 2 | Несколько правильных ответов | `multiple` | ✅ | `options`, `correctAnswer[]`, режим частичного балла (§5.5.4) |
| 3 | Верно / неверно | `trueFalse` | ✅ | `correctAnswer` (bool) |
| 4 | Соответствие | `matching` | — (расширение) | `pairs` |
| 5 | Drag and drop | `dragDrop` | — (расширение) | `categories`, items |
| 6 | Сортировка по порядку | `ordering` | — (расширение) | `orderItems` |
| 7 | Заполнение пропуска | `fillBlank` | — (расширение) | `options`, `correctAnswer[]` |
| 8 | Краткий текстовый ответ | `shortText` | ✅ | `correctAnswer[]` (список допустимых), флаг регистра |
| 9 | Числовой ответ | `numeric` | — (расширение) | `correctAnswer`, погрешность |
| 10 | Вопрос с изображением | `image` | — (расширение) | `options` + URL изображения |
| 11 | Вопрос с кодом | `code` | — (расширение) | `options`/`correctAnswer` + фрагмент |
| 12 | Несколько категорий ответов | `multiCategory` | — (расширение) | `categories` |

> **MVP-срез:** реализуем 4 типа (single / multiple / trueFalse / shortText) — этого достаточно
> для приёмки блока 7. Остальные 8 присутствуют в `QuestionType` и `AnswerSpec` как объявленные
> ветки union, но без экранов создания/прохождения; добавляются при наличии времени, не ломая
> модель данных.

## Модель данных (ТЗ §7.10)

| Коллекция | Документ | Ключевые поля |
|-----------|----------|---------------|
| `questionBank` | `Question` | `questionId, ownerTeacherId, courseIds, text, type, topic, tags, difficulty, points, options, correctAnswer, pairs, categories, orderItems, explanation, status, createdAt, updatedAt` |

> Поля `options / correctAnswer / pairs / categories / orderItems` — взаимоисключающие по
> `type`; на клиенте они представлены типобезопасным union `AnswerSpec`, а в Firestore хранятся
> «плоско» (как в ТЗ §7.10). Источник истины владения — `ownerTeacherId` (преподаватель из
> шага 6); `courseIds` — список курсов (шаг 13), где вопрос переиспользуется (§5.5.1 п.9, п.17).

## Решения

- **freezed-union `AnswerSpec` вместо россыпи nullable-полей** — компилятор гарантирует, что для
  `single` есть `options`+`correctIndex`, а для `matching` — `pairs`; маппинг в «плоскую»
  схему ТЗ §7.10 изолирован в `data/`.
- **Один enum-код на тип в клиенте, Firestore и TXT** — `QuestionType` совпадает со значениями
  поля `TYPE` импорта (шаг 21), чтобы парсер и модель не расходились.
- **MVP = 4 типа** (ТЗ §5.5.3, §5.5.4, верно/неверно, §5.5.9) — явный кандидат на сокращение из
  `session-2-features.md`; модель спроектирована расширяемой, чтобы остальные 8 не требовали
  миграции схемы.
- **Дублирование = независимая копия** (§5.5.13): новый `questionId`, правка копии не влияет на
  оригинал. Связанные копии (единый объект в нескольких курсах) — вне MVP.
- **Привязка к нескольким курсам через `courseIds[]`**, а не копирование — повторное
  использование без размножения документов (§5.5.1 п.17).
- **Доступ только через `QuestionRepository`** — фичи не обращаются к `FirebaseFirestore`
  напрямую (эталон шага 4); правильные ответы недоступны студенту (§8.1, граница в шаге 27).
- **Архивирование вместо удаления по умолчанию** (`status: archived`) — вопрос мог попасть в
  снапшоты завершённых попыток (шаг 23), жёсткое удаление их не затрагивает.

## Артефакты

`features/questions/domain/question.dart`, `answer_spec.dart`, `question_type.dart`,
`question_status.dart`, `question_difficulty.dart`, `question_filter.dart`,
`question_repository.dart` (контракт) (+ сгенерированные `*.freezed.dart`/`*.g.dart`);
`features/questions/data/firestore_question_repository.dart`,
`features/questions/data/question_providers.dart`;
`features/questions/presentation/` (список банка с фильтрами, форма создания/редактирования,
действия дублирования/архивации/привязки); маршруты вопросов в `routing/app_router.dart`;
`test/features/questions/question_serialization_test.dart`,
`test/features/questions/question_filter_test.dart`.

## Готово, когда

`Question` сериализуется/десериализуется из `questionBank` для 4 MVP-типов (проверено на
эмуляторе); union `AnswerSpec` корректно маппится в «плоские» поля и обратно; преподаватель в
банке создаёт/правит/архивирует/дублирует вопрос и привязывает его к нескольким курсам; фильтры
по типу/теме/сложности/тегам/дате (§12) возвращают верный набор; правильные ответы недоступны не
владельцу; `dart analyze` чисто, unit-тесты сериализации и фильтров зелёные.

---

**Зависимости:** [шаг 13](session-2-step-13-course-domain.md) (курсы для `courseIds`),
[шаг 6](session-1-step-6-user-model.md) (`ownerTeacherId`, роли),
[шаг 4](session-1-step-4-stack-di.md) (freezed, Failure, провайдеры),
[шаг 2](session-1-step-2-firebase.md) (Firestore).
**Дальше:** [шаг 21 — Импорт вопросов из TXT](session-2-step-21-question-import.md).
