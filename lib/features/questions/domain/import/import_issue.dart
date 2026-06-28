import 'package:freezed_annotation/freezed_annotation.dart';

part 'import_issue.freezed.dart';

/// Одна проблема, найденная при разборе/валидации TXT-импорта (ТЗ §5.5.11).
///
/// [isWarning] = true — нестрогая проблема (вопрос всё ещё импортируем,
/// например тип вне MVP или пустая тема). Иначе — ошибка, блокирующая импорт.
@freezed
abstract class ImportIssue with _$ImportIssue {
  const factory ImportIssue({
    @Default('') String code,
    @Default('') String message,
    int? line,
    @Default(false) bool isWarning,
  }) = _ImportIssue;
}
