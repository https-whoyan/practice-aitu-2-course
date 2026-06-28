# Инструкция — Beksultan (ветка `beksultan`)

Ты заливаешь **вторым** — после того, как Yan выложил свою ветку.

## Твоя ветка
- Ветка: `beksultan`
- Шаги: **step 4–6** (каркас стека и DI, тема и UI-компоненты, модели пользователя)
- Твоя ветка включает работу Yan (step 1–3) — так и должно быть (ветки идут стопкой).

## Что сделать

> ⚠️ Сначала дождись, пока **Yan** зальёт свою ветку в Prct_46. Только потом ты.

```bash
# 1. склонировать репозиторий-источник (код берём отсюда)
git clone git@github.com:https-whoyan/practice-aitu-2-course.git
#   HTTPS-вариант: git clone https://github.com/https-whoyan/practice-aitu-2-course.git
cd practice-aitu-2-course

# 2. встать на свою ветку
git checkout beksultan

# 2a. ПРОВЕРЬ СЕБЯ: должны быть видны твои шаги (step 4/5/6)
git log --oneline -6
#   Если видишь только один коммит про «ТЗ и план» — значит Yan ещё не выложил
#   ветки в источник. Подожди его и сделай: git pull --ff-only origin beksultan

# 3. добавить финальный репозиторий как remote
git remote add prct46 git@github.com:Tduyer/Prct_46.git
#   HTTPS-вариант: git remote add prct46 https://github.com/Tduyer/Prct_46.git

# 4. залить свою ветку в ту же ветку main (встанет fast-forward поверх работы Yan)
git push prct46 beksultan:main
```

После этого скажи Duran, что можно заливаться.

## Порядок (обязателен)

```
1) Yan
2) Beksultan  ← ты, второй
3) Duran
```

Заливаться можно **только после Yan**: твоя ветка — продолжение его веток,
и `main` Prct_46 должен уже содержать его step 1–3. Иначе пуш не пройдёт
(non-fast-forward).

## Ограничения

- **Нельзя** `rebase` / `squash` / `amend` и мерджить чужие ветки в `beksultan` —
  сломаешь стопку, и Duran не сможет залиться fast-forward.
- Авторов коммитов не меняем.
- `git pull` — только с `--ff-only`.
- Нужен доступ на запись (collaborator) к `Tduyer/Prct_46`.
  Авторизация: SSH-ключ на GitHub (вариант `git@…`) или HTTPS + Personal Access Token.

## Если пуш отклонён

- `... rejected ... (non-fast-forward)` — **не делай `--force`.** Причины обычно две:
  1. Yan ещё не залил свою ветку — дождись его, потом пушь.
  2. Кто-то нарушил порядок. Сверьтесь: должно быть Yan → ты → Duran.

Картина целиком: [`git-workflow.md`](git-workflow.md).
Запуск проекта локально: [`dev-runbook.md`](dev-runbook.md).

---

## Сессия 2 — ветка `beksultan-s2`

Ты снова **второй** — после Yan. Твоя доля Сессии 2: курсы и недели преподавателя,
материалы, доступ студента к курсам/вступление в группу, задания, оценки (~12.1k строк).
Ветка `beksultan-s2` идёт поверх `yan-s2` (стопка, как в Сессии 1).

> ⚠️ Сначала дождись, пока Yan зальёт `yan-s2` (его шаг уже выполнен — `main`
> Prct_46 стоит на `yan-s2`). Только потом ты.

```bash
git fetch origin
git checkout beksultan-s2          # впервые: git checkout -b beksultan-s2 origin/beksultan-s2

# самопроверка: видны твои session-2 шаги
git log --oneline -10
#   курсы/недели, материалы, доступ студента, задания, оценки

# если remote ещё не добавлен:
git remote add prct46 git@github.com:Tduyer/Prct_46.git

# залить в main (FF поверх yan-s2)
git push prct46 beksultan-s2:main
```

После этого скажи Duran, что можно заливать `duran-s2`.

**Если пуш отклонён (non-fast-forward):** не делай `--force`. Либо Yan ещё не залил
`yan-s2`, либо нарушен порядок. Должно быть `yan-s2 → beksultan-s2 → duran-s2`.
Запреты прежние: без `rebase`/`squash`/`amend`, `pull --ff-only`.
