/**
 * Старт попытки квиза (ТЗ §5.5.17, §8.5). Только сервер.
 *
 * Формирует снапшот выданных вопросов БЕЗ правильных ответов, фиксирует
 * `startedAt` серверным временем, проверяет доступность квиза и лимит попыток,
 * применяет перемешивание. Возвращает attemptId — снапшот клиент читает из дока.
 */
import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue, Timestamp} from "firebase-admin/firestore";

import {FUNCTION_OPTS} from "../lib/region";
import {assertSignedIn} from "../lib/auth";

/** Перемешивание Фишера–Йетса по детерминированному сиду (для воспроизводимости). */
function shuffle<T>(arr: T[], seed: number): T[] {
  const a = [...arr];
  let s = seed % 2147483647;
  if (s <= 0) s += 2147483646;
  const rnd = (): number => (s = (s * 16807) % 2147483647) / 2147483647;
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(rnd() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

interface BankDoc {
  text: string;
  type: string;
  topic?: string;
  difficulty?: string;
  points?: number;
  options?: string[];
  status?: string;
  ownerTeacherId?: string;
}

export const startQuizAttempt = onCall(FUNCTION_OPTS, async (request) => {
  const uid = assertSignedIn(request);
  const data = (request.data ?? {}) as {quizId?: string};
  const quizId = data.quizId;
  if (!quizId) throw new HttpsError("invalid-argument", "Не указан квиз.");

  const db = getFirestore();
  const quizSnap = await db.collection("quizzes").doc(quizId).get();
  if (!quizSnap.exists) throw new HttpsError("not-found", "Квиз не найден.");
  const quiz = quizSnap.data()!;

  // Доступность (§8.5 п.8): опубликован и в окне дат.
  if (quiz.isPublished !== true) {
    throw new HttpsError("failed-precondition", "Квиз не опубликован.");
  }
  const now = Timestamp.now();
  const startDate = quiz.startDate as Timestamp | undefined;
  const deadline = quiz.deadline as Timestamp | undefined;
  if (startDate && now.toMillis() < startDate.toMillis()) {
    throw new HttpsError("failed-precondition", "Квиз ещё не начался.");
  }
  if (deadline && now.toMillis() >= deadline.toMillis()) {
    throw new HttpsError("failed-precondition", "Срок прохождения истёк.");
  }

  // Лимит попыток (§8.5 п.2).
  const prior = await db
    .collection("quizAttempts")
    .where("quizId", "==", quizId)
    .where("studentId", "==", uid)
    .get();
  const attemptsAllowed = (quiz.attemptsAllowed as number | undefined) ?? 1;
  const used = prior.docs.filter((d) => d.get("status") !== "expired").length;
  if (used >= attemptsAllowed) {
    throw new HttpsError("failed-precondition", "Исчерпан лимит попыток.");
  }

  // Активная попытка (§11): продолжаем существующую inProgress.
  const active = prior.docs.find((d) => d.get("status") === "inProgress");
  if (active) {
    return {attemptId: active.id, resumed: true};
  }

  // Выбор пула вопросов: ручной questionIds, иначе рандомайзер по банку.
  const manualIds = (quiz.questionIds as string[] | undefined) ?? [];
  const rnd = (quiz.randomizerSettings ?? {}) as Record<string, unknown>;
  const seed = now.toMillis() ^ hashCode(uid);

  let bankDocs: {id: string; data: BankDoc}[] = [];
  if (manualIds.length > 0) {
    const reads = await Promise.all(
      manualIds.slice(0, 200).map((id) =>
        db.collection("questionBank").doc(id).get()
      )
    );
    bankDocs = reads
      .filter((s) => s.exists)
      .map((s) => ({id: s.id, data: s.data() as BankDoc}));
  } else {
    // Рандомайзер (MVP): берём активные вопросы владельца по курсу.
    const owner = quiz.ownerTeacherId ?? quiz.createdBy;
    let query = db
      .collection("questionBank")
      .where("status", "==", "active") as FirebaseFirestore.Query;
    if (owner) query = query.where("ownerTeacherId", "==", owner);
    const all = await query.get();
    let pool = all.docs.map((s) => ({id: s.id, data: s.data() as BankDoc}));
    const total = (rnd.totalQuestions as number | undefined) ?? pool.length;
    pool = shuffle(pool, seed);
    bankDocs = pool.slice(0, total);
  }

  if (bankDocs.length === 0) {
    throw new HttpsError("failed-precondition", "В квизе нет вопросов.");
  }

  if (rnd.shuffleQuestions === true) {
    bankDocs = shuffle(bankDocs, seed + 1);
  }

  // Снапшот БЕЗ правильных ответов (§8.5 п.1, п.5).
  const shuffleOptions = rnd.shuffleOptions === true;
  const snapshot = bankDocs.map((b, idx) => {
    const opts = b.data.options ?? [];
    let optionOrder = opts.map((_, i) => i);
    if (shuffleOptions && opts.length > 0) {
      optionOrder = shuffle(optionOrder, seed + 100 + idx);
    }
    const displayedOptions = optionOrder.map((i) => opts[i]);
    return {
      questionId: b.id,
      text: b.data.text,
      type: b.data.type,
      options: displayedOptions,
      optionOrder,
      points: b.data.points ?? 1,
    };
  });

  const maxScore = snapshot.reduce((s, q) => s + (q.points ?? 0), 0);

  const ref = db.collection("quizAttempts").doc();
  await ref.set({
    quizId,
    studentId: uid,
    courseId: quiz.courseId ?? null,
    questionSnapshot: snapshot,
    answers: {},
    startedAt: FieldValue.serverTimestamp(),
    finishedAt: null,
    score: null,
    maxScore,
    percentage: null,
    status: "inProgress",
    attemptNumber: used + 1,
  });

  return {attemptId: ref.id, resumed: false};
});

function hashCode(s: string): number {
  let h = 0;
  for (let i = 0; i < s.length; i++) {
    h = (Math.imul(31, h) + s.charCodeAt(i)) | 0;
  }
  return Math.abs(h);
}
