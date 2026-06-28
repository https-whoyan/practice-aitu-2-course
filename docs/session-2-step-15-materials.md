# Сессия 2 · Шаг 15 — Учебные материалы

Детализация шага 15 из [`session-2-features.md`](session-2-features.md), блок 5 (Курсы, группы, материалы).

> **Статус: 📋 Запланировано** (Сессия 2). Реализуется в Prct_46.
> Планируемые пути: `lib/features/materials/{domain,data,presentation}/`
> (`material`, `material_type`, `material_repository`, экран добавления материала). ТЗ §5.4.5,
> §7.6, §8.4.

> Формат: **Цель** · **Действия** · **Типы материалов** · **Решения** · **Артефакты** · **Готово, когда**.

---

## Цель

Преподаватель добавляет к неделям курса учебные материалы разных типов (текст, ссылка, YouTube,
файл, презентация, PDF, изображение), управляет их видимостью и порядком. Файлы грузятся в
Firebase Storage, YouTube-видео проигрывается внутри приложения. Соответствие ТЗ §5.4.5, §7.6,
§8.4.

## Действия

1. **Фича `materials`** с моделью `Material` (freezed, шаг 4) ← коллекция `materials` (ТЗ §7.6):
   `materialId`, `courseId`, `weekId`, `title`, `description`, `type`, `url`, `fileUrl`,
   `orderIndex`, `isPublished`, `createdAt`, `updatedAt`.
2. **Enum `MaterialType { text, link, youtube, file, presentation, pdf, image }`** со строковыми
   кодами (ТЗ §5.4.5).
3. **Контракт `MaterialRepository`** в `domain/`: `watchMaterials(weekId)`, `addMaterial`,
   `updateMaterial`, `deleteMaterial`, `reorder(weekId, order)`, `setPublished(id, value)`;
   реализация в `data/` поверх `firestoreProvider` (шаг 2), ошибки → `Failure` (шаг 4).
4. **Загрузка файлов в Firebase Storage** (`firebaseStorageProvider`, шаг 2) для типов
   `file/presentation/pdf/image`: путь с привязкой к курсу/неделе/пользователю, прогресс,
   запись `fileUrl`. Правила Storage (лимит размера, безопасные типы, запрет исполняемых) —
   детализируются в [шаге 27](session-2-step-27-security-rules.md), здесь только отметить (ТЗ §8.4).
5. **YouTube** (ТЗ §5.4.5): принять ссылку, **валидировать корректность**, извлечь videoId,
   сохранить `url`; встроенный плеер через пакет `youtube_player_flutter` — студент смотрит
   видео внутри приложения, не покидая его (просмотр — шаг 16).
6. **Видимость/публикация и порядок** — флаг `isPublished` и `orderIndex` (как у недель, шаг 13);
   неопубликованные материалы студент не видит (шаг 16 + правила шага 27, ТЗ §5.6.3).
7. **Экран «Добавление материала»** под страницей курса/недели (шаг 14): выбор типа → нужные
   поля (текст / ссылка / YouTube / выбор файла), предпросмотр, сохранение; UI-кит shared/widgets
   (шаг 5).

## Типы материалов (ТЗ §5.4.5)

| Тип (`MaterialType`) | Хранение | Назначение |
|----------------------|----------|------------|
| `text` | `description` | Текстовый материал |
| `link` | `url` | Ссылка на внешний ресурс |
| `youtube` | `url` (videoId) | YouTube-видео, плеер внутри приложения |
| `file` | `fileUrl` (Storage) | Произвольный файл |
| `presentation` | `fileUrl` (Storage) | Презентация |
| `pdf` | `fileUrl` (Storage) | PDF-документ |
| `image` | `fileUrl` (Storage) | Изображение |

> Дополнительная ссылка (ТЗ §5.4.5 п.8) — частный случай `link`. Реальная фильтрация
> неопубликованных и ограничения Storage — Security/Storage Rules ([шаг 27](session-2-step-27-security-rules.md)).

## Решения

- **Один `Material` с полем `type`** вместо модели на каждый тип — общая коллекция `materials`
  (ТЗ §7.6), UI выбирает рендер/форму по `MaterialType`.
- **Файлы — в Firebase Storage, в Firestore только `fileUrl`** — БД не хранит бинарь;
  путь привязан к пользователю и сущности (ТЗ §8.4 п.7).
- **YouTube-видео встроено (`youtube_player_flutter`)** — просмотр без выхода из приложения
  (ТЗ §5.4.5 п.4–5); хранится только ссылка/videoId после валидации.
- **Видимость — флаг `isPublished`** на материале; запрет на чтение скрытого — правила
  (шаг 27, ТЗ §5.6.3, §8.3 п.6), клиент дублирует.
- **Ограничения файлов (размер/типы/запрет исполняемых) — на стороне Storage Rules** (шаг 27),
  не только клиентский фильтр (ТЗ §8.1, §8.4).

## Артефакты

`features/materials/domain/material.dart`, `material_type.dart`, `material_repository.dart`
(+`*.freezed.dart`/`*.g.dart`),
`features/materials/data/firestore_material_repository.dart`, `material_providers.dart`,
`features/materials/data/material_storage_service.dart` (загрузка в Storage),
`features/materials/presentation/material_form_screen.dart`,
`features/materials/presentation/widgets/youtube_player.dart`,
`test/features/materials/material_serialization_test.dart`,
заметка о правилах в `storage.rules` (детализация — шаг 27).

## Готово, когда

Преподаватель добавляет материалы всех типов к неделе; файлы грузятся в Storage и читаются по
`fileUrl`; YouTube-ссылка валидируется и проигрывается встроенным плеером; видимость и порядок
управляются; неопубликованные материалы не отдаются студенту (проверка на эмуляторе совместно
с правилами шага 27); `dart analyze` чисто, тесты сериализации проходят.

---

**Зависимости:** [шаг 14](session-2-step-14-teacher-courses-weeks.md) (страница курса/недель),
[шаг 2](session-1-step-2-firebase.md) (Firestore/Storage-провайдеры). **Дальше:** [шаг 16 — Студент: доступ к курсам](session-2-step-16-student-courses-enrollment.md).
