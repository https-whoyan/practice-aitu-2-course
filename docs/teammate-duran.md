# Инструкция — Duran (ветка `duran`)

Ты заливаешь **последним** — после Yan и Beksultan. Твой пуш завершает сборку:
после него `main` Prct_46 содержит весь код Сессии 1.

## Твоя ветка
- Ветка: `duran`
- Шаги: **step 7–9 + тесты** (авторизация, роли/редирект + Security Rules,
  навигация и dashboard'ы, тесты Security Rules)
- Твоя ветка включает работу Yan (step 1–3) и Beksultan (step 4–6) — так и должно
  быть (ветки идут стопкой).

## Что сделать

> ⚠️ Сначала дождись, пока зальются **Yan**, затем **Beksultan**. Ты — последний.

```bash
# 1. склонировать репозиторий-источник (код берём отсюда)
git clone git@github.com:https-whoyan/practice-aitu-2-course.git
#   HTTPS-вариант: git clone https://github.com/https-whoyan/practice-aitu-2-course.git
cd practice-aitu-2-course

# 2. встать на свою ветку
git checkout duran

# 2a. ПРОВЕРЬ СЕБЯ: должны быть видны твои шаги (step 7/8/9 + тесты)
git log --oneline -10
#   Если видишь только один коммит про «ТЗ и план» — значит ветки ещё не выложены
#   в источник. Подожди и сделай: git pull --ff-only origin duran

# 3. добавить финальный репозиторий как remote
git remote add prct46 git@github.com:Tduyer/Prct_46.git
#   HTTPS-вариант: git remote add prct46 https://github.com/Tduyer/Prct_46.git

# 4. залить свою ветку в ту же ветку main (встанет fast-forward поверх Beksultan)
git push prct46 duran:main
```

После этого в `main` Prct_46 — весь код Сессии 1. Готово.

## Порядок (обязателен)

```
1) Yan
2) Beksultan
3) Duran  ← ты, последний
```

Заливаться можно **только после Beksultan**: твоя ветка — продолжение его ветки,
и `main` Prct_46 должен уже содержать step 1–6. Иначе пуш не пройдёт
(non-fast-forward).

## Ограничения

- **Нельзя** `rebase` / `squash` / `amend` и мерджить чужие ветки в `duran` —
  это сломает fast-forward.
- Авторов коммитов не меняем.
- `git pull` — только с `--ff-only`.
- Нужен доступ на запись (collaborator) к `Tduyer/Prct_46`.
  Авторизация: SSH-ключ на GitHub (вариант `git@…`) или HTTPS + Personal Access Token.

## Если пуш отклонён

- `... rejected ... (non-fast-forward)` — **не делай `--force`.** Причины обычно две:
  1. Beksultan ещё не залил свою ветку — дождись, ты последний.
  2. Нарушен порядок. Должно быть Yan → Beksultan → ты.

Картина целиком: [`git-workflow.md`](git-workflow.md).
Запуск проекта локально: [`dev-runbook.md`](dev-runbook.md).
