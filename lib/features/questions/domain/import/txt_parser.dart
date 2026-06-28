import 'import_issue.dart';
import 'parsed_question.dart';

/// Чистый парсер TXT-формата банка вопросов (ТЗ §5.5.11).
///
/// Формат: вопросы разделены пустой строкой. В блоке — строки вида `KEY:` с
/// последующим значением (значение может занимать несколько строк до
/// следующего ключа). Поддерживаемые ключи: QUESTION, TYPE, TOPIC, DIFFICULTY,
/// POINTS, OPTIONS, ANSWER, EXPLANATION, TAGS. Ключи PAIRS/CATEGORIES/ITEMS/
/// ORDER относятся к типам вне MVP и помечаются предупреждением.
///
/// Без зависимостей от Firebase/домена — результат пригоден для unit-тестов.

const Set<String> _knownKeys = <String>{
  'QUESTION',
  'TYPE',
  'TOPIC',
  'DIFFICULTY',
  'POINTS',
  'OPTIONS',
  'ANSWER',
  'EXPLANATION',
  'TAGS',
  'PAIRS',
  'CATEGORIES',
  'ITEMS',
  'ORDER',
};

const Set<String> _nonMvpKeys = <String>{
  'PAIRS',
  'CATEGORIES',
  'ITEMS',
  'ORDER',
};

/// Нормализация TYPE → канонический код [QuestionType.code] без импорта домена.
const Map<String, String> _typeCodes = <String, String>{
  'single': 'single',
  'multiple': 'multiple',
  'truefalse': 'trueFalse',
  'shorttext': 'shortText',
  'matching': 'matching',
  'dragdrop': 'dragDrop',
  'ordering': 'ordering',
  'fillblank': 'fillBlank',
  'numeric': 'numeric',
  'image': 'image',
  'code': 'code',
  'multicategory': 'multiCategory',
};

const Map<String, String> _difficultyCodes = <String, String>{
  'basic': 'basic',
  'medium': 'medium',
  'hard': 'hard',
  'базовый': 'basic',
  'средний': 'medium',
  'сложный': 'hard',
};

List<ParsedQuestion> parseQuestionsTxt(String input) {
  final lines =
      input.replaceAll('\r\n', '\n').replaceAll('\r', '\n').split('\n');

  // Группируем непустые строки в блоки, разделённые пустыми строками.
  final blocks = <List<_Line>>[];
  var current = <_Line>[];
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.trim().isEmpty) {
      if (current.isNotEmpty) {
        blocks.add(current);
        current = <_Line>[];
      }
    } else {
      current.add(_Line(i + 1, line));
    }
  }
  if (current.isNotEmpty) blocks.add(current);

  return blocks.map(_parseBlock).toList();
}

class _Line {
  const _Line(this.number, this.text);
  final int number;
  final String text;
}

final RegExp _keyLine = RegExp(r'^\s*([A-Za-z]+)\s*:(.*)$');
final RegExp _optionPrefix = RegExp(r'^\s*[A-Za-z]\s*[).]\s*');

ParsedQuestion _parseBlock(List<_Line> block) {
  final values = <String, List<String>>{};
  final keyLineNo = <String, int>{};
  final issues = <ImportIssue>[];

  String? currentKey;
  for (final line in block) {
    final match = _keyLine.firstMatch(line.text);
    final maybeKey = match?.group(1)?.toUpperCase();
    if (match != null && maybeKey != null && _knownKeys.contains(maybeKey)) {
      currentKey = maybeKey;
      keyLineNo.putIfAbsent(currentKey, () => line.number);
      values.putIfAbsent(currentKey, () => <String>[]);
      final rest = match.group(2)!.trim();
      if (rest.isNotEmpty) values[currentKey]!.add(rest);
    } else if (currentKey != null) {
      values[currentKey]!.add(line.text.trim());
    } else {
      // Текст до первого ключа считаем телом вопроса.
      currentKey = 'QUESTION';
      values.putIfAbsent('QUESTION', () => <String>[]);
      keyLineNo.putIfAbsent('QUESTION', () => line.number);
      values['QUESTION']!.add(line.text.trim());
    }
  }

  String joined(String key) => (values[key] ?? const <String>[]).join(' ').trim();

  final text = (values['QUESTION'] ?? const <String>[]).join('\n').trim();
  final typeRaw = joined('TYPE');
  final typeCode = _typeCodes[typeRaw.toLowerCase()] ?? typeRaw;
  final topic = joined('TOPIC');
  final difficultyRaw = joined('DIFFICULTY').toLowerCase();
  final difficulty = _difficultyCodes[difficultyRaw] ??
      (difficultyRaw.isEmpty ? 'basic' : difficultyRaw);
  final points = int.tryParse(joined('POINTS')) ?? 1;
  final explanation = (values['EXPLANATION'] ?? const <String>[]).join('\n').trim();

  final options = <String>[];
  for (final raw in values['OPTIONS'] ?? const <String>[]) {
    final stripped = raw.replaceFirst(_optionPrefix, '').trim();
    if (stripped.isNotEmpty) options.add(stripped);
  }

  final tags = <String>[];
  for (final part in joined('TAGS').split(',')) {
    final t = part.trim();
    if (t.isNotEmpty) tags.add(t);
  }

  // ANSWER зависит от типа.
  final answerRaw = joined('ANSWER');
  int? correctIndex;
  final correctIndexes = <int>[];
  bool? correctBool;
  final acceptedAnswers = <String>[];
  switch (typeCode.toLowerCase()) {
    case 'single':
      if (answerRaw.isNotEmpty) correctIndex = _answerIndex(answerRaw);
      break;
    case 'multiple':
      for (final token in answerRaw.split(',')) {
        final idx = _answerIndex(token.trim());
        if (idx != null) correctIndexes.add(idx);
      }
      break;
    case 'truefalse':
      final a = answerRaw.toLowerCase();
      if (a == 'true' || a == 'верно') {
        correctBool = true;
      } else if (a == 'false' || a == 'неверно') {
        correctBool = false;
      }
      break;
    case 'shorttext':
      for (final part in answerRaw.split('|')) {
        final t = part.trim();
        if (t.isNotEmpty) acceptedAnswers.add(t);
      }
      break;
    default:
      break;
  }

  for (final key in _nonMvpKeys) {
    if (values.containsKey(key)) {
      issues.add(ImportIssue(
        code: 'non_mvp_key',
        message: 'Поле "$key" относится к типу вне MVP — будет проигнорировано',
        line: keyLineNo[key],
        isWarning: true,
      ));
    }
  }

  final fields = <String, dynamic>{
    'text': text,
    'type': typeCode,
    'topic': topic,
    'difficulty': difficulty,
    'points': points,
    'options': options,
    'correctIndex': correctIndex,
    'correctIndexes': correctIndexes,
    'correctBool': correctBool,
    'acceptedAnswers': acceptedAnswers,
    'tags': tags,
    'explanation': explanation,
  };

  return ParsedQuestion(
    fields: fields,
    sourceLineStart: block.first.number,
    issues: issues,
  );
}

/// 'A'→0, 'B'→1 … либо число '1'→0. null — нераспознанный ответ.
int? _answerIndex(String value) {
  final t = value.trim();
  if (t.isEmpty) return null;
  final c = t[0].toUpperCase();
  final code = c.codeUnitAt(0);
  if (code >= 65 && code <= 90) return code - 65;
  final n = int.tryParse(t);
  if (n != null && n > 0) return n - 1;
  return null;
}
