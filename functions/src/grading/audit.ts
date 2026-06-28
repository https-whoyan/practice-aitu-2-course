/**
 * Журналирование изменений оценок (ТЗ §8.6, §5.4.7).
 *
 * Оценки пишет преподаватель с клиента (правила ограничивают своими курсами),
 * а аудит критичного действия делает сервер — триггер на запись в `grades`
 * фиксирует кто/когда/прежнее→новое значение в `auditLogs`.
 */
import {onDocumentWritten} from "firebase-functions/v2/firestore";

import {REGION} from "../lib/region";
import {writeAuditLog} from "../lib/audit";

export const onGradeWritten = onDocumentWritten(
  {document: "grades/{gradeId}", region: REGION},
  async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();

    // Удаление оценок не предусмотрено (мягкая модель) — игнорируем.
    if (!after) return;

    const actionType = before ? "updateGrade" : "createGrade";
    const teacherId = (after.teacherId as string | undefined) ?? "system";
    // Авто-оценки (квизы) ставит сервер, ручные — преподаватель (P5).
    const role = after.auto === true ? "system" : "teacher";

    await writeAuditLog({
      userId: teacherId,
      role,
      actionType,
      entityType: "grade",
      entityId: event.params.gradeId,
      oldValue: before
        ? {score: before.score ?? null, comment: before.comment ?? null}
        : null,
      newValue: {score: after.score ?? null, comment: after.comment ?? null},
    });
  }
);
