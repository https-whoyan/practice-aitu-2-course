/**
 * Подтверждение email (ТЗ §5.1.4, P1-10). Только сервер.
 *
 * Клиент после нажатия «Я подтвердил(а)» перезагружает пользователя и обновляет
 * ID-токен; в токене появляется claim `email_verified`. Эта функция проверяет
 * его и переводит документ `users` в подтверждённое состояние — пользователь
 * сам менять свой `status`/`emailVerified` не может (Security Rules §8.1).
 */
import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue} from "firebase-admin/firestore";

import {FUNCTION_OPTS} from "../lib/region";
import {assertSignedIn} from "../lib/auth";

export const confirmEmailVerified = onCall(FUNCTION_OPTS, async (request) => {
  const uid = assertSignedIn(request);

  // Доверяем только claim из токена, а не данным клиента (§8.1).
  if (request.auth?.token.email_verified !== true) {
    throw new HttpsError(
      "failed-precondition",
      "Email ещё не подтверждён. Обновите страницу после подтверждения."
    );
  }

  const db = getFirestore();
  const userRef = db.collection("users").doc(uid);
  const snap = await userRef.get();
  if (!snap.exists) {
    throw new HttpsError("not-found", "Пользователь не найден.");
  }

  const update: Record<string, unknown> = {
    emailVerified: true,
    updatedAt: FieldValue.serverTimestamp(),
  };
  // Активируем только если ждали подтверждения (не трогаем blocked/active).
  if (snap.get("status") === "pendingVerification") {
    update.status = "active";
  }
  await userRef.update(update);

  return {status: (update.status as string) ?? snap.get("status") ?? "active"};
});
