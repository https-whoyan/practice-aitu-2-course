import 'package:freezed_annotation/freezed_annotation.dart';

import 'import_issue.dart';

part 'parsed_question.freezed.dart';

/// Результат разбора одного блока TXT-импорта.
///
/// [fields] хранит уже приведённые плоские поля вопроса с теми же ключами, что
/// и `questionBank` (text, type, topic, difficulty, points, options,
/// correctIndex, correctIndexes, correctBool, acceptedAnswers, tags,
/// explanation). [issues] — проблемы разбора/валидации; [isValid] — нет ли
/// блокирующих ошибок.
@freezed
abstract class ParsedQuestion with _$ParsedQuestion {
  const ParsedQuestion._();

  const factory ParsedQuestion({
    required Map<String, dynamic> fields,
    required int sourceLineStart,
    @Default(<ImportIssue>[]) List<ImportIssue> issues,
  }) = _ParsedQuestion;

  bool get isValid => issues.where((i) => !i.isWarning).isEmpty;
}
