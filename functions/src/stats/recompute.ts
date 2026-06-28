/**
 * Callable-обёртки пересчёта сводок (ТЗ §9 п.9–10,14, P3-6).
 *
 * Базовая логика — в `summary.ts` (вызывается и из триггеров оценок). Здесь —
 * ручной пересчёт для преподавателя/админа (например, кнопка «обновить» на
 * экранах статистики).
 */
import {onCall, HttpsError} from "firebase-functions/v2/https";

import {FUNCTION_OPTS} from "../lib/region";
import {assertTeacher} from "../lib/auth";
import {
  recomputeStudentSummary,
  recomputeGroupSummary,
  recomputeCourseSummary,
} from "./summary";

export const recomputeStudentStats = onCall(FUNCTION_OPTS, async (request) => {
  assertTeacher(request);
  const studentId = (request.data ?? {}).studentId as string | undefined;
  if (!studentId) throw new HttpsError("invalid-argument", "Не указан студент.");
  await recomputeStudentSummary(studentId);
  return {ok: true};
});

export const recomputeGroupStats = onCall(FUNCTION_OPTS, async (request) => {
  assertTeacher(request);
  const groupId = (request.data ?? {}).groupId as string | undefined;
  if (!groupId) throw new HttpsError("invalid-argument", "Не указана группа.");
  await recomputeGroupSummary(groupId);
  return {ok: true};
});

export const recomputeCourseStats = onCall(FUNCTION_OPTS, async (request) => {
  assertTeacher(request);
  const courseId = (request.data ?? {}).courseId as string | undefined;
  if (!courseId) throw new HttpsError("invalid-argument", "Не указан курс.");
  await recomputeCourseSummary(courseId);
  return {ok: true};
});
