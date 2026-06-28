/// Статус задания глазами студента (ТЗ §5.6.4).
///
/// Вычисляемое представление: не хранится в Firestore, а собирается из
/// публикации задания, дедлайна и статуса отправки студента
/// (см. [computeStudentAssignmentStatus]).
enum StudentAssignmentStatus {
  notOpened('Не открыто'),
  available('Доступно'),
  submitted('Отправлено'),
  inReview('Проверяется'),
  accepted('Принято'),
  returned('Возвращено'),
  overdue('Просрочено'),
  graded('Оценено');

  const StudentAssignmentStatus(this.label);

  final String label;
}

/// Вычисляет статус задания для конкретного студента.
///
/// [submissionStatus] — это строка `SubmissionStatus.code` из фичи submissions;
/// принимается обычной `String`, чтобы фича заданий оставалась независимой.
StudentAssignmentStatus computeStudentAssignmentStatus({
  required bool isPublished,
  required DateTime? deadline,
  String? submissionStatus,
  bool hasGrade = false,
}) {
  if (!isPublished) return StudentAssignmentStatus.notOpened;
  if (hasGrade) return StudentAssignmentStatus.graded;

  switch (submissionStatus) {
    case 'submitted':
      return StudentAssignmentStatus.submitted;
    case 'inReview':
      return StudentAssignmentStatus.inReview;
    case 'returned':
      return StudentAssignmentStatus.returned;
    case 'accepted':
      return StudentAssignmentStatus.accepted;
    case 'graded':
      return StudentAssignmentStatus.graded;
  }

  if (deadline != null && deadline.isBefore(DateTime.now())) {
    return StudentAssignmentStatus.overdue;
  }
  return StudentAssignmentStatus.available;
}
