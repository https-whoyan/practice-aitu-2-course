import '../question_type.dart';
import 'import_issue.dart';
import 'parsed_question.dart';

/// Чистая валидация разобранного вопроса (ТЗ §5.5.11).
///
/// Возвращает список проблем (ошибки + предупреждения) с номерами строк, где
/// они доступны. Сам [ParsedQuestion] при этом не меняется — вызывающий код
/// собирает итоговые `issues` (парсер + валидатор) сам.
List<ImportIssue> validateParsed(ParsedQuestion q) {
  final issues = <ImportIssue>[];
  final f = q.fields;
  final line = q.sourceLineStart;

  final text = (f['text'] as String?)?.trim() ?? '';
  if (text.isEmpty) {
    issues.add(ImportIssue(
      code: 'no_text',
      message: 'Нет текста вопроса (QUESTION)',
      line: line,
    ));
  }

  final typeCode = (f['type'] as String?)?.trim() ?? '';
  final known = QuestionType.values.any((t) => t.code == typeCode);
  if (typeCode.isEmpty) {
    issues.add(ImportIssue(
      code: 'no_type',
      message: 'Не указан тип (TYPE)',
      line: line,
    ));
  } else if (!known) {
    issues.add(ImportIssue(
      code: 'bad_type',
      message: 'Неизвестный тип: $typeCode',
      line: line,
    ));
  } else if (!QuestionType.fromCode(typeCode).isMvp) {
    issues.add(ImportIssue(
      code: 'non_mvp_type',
      message: 'Тип "$typeCode" вне MVP — импорт может быть пропущен',
      line: line,
      isWarning: true,
    ));
  }

  final points = (f['points'] as int?) ?? 0;
  if (points <= 0) {
    issues.add(ImportIssue(
      code: 'bad_points',
      message: 'Баллы должны быть больше нуля',
      line: line,
    ));
  }

  final type = QuestionType.fromCode(typeCode);
  final options = (f['options'] as List?)?.cast<String>() ?? const <String>[];
  final needsOptions =
      type == QuestionType.single || type == QuestionType.multiple;
  if (known && needsOptions && options.isEmpty) {
    issues.add(ImportIssue(
      code: 'no_options',
      message: 'Нет вариантов ответа (OPTIONS)',
      line: line,
    ));
  }

  if (known) {
    switch (type) {
      case QuestionType.single:
        final ci = f['correctIndex'] as int?;
        if (ci == null) {
          issues.add(ImportIssue(
            code: 'no_answer',
            message: 'Не указан правильный ответ (ANSWER)',
            line: line,
          ));
        } else if (options.isNotEmpty && (ci < 0 || ci >= options.length)) {
          issues.add(ImportIssue(
            code: 'answer_range',
            message: 'Ответ вне диапазона вариантов',
            line: line,
          ));
        }
        break;
      case QuestionType.multiple:
        final cis =
            (f['correctIndexes'] as List?)?.cast<int>() ?? const <int>[];
        if (cis.isEmpty) {
          issues.add(ImportIssue(
            code: 'no_answer',
            message: 'Не указаны правильные ответы (ANSWER)',
            line: line,
          ));
        } else if (options.isNotEmpty &&
            cis.any((i) => i < 0 || i >= options.length)) {
          issues.add(ImportIssue(
            code: 'answer_range',
            message: 'Ответ вне диапазона вариантов',
            line: line,
          ));
        }
        break;
      case QuestionType.trueFalse:
        if (f['correctBool'] == null) {
          issues.add(ImportIssue(
            code: 'no_answer',
            message: 'ANSWER должен быть true/false',
            line: line,
          ));
        }
        break;
      case QuestionType.shortText:
        final accepted =
            (f['acceptedAnswers'] as List?)?.cast<String>() ?? const <String>[];
        if (accepted.isEmpty) {
          issues.add(ImportIssue(
            code: 'no_answer',
            message: 'Нет принимаемых ответов (ANSWER)',
            line: line,
          ));
        }
        break;
      default:
        break;
    }
  }

  final topic = (f['topic'] as String?)?.trim() ?? '';
  if (topic.isEmpty) {
    issues.add(ImportIssue(
      code: 'no_topic',
      message: 'Не указана тема (TOPIC)',
      line: line,
      isWarning: true,
    ));
  }

  return issues;
}

/// Нормализованный текст вопроса для сравнения дублей (§5.5.11, P2-16).
String normalizedQuestionText(ParsedQuestion q) =>
    ((q.fields['text'] as String?) ?? '')
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ');

/// Индексы вопросов-дублей: повтор текста внутри файла или совпадение с уже
/// существующими в банке (`bankTexts` — нормализованные тексты, P2-16).
Set<int> duplicateIndices(
  List<ParsedQuestion> list,
  Set<String> bankTexts,
) {
  final seen = <String>{};
  final dups = <int>{};
  for (var i = 0; i < list.length; i++) {
    final t = normalizedQuestionText(list[i]);
    if (t.isEmpty) continue;
    if (bankTexts.contains(t) || seen.contains(t)) {
      dups.add(i);
    } else {
      seen.add(t);
    }
  }
  return dups;
}

/// Сводка по разобранному списку (найдено / корректно / с ошибками).
({int found, int valid, int withErrors}) importSummary(
  List<ParsedQuestion> list,
) {
  final valid = list.where((q) => q.isValid).length;
  return (found: list.length, valid: valid, withErrors: list.length - valid);
}
