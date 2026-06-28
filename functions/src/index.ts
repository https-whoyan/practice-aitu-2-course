/**
 * Cloud Functions для EduApp — точка реэкспорта.
 *
 * Организация по доменам: `admin/` (пользователи), `lib/` (общие хелперы:
 * region/auth/audit). Контент/квизы/статистика/уведомления добавляются по мере
 * Сессии 2. Регион и единичная инициализация firebase-admin — в `lib/region.ts`.
 */
import {onRequest, onCall} from "firebase-functions/v2/https";
import {FUNCTION_OPTS} from "./lib/region";

/** Health-check для проверки эмулятора Functions. */
export const ping = onRequest(FUNCTION_OPTS, (_req, res) => {
  res.json({ok: true, service: "eduapp-functions", session: 2});
});

/** Возвращает uid и роль из custom claims (диагностика клиента). */
export const whoami = onCall(FUNCTION_OPTS, (request) => {
  return {
    uid: request.auth?.uid ?? null,
    role: request.auth?.token.role ?? null,
  };
});

// --- Блок 4. Админка: операции над пользователями (шаг 10) ---
export {
  createUser,
  createTeacher,
  setUserRole,
  resetUserPassword,
  blockUser,
  unblockUser,
  softDeleteUser,
} from "./admin/users";

// --- Подтверждение email (§5.1.4, P1-10) ---
export {confirmEmailVerified} from "./auth/verify";

// --- Блок 5. Коды приглашения в группу (шаг 16) ---
export {createInviteCode, joinGroupByCode} from "./content/invites";

// --- Соавторы-преподаватели курса (§5.4.3, P2-1) ---
export {addCourseTeacherByEmail} from "./courses/teachers";

// --- Блок 6. Аудит изменений оценок (шаг 19) ---
export {onGradeWritten} from "./grading/audit";

// --- Блок 7. Импорт вопросов, старт и расчёт квизов (шаги 21, 23, 24) ---
export {importQuestions} from "./questions/import";
export {startQuizAttempt} from "./quizzes/start";
export {calculateQuizResult} from "./quizzes/calculate";

// --- Блок 8. Статистика и уведомления (шаги 25, 26; P2-20) ---
export {
  onGradeNotify,
  onAssignmentNotify,
  onWeekNotify,
  onQuizNotify,
  onSubmissionNotify,
} from "./notifications/create";

// --- Пересчёт сводок вручную (§9 п.9–10,14, P3-6) ---
export {
  recomputeStudentStats,
  recomputeGroupStats,
  recomputeCourseStats,
} from "./stats/recompute";
