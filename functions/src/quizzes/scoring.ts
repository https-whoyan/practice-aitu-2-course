/**
 * Сверка ответов студента с эталоном из questionBank (ТЗ §5.5.4, §8.5).
 *
 * Только сервер. `answers` индексируют ПЕРЕМЕШАННЫЙ снапшот (позиции показа);
 * `optionOrder[pos]` даёт исходный индекс варианта в questionBank, по которому
 * и сверяется правильность. Поддерживаются 4 MVP-типа; прочие — ручная проверка.
 */
export interface SnapshotItem {
  questionId: string;
  type: string;
  points: number;
  optionOrder?: number[];
}

export interface BankAnswer {
  type: string;
  correctIndex?: number | null;
  correctIndexes?: number[] | null;
  correctBool?: boolean | null;
  acceptedAnswers?: string[] | null;
  caseSensitive?: boolean;
  partialScoring?: boolean;
}

/** Балл за один вопрос. Возвращает число в [0, points]. */
export function scoreQuestion(
  item: SnapshotItem,
  bank: BankAnswer,
  answer: unknown
): number {
  const points = item.points ?? 0;
  const order = item.optionOrder ?? [];
  const toOriginal = (pos: number): number =>
    pos >= 0 && pos < order.length ? order[pos] : pos;

  switch (bank.type) {
    case "single": {
      if (typeof answer !== "number") return 0;
      return toOriginal(answer) === bank.correctIndex ? points : 0;
    }
    case "trueFalse": {
      if (typeof answer !== "boolean") return 0;
      return answer === bank.correctBool ? points : 0;
    }
    case "multiple": {
      if (!Array.isArray(answer)) return 0;
      const correct = new Set(bank.correctIndexes ?? []);
      const chosen = new Set(
        answer.filter((x) => typeof x === "number").map((x) => toOriginal(x as number))
      );
      const totalCorrect = correct.size;
      if (totalCorrect === 0) return 0;

      // Полный балл — точное совпадение множеств.
      const exact =
        chosen.size === correct.size &&
        [...chosen].every((x) => correct.has(x));
      if (exact) return points;

      if (!bank.partialScoring) return 0;

      // Частичный балл (§5.5.4): (верные − неверные) / всего верных, ≥ 0.
      let right = 0;
      let wrong = 0;
      for (const x of chosen) {
        if (correct.has(x)) right++;
        else wrong++;
      }
      const fraction = Math.max(0, (right - wrong) / totalCorrect);
      return Math.round(points * fraction * 100) / 100;
    }
    case "shortText": {
      if (typeof answer !== "string") return 0;
      const norm = (s: string): string =>
        bank.caseSensitive ? s.trim() : s.trim().toLowerCase();
      const given = norm(answer);
      const accepted = (bank.acceptedAnswers ?? []).map(norm);
      return accepted.includes(given) ? points : 0;
    }
    default:
      // Типы вне MVP — авто-балл не начисляется (требуют ручной проверки).
      return 0;
  }
}
