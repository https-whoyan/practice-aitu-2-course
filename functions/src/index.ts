/**
 * Cloud Functions для EduApp.
 *
 * В Сессии 1 здесь только заготовка и health-check (ping) для проверки
 * эмулятора Functions. Реальные функции Сессии 2:
 *   - создание преподавателя админом (callable, с проверкой роли);
 *   - синхронизация роли пользователя в custom claims (триггер на users/{uid});
 *   - агрегированная статистика (триггеры/denormalization);
 *   - отправка уведомлений (FCM).
 */
import {onRequest} from "firebase-functions/v2/https";
import {onCall} from "firebase-functions/v2/https";

/** Health-check для проверки эмулятора Functions. */
export const ping = onRequest((_req, res) => {
  res.json({ok: true, service: "eduapp-functions", session: 1});
});

/** Callable-заготовка (вернёт роль из claims, когда они появятся в Сессии 2). */
export const whoami = onCall((request) => {
  return {
    uid: request.auth?.uid ?? null,
    role: request.auth?.token.role ?? null,
  };
});
