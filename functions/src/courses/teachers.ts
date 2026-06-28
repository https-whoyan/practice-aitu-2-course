/**
 * Управление соавторами-преподавателями курса (ТЗ §5.4.3, P2-1).
 *
 * Преподаватель не может листать коллекцию `users` (Security Rules), поэтому
 * добавление соавтора по email идёт через сервер: проверяем владельца курса,
 * находим пользователя по email, убеждаемся что это преподаватель, и дописываем
 * его в `course.teacherIds`. Удаление соавтора клиент делает сам (updateCourse).
 */
import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue} from "firebase-admin/firestore";

import {FUNCTION_OPTS} from "../lib/region";
import {assertTeacher} from "../lib/auth";
import {writeAuditLog} from "../lib/audit";

export const addCourseTeacherByEmail = onCall(FUNCTION_OPTS, async (request) => {
  const uid = assertTeacher(request);
  const data = (request.data ?? {}) as {courseId?: string; email?: string};
  const courseId = data.courseId;
  const email = (data.email ?? "").trim().toLowerCase();
  if (!courseId || email.length === 0) {
    throw new HttpsError("invalid-argument", "Укажите курс и email.");
  }

  const db = getFirestore();
  const courseRef = db.collection("courses").doc(courseId);
  const course = await courseRef.get();
  if (!course.exists) {
    throw new HttpsError("not-found", "Курс не найден.");
  }
  const isAdmin = request.auth?.token.role === "admin";
  if (!isAdmin && course.get("ownerTeacherId") !== uid) {
    throw new HttpsError(
      "permission-denied",
      "Соавторов добавляет только владелец курса."
    );
  }

  // Находим пользователя по email и проверяем роль teacher.
  const found = await db
    .collection("users")
    .where("email", "==", email)
    .limit(1)
    .get();
  if (found.empty) {
    throw new HttpsError("not-found", "Пользователь с таким email не найден.");
  }
  const target = found.docs[0];
  if (target.get("role") !== "teacher") {
    throw new HttpsError(
      "failed-precondition",
      "Соавтором можно назначить только преподавателя."
    );
  }

  await courseRef.update({
    teacherIds: FieldValue.arrayUnion(target.id),
    updatedAt: FieldValue.serverTimestamp(),
  });

  await writeAuditLog({
    userId: uid,
    role: "teacher",
    actionType: "course.addTeacher",
    entityType: "course",
    entityId: courseId,
    newValue: {teacherId: target.id},
  });

  return {teacherId: target.id};
});
