/**
 * Создание уведомлений по событиям (ТЗ §5.8, §9 п.11). Только сервер.
 *
 * Уведомления нельзя создавать с клиента (нельзя разослать чужие) — их пишут
 * Cloud Functions. Покрываются события: оценка, публикация задания/недели/квиза
 * (рассылка студентам курса) и возврат/отклонение работы. Дедлайн-напоминания
 * (deadlineSoon/Overdue) — это запланированная функция (вынесено в P4/cron).
 */
import {
  onDocumentWritten,
  onDocumentCreated,
  onDocumentUpdated,
} from "firebase-functions/v2/firestore";
import {getFirestore, FieldValue} from "firebase-admin/firestore";

import {REGION} from "../lib/region";
import {
  recomputeStudentSummary,
  recomputeGroupSummary,
  recomputeCourseSummary,
} from "../stats/summary";

interface NotificationInput {
  userId: string;
  type: string;
  title: string;
  body: string;
  payload?: Record<string, unknown>;
}

/** Пишет документ in-app уведомления. */
async function createNotification(n: NotificationInput): Promise<void> {
  await getFirestore().collection("notifications").add({
    userId: n.userId,
    type: n.type,
    title: n.title,
    body: n.body,
    payload: n.payload ?? {},
    isRead: false,
    createdAt: FieldValue.serverTimestamp(),
  });
}

/** Студенты курса = студенты всех групп, к которым привязан курс. */
async function studentsOfCourse(courseId: string): Promise<string[]> {
  const db = getFirestore();
  const groups = await db
    .collection("groups")
    .where("courseIds", "array-contains", courseId)
    .get();
  const set = new Set<string>();
  for (const g of groups.docs) {
    for (const s of (g.get("studentIds") as string[] | undefined) ?? []) {
      set.add(s);
    }
  }
  return [...set];
}

/** Рассылка одного уведомления всем студентам курса (батчем). */
async function notifyStudents(
  courseId: string | null | undefined,
  n: Omit<NotificationInput, "userId">
): Promise<void> {
  if (!courseId) return;
  const students = await studentsOfCourse(courseId);
  if (students.length === 0) return;
  const db = getFirestore();
  const batch = db.batch();
  for (const uid of students) {
    batch.set(db.collection("notifications").doc(), {
      userId: uid,
      type: n.type,
      title: n.title,
      body: n.body,
      payload: n.payload ?? {},
      isRead: false,
      createdAt: FieldValue.serverTimestamp(),
    });
  }
  await batch.commit();
}

/** Оценка выставлена/изменена → уведомление студенту + пересчёт сводки. */
export const onGradeNotify = onDocumentWritten(
  {document: "grades/{gradeId}", region: REGION},
  async (event) => {
    const after = event.data?.after.data();
    if (!after) return;
    const studentId = after.studentId as string | undefined;
    if (!studentId) return;

    const before = event.data?.before.data();
    const pct = Math.round(((after.percentage as number) ?? 0) * 100);
    if (!before) {
      // Новая оценка.
      await createNotification({
        userId: studentId,
        type: "gradePosted",
        title: "Выставлена оценка",
        body: `Ваш результат: ${after.score}/${after.maxScore} (${pct}%).`,
        payload: {gradeId: event.params.gradeId, courseId: after.courseId ?? null},
      });
    } else if (before.score !== after.score) {
      // Переоценка.
      await createNotification({
        userId: studentId,
        type: "gradePosted",
        title: "Оценка изменена",
        body: `Новый результат: ${after.score}/${after.maxScore} (${pct}%).`,
        payload: {gradeId: event.params.gradeId, courseId: after.courseId ?? null},
      });
    }
    await recomputeStudentSummary(studentId);
    // Денормализованные сводки курса/группы (P3-2/3).
    const courseId = after.courseId as string | undefined | null;
    if (courseId) await recomputeCourseSummary(courseId);
    const groupId = after.groupId as string | undefined | null;
    if (groupId) await recomputeGroupSummary(groupId);
  }
);

/** Публикация задания → уведомление всем студентам курса (P2-20). */
export const onAssignmentNotify = onDocumentCreated(
  {document: "assignments/{assignmentId}", region: REGION},
  async (event) => {
    const data = event.data?.data();
    if (!data || data.isPublished !== true) return;
    await notifyStudents(data.courseId as string | null, {
      type: "newAssignment",
      title: "Новое задание",
      body: `«${data.title ?? "Задание"}» доступно для выполнения.`,
      payload: {
        assignmentId: event.params.assignmentId,
        courseId: data.courseId ?? null,
      },
    });
  }
);

/** Публикация недели → уведомление студентам курса (P2-20). */
export const onWeekNotify = onDocumentCreated(
  {document: "courseWeeks/{weekId}", region: REGION},
  async (event) => {
    const data = event.data?.data();
    if (!data || data.isPublished !== true) return;
    await notifyStudents(data.courseId as string | null, {
      type: "newWeek",
      title: "Новая неделя",
      body: `Открыта неделя «${data.title ?? ""}».`,
      payload: {weekId: event.params.weekId, courseId: data.courseId ?? null},
    });
  }
);

/** Публикация квиза → уведомление студентам курса (P2-20). */
export const onQuizNotify = onDocumentCreated(
  {document: "quizzes/{quizId}", region: REGION},
  async (event) => {
    const data = event.data?.data();
    if (!data || data.isPublished !== true) return;
    await notifyStudents(data.courseId as string | null, {
      type: "newQuiz",
      title: "Новый квиз",
      body: `Доступен квиз «${data.title ?? ""}».`,
      payload: {quizId: event.params.quizId, courseId: data.courseId ?? null},
    });
  }
);

/** Возврат/отклонение работы или комментарий преподавателя → студенту (P2-20). */
export const onSubmissionNotify = onDocumentUpdated(
  {document: "submissions/{submissionId}", region: REGION},
  async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (!before || !after) return;
    const studentId = after.studentId as string | undefined;
    if (!studentId) return;

    const statusChanged = before.status !== after.status;
    if (
      statusChanged &&
      (after.status === "returned" || after.status === "rejected")
    ) {
      await createNotification({
        userId: studentId,
        type: "assignmentReturned",
        title: after.status === "returned"
          ? "Работа возвращена на доработку"
          : "Работа отклонена",
        body: (after.teacherComment as string | undefined) ??
          "Откройте задание, чтобы увидеть детали.",
        payload: {
          submissionId: event.params.submissionId,
          assignmentId: after.assignmentId ?? null,
          courseId: after.courseId ?? null,
        },
      });
    } else if (
      before.teacherComment !== after.teacherComment &&
      (after.teacherComment as string | undefined)
    ) {
      await createNotification({
        userId: studentId,
        type: "teacherComment",
        title: "Комментарий преподавателя",
        body: after.teacherComment as string,
        payload: {
          submissionId: event.params.submissionId,
          assignmentId: after.assignmentId ?? null,
          courseId: after.courseId ?? null,
        },
      });
    }
  }
);
