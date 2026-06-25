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

Картина целиком: [`git-workflow.md`](git-workflow.md).
Запуск проекта локально: [`dev-runbook.md`](dev-runbook.md).
