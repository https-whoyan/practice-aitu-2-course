/**
 * Импорт вопросов из подтверждённого предпросмотра (ТЗ §5.5.10–5.5.11, §9, §17.3).
 *
 * Клиент парсит/валидирует TXT и показывает предпросмотр; сюда приходит МАССИВ
 * уже подтверждённых вопросов. Сервер — авторитетная граница: повторно проверяет
 * базовую корректность, фиксирует владельца, пишет `questionBank` батчем и аудит.
 *
 * Схема документа questionBank (плоская, согласована с клиентом и со scoring):
 *   ownerTeacherId, courseIds[], text, type, topic, tags[], difficulty, points,
 *   explanation, status, options[], correctIndex, correctIndexes[], correctBool,
 *   acceptedAnswers[], caseSensitive, partialScoring, createdAt, updatedAt
 */
import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue} from "firebase-admin/firestore";

import {FUNCTION_OPTS} from "../lib/region";
import {assertTeacher} from "../lib/auth";
import {writeAuditLog} from "../lib/audit";

const MVP_TYPES = ["single", "multiple", "trueFalse", "shortText"];
const DIFFICULTIES = ["basic", "medium", "hard"];

interface IncomingQuestion {
  text?: string;
  type?: string;
  topic?: string;
  tags?: string[];
  difficulty?: string;
  points?: number;
  explanation?: string;
  options?: string[];
  correctIndex?: number | null;
  correctIndexes?: number[] | null;
  correctBool?: boolean | null;
  acceptedAnswers?: string[] | null;
  caseSensitive?: boolean;
  partialScoring?: boolean;
  courseIds?: string[];
}

/** Минимальная серверная валидация (зеркало клиентского валидатора §5.5.11). */
function validate(q: IncomingQuestion): string | null {
  if (!q.text || q.text.trim().length === 0) return "пустой текст вопроса";
  if (!q.type || !MVP_TYPES.includes(q.type)) return `тип вне MVP: ${q.type}`;
  if (typeof q.points !== "number" || q.points <= 0) return "баллы должны быть > 0";
  if (q.difficulty && !DIFFICULTIES.includes(q.difficulty)) {
    return `сложность: ${q.difficulty}`;
  }
  switch (q.type) {
    case "single":
      if (!q.options || q.options.length < 2) return "нужны варианты (options)";
      if (typeof q.correctIndex !== "number") return "нет correctIndex";
      break;
    case "multiple":
      if (!q.options || q.options.length < 2) return "нужны варианты (options)";
      if (!q.correctIndexes || q.correctIndexes.length === 0) {
        return "нет correctIndexes";
      }
      break;
    case "trueFalse":
      if (typeof q.correctBool !== "boolean") return "нет correctBool";
      break;
    case "shortText":
      if (!q.acceptedAnswers || q.acceptedAnswers.length === 0) {
        return "нет acceptedAnswers";
      }
      break;
  }
  return null;
}

export const importQuestions = onCall(FUNCTION_OPTS, async (request) => {
  const uid = assertTeacher(request);
  const data = (request.data ?? {}) as {questions?: IncomingQuestion[]};
  const items = data.questions;
  if (!Array.isArray(items) || items.length === 0) {
    throw new HttpsError("invalid-argument", "Нет вопросов для импорта.");
  }
  if (items.length > 500) {
    throw new HttpsError("invalid-argument", "Слишком большой импорт (>500).");
  }

  const db = getFirestore();
  const batch = db.batch();
  const errors: {index: number; reason: string}[] = [];
  let written = 0;

  items.forEach((q, index) => {
    const err = validate(q);
    if (err) {
      errors.push({index, reason: err});
      return;
    }
    const ref = db.collection("questionBank").doc();
    batch.set(ref, {
      ownerTeacherId: uid,
      courseIds: Array.isArray(q.courseIds) ? q.courseIds : [],
      text: q.text!.trim(),
      type: q.type,
      topic: q.topic ?? "",
      tags: Array.isArray(q.tags) ? q.tags : [],
      difficulty: q.difficulty ?? "basic",
      points: q.points,
      explanation: q.explanation ?? "",
      status: "active",
      options: q.options ?? [],
      correctIndex: q.correctIndex ?? null,
      correctIndexes: q.correctIndexes ?? [],
      correctBool: q.correctBool ?? null,
      acceptedAnswers: q.acceptedAnswers ?? [],
      caseSensitive: q.caseSensitive ?? false,
      partialScoring: q.partialScoring ?? false,
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
    });
    written++;
  });

  if (written === 0) {
    throw new HttpsError(
      "failed-precondition",
      `Ни один вопрос не прошёл валидацию (${errors.length} с ошибками).`
    );
  }

  await batch.commit();
  await writeAuditLog({
    userId: uid,
    role: "teacher",
    actionType: "questions.import",
    entityType: "questionBank",
    entityId: "batch",
    newValue: {written, skipped: errors.length},
  });

  return {written, skipped: errors.length, errors};
});
