/**
 * Серверные admin-операции над пользователями (ТЗ §5.3.1–5.3.2, §17.1).
 *
 * Эти действия нельзя безопасно делать с клиента: создание Auth-аккаунтов,
 * назначение ролей, блокировка, мягкое удаление. Каждая операция начинается с
 * `assertAdmin` и журналируется в `auditLogs`.
 */
import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getAuth} from "firebase-admin/auth";
import {getFirestore, FieldValue} from "firebase-admin/firestore";

import {FUNCTION_OPTS} from "../lib/region";
import {assertAdmin} from "../lib/auth";
import {writeAuditLog} from "../lib/audit";

const ROLES = ["admin", "teacher", "student"] as const;
type Role = (typeof ROLES)[number];

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

interface CreateUserData {
  email?: string;
  firstName?: string;
  lastName?: string;
  role?: string;
}

function requireString(value: unknown, field: string): string {
  if (typeof value !== "string" || value.trim().length === 0) {
    throw new HttpsError("invalid-argument", `Поле «${field}» обязательно.`);
  }
  return value.trim();
}

/**
 * Создаёт Auth-аккаунт + пару users/profiles, выставляет custom claim роли,
 * генерирует ссылку установки пароля (ТЗ §17.1). Письмо отправляется через
 * настроенный SMTP/расширение; в эмуляторе ссылка возвращается вызывающему.
 */
export const createUser = onCall(FUNCTION_OPTS, async (request) => {
  const adminUid = assertAdmin(request);
  return createUserImpl(adminUid, (request.data ?? {}) as CreateUserData);
});

/** Создание преподавателя (ТЗ §5.3.2): обёртка createUser с фиксированной ролью. */
export const createTeacher = onCall(FUNCTION_OPTS, async (request) => {
  const adminUid = assertAdmin(request);
  const data = (request.data ?? {}) as CreateUserData;
  // Навязываем роль teacher, остальное — общей логике.
  return createUserImpl(adminUid, {...data, role: "teacher"});
});

/**
 * Меняет users.role и синхронизирует custom claim. Это источник истины для
 * Security Rules (шаг 27). Запрещает снять роль у последнего админа.
 */
export const setUserRole = onCall(FUNCTION_OPTS, async (request) => {
  const adminUid = assertAdmin(request);
  const data = (request.data ?? {}) as {uid?: string; role?: string};
  const uid = requireString(data.uid, "uid");
  const role = requireString(data.role, "role") as Role;

  if (!ROLES.includes(role)) {
    throw new HttpsError("invalid-argument", `Недопустимая роль: ${role}.`);
  }

  const db = getFirestore();
  const userRef = db.collection("users").doc(uid);
  const snap = await userRef.get();
  if (!snap.exists) {
    throw new HttpsError("not-found", "Пользователь не найден.");
  }
  const oldRole = snap.get("role") as string | undefined;

  // Запрет снять последнего админа (ТЗ §5.3.2).
  if (oldRole === "admin" && role !== "admin") {
    const admins = await db.collection("users").where("role", "==", "admin").get();
    const activeAdmins = admins.docs.filter((d) => d.get("deleted") !== true);
    if (activeAdmins.length <= 1) {
      throw new HttpsError(
        "failed-precondition",
        "Нельзя снять роль у последнего администратора."
      );
    }
  }

  await getAuth().setCustomUserClaims(uid, {role});
  await userRef.update({role, updatedAt: FieldValue.serverTimestamp()});

  await writeAuditLog({
    userId: adminUid,
    role: "admin",
    actionType: "setUserRole",
    entityType: "user",
    entityId: uid,
    oldValue: {role: oldRole},
    newValue: {role},
  });

  return {uid, role};
});

/**
 * Сброс пароля существующему пользователю (ТЗ §5.3.1, P2-7). Возвращает ссылку
 * установки пароля (как при создании) — админ передаёт её пользователю.
 */
export const resetUserPassword = onCall(FUNCTION_OPTS, async (request) => {
  const adminUid = assertAdmin(request);
  const data = (request.data ?? {}) as {uid?: string};
  const uid = requireString(data.uid, "uid");

  const auth = getAuth();
  const user = await auth.getUser(uid);
  if (!user.email) {
    throw new HttpsError("failed-precondition", "У пользователя нет email.");
  }
  const resetLink = await auth.generatePasswordResetLink(user.email);

  await writeAuditLog({
    userId: adminUid,
    role: "admin",
    actionType: "resetUserPassword",
    entityType: "user",
    entityId: uid,
  });

  return {uid, email: user.email, resetLink};
});

/** Блокировка: status → blocked + отзыв refresh-токенов (реальная серверная граница). */
export const blockUser = onCall(FUNCTION_OPTS, async (request) => {
  const adminUid = assertAdmin(request);
  const data = (request.data ?? {}) as {uid?: string};
  const uid = requireString(data.uid, "uid");

  if (uid === adminUid) {
    throw new HttpsError("failed-precondition", "Нельзя заблокировать самого себя.");
  }

  const db = getFirestore();
  await db.collection("users").doc(uid).update({
    status: "blocked",
    updatedAt: FieldValue.serverTimestamp(),
  });
  // Сессия завершается на сервере, а не только прячется в UI.
  await getAuth().revokeRefreshTokens(uid);

  await writeAuditLog({
    userId: adminUid,
    role: "admin",
    actionType: "blockUser",
    entityType: "user",
    entityId: uid,
    newValue: {status: "blocked"},
  });

  return {uid, status: "blocked"};
});

/** Разблокировка: status → active. */
export const unblockUser = onCall(FUNCTION_OPTS, async (request) => {
  const adminUid = assertAdmin(request);
  const data = (request.data ?? {}) as {uid?: string};
  const uid = requireString(data.uid, "uid");

  await getFirestore().collection("users").doc(uid).update({
    status: "active",
    updatedAt: FieldValue.serverTimestamp(),
  });

  await writeAuditLog({
    userId: adminUid,
    role: "admin",
    actionType: "unblockUser",
    entityType: "user",
    entityId: uid,
    newValue: {status: "active"},
  });

  return {uid, status: "active"};
});

/**
 * Мягкое удаление (ТЗ §5.3.1): помечает аккаунт удалённым и отключает вход,
 * но связанные grades/quizAttempts/auditLogs сохраняются. Жёсткого удаления нет.
 */
export const softDeleteUser = onCall(FUNCTION_OPTS, async (request) => {
  const adminUid = assertAdmin(request);
  const data = (request.data ?? {}) as {uid?: string};
  const uid = requireString(data.uid, "uid");

  if (uid === adminUid) {
    throw new HttpsError("failed-precondition", "Нельзя удалить самого себя.");
  }

  await getFirestore().collection("users").doc(uid).update({
    deleted: true,
    status: "blocked",
    deletedAt: FieldValue.serverTimestamp(),
    updatedAt: FieldValue.serverTimestamp(),
  });
  // Отключаем Auth-аккаунт (вход невозможен), но не стираем данные.
  await getAuth().updateUser(uid, {disabled: true});
  await getAuth().revokeRefreshTokens(uid);

  await writeAuditLog({
    userId: adminUid,
    role: "admin",
    actionType: "softDeleteUser",
    entityType: "user",
    entityId: uid,
    newValue: {deleted: true},
  });

  return {uid, deleted: true};
});

/**
 * Общая реализация создания пользователя, используемая createUser/createTeacher.
 * Выделена, чтобы createTeacher переиспользовал логику без HTTP-повторов.
 */
async function createUserImpl(
  adminUid: string,
  data: CreateUserData
): Promise<{uid: string; email: string; role: Role; resetLink: string | null}> {
  const email = requireString(data.email, "email").toLowerCase();
  const firstName = requireString(data.firstName, "firstName");
  const lastName = requireString(data.lastName, "lastName");
  const role = (data.role ?? "student") as Role;

  if (!EMAIL_RE.test(email)) {
    throw new HttpsError("invalid-argument", "Некорректный email.");
  }
  if (!ROLES.includes(role)) {
    throw new HttpsError("invalid-argument", `Недопустимая роль: ${role}.`);
  }

  const auth = getAuth();
  const db = getFirestore();

  let userRecord;
  try {
    userRecord = await auth.createUser({
      email,
      emailVerified: false,
      displayName: `${firstName} ${lastName}`.trim(),
      disabled: false,
    });
  } catch (err) {
    const code = (err as {code?: string}).code ?? "";
    if (code === "auth/email-already-exists") {
      throw new HttpsError("already-exists", "Пользователь с таким email уже существует.");
    }
    throw new HttpsError("internal", "Не удалось создать аккаунт.");
  }

  const uid = userRecord.uid;
  await auth.setCustomUserClaims(uid, {role});

  const batch = db.batch();
  batch.set(db.collection("users").doc(uid), {
    email,
    role,
    status: "pendingVerification",
    emailVerified: false,
    createdAt: FieldValue.serverTimestamp(),
    createdBy: adminUid,
  });
  batch.set(db.collection("profiles").doc(uid), {
    firstName,
    lastName,
    displayName: null,
    photoUrl: null,
    groupIds: [],
    courseIds: [],
    teacherCourseIds: [],
    createdAt: FieldValue.serverTimestamp(),
    updatedAt: FieldValue.serverTimestamp(),
  });
  await batch.commit();

  await writeAuditLog({
    userId: adminUid,
    role: "admin",
    actionType: "createUser",
    entityType: "user",
    entityId: uid,
    newValue: {email, role},
  });

  let resetLink: string | null = null;
  try {
    resetLink = await auth.generatePasswordResetLink(email);
  } catch (err) {
    console.error("generatePasswordResetLink failed", err);
  }

  return {uid, email, role, resetLink};
}
