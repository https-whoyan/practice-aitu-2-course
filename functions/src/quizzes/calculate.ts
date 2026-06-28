/**
 * Расчёт результата попытки квиза (ТЗ §9, §8.5, §5.5.4). Только сервер.
 *
 * Триггер на переходе `quizAttempts.status: inProgress → submitted`. Сверяет
 * ответы с эталоном из questionBank (по снапшоту, с учётом перемешивания),
 * считает балл, пишет результат в попытку, создаёт Grade (sourceType: quiz),
 * раскрывает правильные ответы строго по `showResultMode`. Идемпотентно.
 */
import {onDocumentUpdated} from "firebase-functions/v2/firestore";
import {getFirestore, FieldValue, Timestamp} from "firebase-admin/firestore";

import {REGION} from "../lib/region";
import {writeAuditLog} from "../lib/audit";
import {scoreQuestion, SnapshotItem, BankAnswer} from "./scoring";

export const calculateQuizResult = onDocumentUpdated(
  {document: "quizAttempts/{attemptId}", region: REGION},
  async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (!before || !after) return;

    // Только переход в submitted и ещё не оценено (идемпотентность §8.5).
    if (after.status !== "submitted") return;
    if (before.status === "submitted") return; // уже обрабатывали
    if (after.status === "graded") return;

    const db = getFirestore();
    const attemptRef = event.data!.after.ref;
    const snapshot = (after.questionSnapshot ?? []) as SnapshotItem[];
    const answers = (after.answers ?? {}) as Record<string, unknown>;

    // Настройки квиза нужны и для дедлайна/лимита (P0-2), и для раскрытия ответов.
    const quizSnap = await db.collection("quizzes").doc(after.quizId).get();

    // P0-2: дедлайн и лимит времени проверяем на сервере (§8.5 п.7). finishedAt
    // фиксируется серверным временем (гарантируется правилом quizAttempts).
    // Небольшой допуск GRACE_MS — на сетевую задержку финальной записи.
    const GRACE_MS = 5000;
    const startedAt = after.startedAt as Timestamp | null | undefined;
    const finishedAt = after.finishedAt as Timestamp | null | undefined;
    const deadline = quizSnap.get("deadline") as Timestamp | null | undefined;
    const timeLimitMinutes =
      quizSnap.get("timeLimitMinutes") as number | null | undefined;
    const finishedMs = finishedAt?.toMillis ? finishedAt.toMillis() : null;
    let invalidReason: string | null = null;
    if (finishedMs != null && deadline?.toMillis &&
        finishedMs > deadline.toMillis() + GRACE_MS) {
      invalidReason = "deadline";
    } else if (
      finishedMs != null && startedAt?.toMillis && timeLimitMinutes &&
      finishedMs - startedAt.toMillis() > timeLimitMinutes * 60000 + GRACE_MS
    ) {
      invalidReason = "timeLimit";
    }

    // Эталонные ответы из questionBank (клиент их не видит).
    const bankById = new Map<string, BankAnswer>();
    await Promise.all(
      snapshot.map(async (item) => {
        const s = await db.collection("questionBank").doc(item.questionId).get();
        if (s.exists) {
          const d = s.data()!;
          bankById.set(item.questionId, {
            type: d.type,
            correctIndex: d.correctIndex ?? null,
            correctIndexes: d.correctIndexes ?? [],
            correctBool: d.correctBool ?? null,
            acceptedAnswers: d.acceptedAnswers ?? [],
            caseSensitive: d.caseSensitive ?? false,
            partialScoring: d.partialScoring ?? false,
          });
        }
      })
    );

    let score = 0;
    let maxScore = 0;
    for (const item of snapshot) {
      maxScore += item.points ?? 0;
      const bank = bankById.get(item.questionId);
      if (!bank) continue;
      score += scoreQuestion(item, bank, answers[item.questionId]);
    }
    // Просрочка/превышение лимита — попытка не засчитывается (балл 0, §8.5 п.7).
    if (invalidReason) score = 0;
    score = Math.round(score * 100) / 100;
    const percentage = maxScore > 0 ? score / maxScore : 0;

    // Раскрытие по showResultMode (читаем из квиза).
    const showMode = (quizSnap.get("showResultMode") as string) ?? "scoreOnly";

    const update: Record<string, unknown> = {
      score,
      maxScore,
      percentage,
      status: "graded",
      invalidReason,
      gradedAt: FieldValue.serverTimestamp(),
    };

    if (showMode === "scoreAndAnswers" || showMode === "scoreAnswersExplanations") {
      const reveal: Record<string, unknown> = {};
      for (const item of snapshot) {
        const s = await db.collection("questionBank").doc(item.questionId).get();
        if (!s.exists) continue;
        const d = s.data()!;
        reveal[item.questionId] = {
          correctIndex: d.correctIndex ?? null,
          correctIndexes: d.correctIndexes ?? [],
          correctBool: d.correctBool ?? null,
          acceptedAnswers: d.acceptedAnswers ?? [],
          explanation:
            showMode === "scoreAnswersExplanations" ? d.explanation ?? "" : null,
        };
      }
      update.revealed = reveal;
    }

    // Транзакционная запись результата + создание Grade (sourceType quiz).
    const gradeId = `quiz_${event.params.attemptId}`;
    const gradeRef = db.collection("grades").doc(gradeId);
    const batch = db.batch();
    batch.update(attemptRef, update);
    batch.set(gradeRef, {
      studentId: after.studentId,
      teacherId: quizSnap.get("ownerTeacherId") ?? "system",
      courseId: after.courseId ?? null,
      groupId: null,
      sourceType: "quiz",
      sourceId: after.quizId,
      score,
      maxScore,
      percentage,
      comment: null,
      auto: true,
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
      history: [],
    });
    await batch.commit();

    await writeAuditLog({
      userId: after.studentId,
      role: "student",
      actionType: "quiz.calculate",
      entityType: "quizAttempt",
      entityId: event.params.attemptId,
      newValue: {score, maxScore, invalidReason},
    });
  }
);
