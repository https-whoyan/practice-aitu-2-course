/**
 * Коды приглашения в группу (ТЗ §5.6.2, §9.4–9.5).
 *
 * Проверка кода — на сервере: срок действия, привязка к группе, лимит
 * использований. Студент вступает в группу и получает доступ к её курсам.
 */
import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue, Timestamp} from "firebase-admin/firestore";

import {FUNCTION_OPTS} from "../lib/region";
import {assertSignedIn, assertTeacher} from "../lib/auth";
import {writeAuditLog} from "../lib/audit";

// Анти-перебор кодов приглашения (§5.6.2, P0-6): не более MAX_FAILS неудачных
// попыток за окно WINDOW_MS на uid, иначе блокировка на LOCK_MS.
const MAX_FAILS = 5;
const WINDOW_MS = 10 * 60 * 1000;
const LOCK_MS = 15 * 60 * 1000;

/** Генерирует код приглашения из 8 символов (без похожих символов, P0-6). */
function genCode(seed: number): string {
  const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
  let code = "";
  let n = seed;
  for (let i = 0; i < 8; i++) {
    code += alphabet[n % alphabet.length];
    n = Math.floor(n / alphabet.length) + (i + 1) * 7;
  }
  return code;
}

/**
 * Создаёт код приглашения в группу (преподаватель/админ). `expiresInDays` и
 * `maxUses` опциональны. Возвращает код.
 */
export const createInviteCode = onCall(FUNCTION_OPTS, async (request) => {
  const uid = assertTeacher(request);
  const data = (request.data ?? {}) as {
    groupId?: string;
    expiresInDays?: number;
    maxUses?: number;
  };
  const groupId = data.groupId;
  if (typeof groupId !== "string" || groupId.length === 0) {
    throw new HttpsError("invalid-argument", "Не указана группа.");
  }

  const db = getFirestore();
  const group = await db.collection("groups").doc(groupId).get();
  if (!group.exists) {
    throw new HttpsError("not-found", "Группа не найдена.");
  }

  // Уникальный код: пробуем несколько вариантов от детерминированного сида.
  const base = groupId.split("").reduce((a, c) => a + c.charCodeAt(0), 0);
  let code = "";
  for (let attempt = 0; attempt < 10; attempt++) {
    const candidate = genCode(base + attempt * 1009 + Date.now() % 9973);
    const existing = await db
      .collection("inviteCodes")
      .where("code", "==", candidate)
      .limit(1)
      .get();
    if (existing.empty) {
      code = candidate;
      break;
    }
  }
  if (code === "") {
    throw new HttpsError("internal", "Не удалось сгенерировать код.");
  }

  const expiresAt =
    typeof data.expiresInDays === "number" && data.expiresInDays > 0
      ? new Date(Date.now() + data.expiresInDays * 86400000)
      : null;

  await db.collection("inviteCodes").add({
    code,
    groupId,
    createdBy: uid,
    expiresAt,
    maxUses: typeof data.maxUses === "number" ? data.maxUses : null,
    usedCount: 0,
    active: true,
    createdAt: FieldValue.serverTimestamp(),
  });

  await writeAuditLog({
    userId: uid,
    role: "teacher",
    actionType: "createInviteCode",
    entityType: "group",
    entityId: groupId,
    newValue: {code},
  });

  return {code, groupId, expiresAt: expiresAt?.toISOString() ?? null};
});

/** Фиксирует неудачную попытку ввода кода и блокирует при превышении (P0-6). */
async function recordCodeFailure(
  rlRef: FirebaseFirestore.DocumentReference,
  rl: FirebaseFirestore.DocumentData | undefined,
  nowMs: number
): Promise<void> {
  const windowStart =
    (rl?.windowStart as Timestamp | undefined)?.toMillis?.() ?? 0;
  const fresh = nowMs - windowStart > WINDOW_MS;
  const fails = (fresh ? 0 : ((rl?.fails as number | undefined) ?? 0)) + 1;
  const update: Record<string, unknown> = {
    fails,
    windowStart: fresh ? Timestamp.fromMillis(nowMs) : rl?.windowStart,
  };
  if (fails >= MAX_FAILS) {
    update.lockUntil = Timestamp.fromMillis(nowMs + LOCK_MS);
    update.fails = 0; // окно «сгорает» — после блокировки счёт с нуля
  }
  await rlRef.set(update, {merge: true});
}

/**
 * Вступление студента в группу по коду (ТЗ §5.6.2). Проверяет срок/лимит,
 * добавляет в `studentIds`, зеркалит `profiles.groupIds`+`courseIds`.
 * Анти-перебор: блокировка uid после серии неверных кодов (P0-6).
 */
export const joinGroupByCode = onCall(FUNCTION_OPTS, async (request) => {
  const uid = assertSignedIn(request);
  const data = (request.data ?? {}) as {code?: string};
  const raw = (data.code ?? "").trim().toUpperCase();
  if (raw.length === 0) {
    throw new HttpsError("invalid-argument", "Введите код приглашения.");
  }

  const db = getFirestore();

  // Лимит попыток на uid: при активной блокировке — сразу отказ (P0-6).
  const rlRef = db.collection("rateLimits").doc(`join_${uid}`);
  const rlSnap = await rlRef.get();
  const rl = rlSnap.data();
  const nowMs = Date.now();
  const lockUntil = rl?.lockUntil as Timestamp | undefined;
  if (lockUntil?.toMillis && lockUntil.toMillis() > nowMs) {
    throw new HttpsError(
      "resource-exhausted",
      "Слишком много попыток ввода кода. Попробуйте позже."
    );
  }

  const found = await db
    .collection("inviteCodes")
    .where("code", "==", raw)
    .limit(1)
    .get();
  if (found.empty) {
    await recordCodeFailure(rlRef, rl, nowMs);
    throw new HttpsError("not-found", "Код не найден.");
  }

  const inviteRef = found.docs[0].ref;
  const invite = found.docs[0].data();

  if (invite.active === false) {
    throw new HttpsError("failed-precondition", "Код отозван.");
  }
  const expiresAt = invite.expiresAt as {toDate?: () => Date} | null;
  if (expiresAt && expiresAt.toDate && expiresAt.toDate() < new Date()) {
    throw new HttpsError("failed-precondition", "Срок действия кода истёк.");
  }
  if (
    typeof invite.maxUses === "number" &&
    (invite.usedCount ?? 0) >= invite.maxUses
  ) {
    throw new HttpsError("failed-precondition", "Лимит использований исчерпан.");
  }

  const groupId = invite.groupId as string;
  const groupRef = db.collection("groups").doc(groupId);
  const group = await groupRef.get();
  if (!group.exists) {
    throw new HttpsError("not-found", "Группа не найдена.");
  }
  const courseIds = (group.get("courseIds") as string[] | undefined) ?? [];

  const profileUpdate: Record<string, unknown> = {
    groupIds: FieldValue.arrayUnion(groupId),
    updatedAt: FieldValue.serverTimestamp(),
  };
  // arrayUnion требует ≥1 элемента — добавляем курсы только если они есть.
  if (courseIds.length > 0) {
    profileUpdate.courseIds = FieldValue.arrayUnion(...courseIds);
  }

  const batch = db.batch();
  batch.update(groupRef, {
    studentIds: FieldValue.arrayUnion(uid),
    updatedAt: FieldValue.serverTimestamp(),
  });
  batch.set(db.collection("profiles").doc(uid), profileUpdate, {merge: true});
  batch.update(inviteRef, {usedCount: FieldValue.increment(1)});
  // Успешный ввод сбрасывает счётчик неудач (P0-6).
  batch.set(rlRef, {fails: 0, lockUntil: null}, {merge: true});
  await batch.commit();

  await writeAuditLog({
    userId: uid,
    role: "student",
    actionType: "joinGroup",
    entityType: "group",
    entityId: groupId,
  });

  return {groupId, title: group.get("title") ?? "", courseIds};
});
