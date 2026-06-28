# Инструкция — Yan (ветка `yan`)

Ты заливаешь **первым**. Твоя ветка — основание стопки, на ней строятся
ветки Beksultan и Duran.

## Твоя ветка
- Ветка: `yan`
- Шаги: **step 1–3** (инициализация проекта, Firebase, Emulator Suite)

## Шаг 0 — опубликовать ветки в источник (для всех)

Прежде чем ребята смогут что-то склонировать, ветки должны лежать в
репозитории-источнике. Запушь `common` (на нём эти инструкции) и все три ветки:

```bash
git push origin common yan beksultan duran
```

Проверка: `git ls-remote --heads origin` — у `yan`/`beksultan`/`duran` должны
быть РАЗНЫЕ хэши (если у всех одинаковый — значит ветки ещё не обновлены).

## Что сделать

> Цель: положить свою ветку в `main` репозитория `Tduyer/Prct_46` (он сейчас пустой).
> Репозиторий-источник у тебя уже есть локально — клонировать заново не нужно.

```bash
# 1. встать на свою ветку в репозитории-источнике
git checkout yan

# 2. добавить финальный репозиторий как remote (один раз)
git remote add prct46 git@github.com:Tduyer/Prct_46.git
#   HTTPS-вариант: git remote add prct46 https://github.com/Tduyer/Prct_46.git

# 3. залить свою ветку в ЕДИНСТВЕННУЮ ветку main (создаст её)
git push prct46 yan:main
```

После этого скажи Beksultan, что можно заливаться.

## Порядок (обязателен)

```
1) Yan  ← ты, первый
2) Beksultan
3) Duran
```

Ты идёшь первым, потому что `main` Prct_46 пустой и его создаёт первый пуш.
Если зальётся кто-то другой раньше — твой пуш `step 1–3` уйдёт «назад» и не пройдёт.

## Ограничения

- **Нельзя** `rebase` / `squash` / `amend` и мерджить чужие ветки в `yan` —
  это сломает стопку и fast-forward для следующих.
- Авторов коммитов не меняем.
- Нужен доступ на запись (collaborator) к `Tduyer/Prct_46`.
  Авторизация: либо SSH-ключ привязан к GitHub (вариант `git@…`),
  либо HTTPS + Personal Access Token вместо пароля.

## Если пуш отклонён

- `... rejected ... (fetch first / non-fast-forward)` — в `main` Prct_46 уже что-то есть.
  **Не делай `--force`.** Скорее всего кто-то залился вперёд тебя — разберитесь
  с порядком (ты должен быть первым) и при необходимости очистите `main`.

Картина целиком: [`git-workflow.md`](git-workflow.md).

---

## Сессия 2 — ветка `yan-s2`

Ты снова **первый**. Твоя доля Сессии 2: core-зависимости, Cloud Functions,
Security/Storage Rules, auth, админка (~8.1k строк). Ветка `yan-s2` надстроена
поверх `duran` (конца Сессии 1), на котором уже стоит `main` Prct_46.

> ✅ **Уже сделано:** ты залит первым — `main` Prct_46 указывает на `yan-s2`.
> Ниже команды для справки / если придётся повторить.

```bash
git fetch origin
git checkout yan-s2                 # впервые: git checkout -b yan-s2 origin/yan-s2
git log --oneline -5               # core, Cloud Functions, Rules, auth, админка
git push prct46 yan-s2:main        # FF поверх duran (step 1–9)
```

После этого скажи Beksultan, что можно заливать `beksultan-s2`.
Те же запреты: без `rebase`/`squash`/`amend`/`--force`, `pull --ff-only`.
