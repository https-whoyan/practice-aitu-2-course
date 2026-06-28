/**
 * Пересчёт денормализованных summary-документов (ТЗ §5.7, §10).
 *
 * Клиент читает готовую сводку, а не тысячи детальных документов (риск №3).
 * Пересчёт инкрементальный — по событиям (триггеры оценок), записывает только
 * затронутый документ. Расчёт риска/просрочек — на сервере (§5.7.3), клиент его
 * не подделывает.
 */
import {getFirestore, FieldValue, Timestamp} from "firebase-admin/firestore";

/** Порог риска по среднему проценту: <50 — высокий, <70 — средний, иначе низкий. */
function riskLevel(avgPercentage: number, overdue: number): string {
  if (avgPercentage < 0.5 || overdue >= 3) return "high";
  if (avgPercentage < 0.7 || overdue >= 1) return "medium";
  return "low";
}

/** Делит массив на части ≤30 (лимит Firestore `in`/`array-contains-any`). */
function chunk30<T>(arr: T[]): T[][] {
  const out: T[][] = [];
  for (let i = 0; i < arr.length; i += 30) out.push(arr.slice(i, i + 30));
  return out;
}

/**
 * Просрочки студента (P3-5): опубликованные задания его курсов с прошедшим
 * дедлайном, по которым нет отправки (submitted/graded/accepted). Прежняя
 * метрика (status == "returned") считала просрочки неверно.
 */
async function countOverdue(
  studentId: string,
  courseIds: string[]
): Promise<{overdue: number; upcoming: number}> {
  if (courseIds.length === 0) return {overdue: 0, upcoming: 0};
  const db = getFirestore();
  const now = Timestamp.now();
  const assignments: FirebaseFirestore.QueryDocumentSnapshot[] = [];
  for (const chunk of chunk30(courseIds)) {
    const snap = await db
      .collection("assignments")
      .where("courseId", "in", chunk)
      .where("isPublished", "==", true)
      .get();
    assignments.push(...snap.docs);
  }

  let overdue = 0;
  let upcoming = 0;
  for (const a of assignments) {
    const dl = a.get("deadline") as Timestamp | undefined | null;
    const sub = await db
      .collection("submissions")
      .doc(`${a.id}_${studentId}`)
      .get();
    const status = sub.exists ? sub.get("status") : null;
    const done =
      status === "submitted" || status === "graded" || status === "accepted";
    if (done) continue;
    if (dl?.toMillis && dl.toMillis() < now.toMillis()) {
      overdue++;
    } else if (dl?.toMillis) {
      upcoming++;
    }
  }
  return {overdue, upcoming};
}

/** Пересчитывает сводку студента из его оценок (+просрочки, P3-5). */
export async function recomputeStudentSummary(studentId: string): Promise<void> {
  const db = getFirestore();
  const grades = await db
    .collection("grades")
    .where("studentId", "==", studentId)
    .get();

  let totalPct = 0;
  let count = 0;
  let quizPct = 0;
  let quizzes = 0;
  let assignments = 0;
  for (const g of grades.docs) {
    const pct = (g.get("percentage") as number | undefined) ?? 0;
    totalPct += pct;
    count++;
    const src = g.get("sourceType");
    if (src === "quiz") {
      quizzes++;
      quizPct += pct;
    } else if (src === "assignment") {
      assignments++;
    }
  }
  const avg = count > 0 ? totalPct / count : 0;
  const avgQuiz = quizzes > 0 ? quizPct / quizzes : 0;

  const profile = await db.collection("profiles").doc(studentId).get();
  const courseIds =
    (profile.get("courseIds") as string[] | undefined) ?? [];
  const {overdue, upcoming} = await countOverdue(studentId, courseIds);

  await db.collection("studentSummaries").doc(studentId).set(
    {
      studentId,
      totalGrades: count,
      gradedQuizzes: quizzes,
      gradedAssignments: assignments,
      averagePercentage: Math.round(avg * 1000) / 1000,
      averageQuizPercentage: Math.round(avgQuiz * 1000) / 1000,
      overdueCount: overdue,
      upcomingCount: upcoming,
      riskLevel: riskLevel(avg, overdue),
      updatedAt: FieldValue.serverTimestamp(),
    },
    {merge: true}
  );
}

/**
 * Сводка по группе (P3-2): агрегирует сводки студентов группы — средний балл,
 * число студентов в зоне риска. Пишет `groupSummaries/{groupId}`.
 */
export async function recomputeGroupSummary(groupId: string): Promise<void> {
  const db = getFirestore();
  const group = await db.collection("groups").doc(groupId).get();
  if (!group.exists) return;
  const studentIds = (group.get("studentIds") as string[] | undefined) ?? [];

  let totalPct = 0;
  let withGrades = 0;
  let atRisk = 0;
  for (const sid of studentIds) {
    const s = await db.collection("studentSummaries").doc(sid).get();
    if (!s.exists) continue;
    const avg = (s.get("averagePercentage") as number | undefined) ?? 0;
    if ((s.get("totalGrades") as number | undefined) ?? 0 > 0) {
      totalPct += avg;
      withGrades++;
    }
    if (s.get("riskLevel") === "high") atRisk++;
  }

  await db.collection("groupSummaries").doc(groupId).set(
    {
      groupId,
      studentCount: studentIds.length,
      averagePercentage:
        withGrades > 0 ? Math.round((totalPct / withGrades) * 1000) / 1000 : 0,
      atRiskCount: atRisk,
      updatedAt: FieldValue.serverTimestamp(),
    },
    {merge: true}
  );
}

/**
 * Сводка по курсу (P3-3): средний балл и охват по оценкам курса. Пишет
 * `courseSummaries/{courseId}`.
 */
export async function recomputeCourseSummary(courseId: string): Promise<void> {
  const db = getFirestore();
  const grades = await db
    .collection("grades")
    .where("courseId", "==", courseId)
    .get();

  let totalPct = 0;
  const students = new Set<string>();
  for (const g of grades.docs) {
    totalPct += (g.get("percentage") as number | undefined) ?? 0;
    const sid = g.get("studentId") as string | undefined;
    if (sid) students.add(sid);
  }
  const count = grades.size;

  await db.collection("courseSummaries").doc(courseId).set(
    {
      courseId,
      gradedCount: count,
      studentCount: students.size,
      averagePercentage:
        count > 0 ? Math.round((totalPct / count) * 1000) / 1000 : 0,
      updatedAt: FieldValue.serverTimestamp(),
    },
    {merge: true}
  );
}
