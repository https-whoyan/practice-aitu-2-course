import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// Тип in-app уведомления (коллекция `notifications`, пишет Cloud Functions).
///
/// Сервер сейчас эмитит только `gradePosted` и `assignmentPublished`; остальные
/// коды объявлены заранее под будущие триггеры. `@JsonValue` = имя значения.
enum NotificationType {
  @JsonValue('newCourse')
  newCourse('Новый курс', Icons.school),
  @JsonValue('newWeek')
  newWeek('Новая неделя', Icons.calendar_view_week),
  @JsonValue('newAssignment')
  newAssignment('Новое задание', Icons.assignment),
  @JsonValue('newQuiz')
  newQuiz('Новый тест', Icons.quiz),
  @JsonValue('deadlineSoon')
  deadlineSoon('Скоро дедлайн', Icons.schedule),
  @JsonValue('deadlineOverdue')
  deadlineOverdue('Дедлайн просрочен', Icons.event_busy),
  @JsonValue('gradePosted')
  gradePosted('Выставлена оценка', Icons.grade),
  @JsonValue('assignmentReturned')
  assignmentReturned('Работа возвращена', Icons.assignment_return),
  @JsonValue('teacherComment')
  teacherComment('Комментарий преподавателя', Icons.comment),
  @JsonValue('assignmentPublished')
  assignmentPublished('Задание опубликовано', Icons.assignment),
  @JsonValue('system')
  system('Системное', Icons.info_outline);

  const NotificationType(this.label, this.icon);

  /// Короткая русская подпись типа.
  final String label;

  /// Иконка для строки уведомления.
  final IconData icon;

  /// Код типа из документа Firestore → значение enum. Неизвестный → [system].
  static NotificationType fromCode(String? code) => NotificationType.values
      .firstWhere((t) => t.name == code, orElse: () => NotificationType.system);
}
