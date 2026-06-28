import 'question_difficulty.dart';
import 'question_type.dart';

/// Параметры фильтрации банка вопросов (клиентская фильтрация списка).
class QuestionFilter {
  const QuestionFilter({
    this.type,
    this.difficulty,
    this.topic = '',
    this.search = '',
  });

  final QuestionType? type;
  final QuestionDifficulty? difficulty;
  final String topic;
  final String search;

  QuestionFilter copyWith({
    QuestionType? type,
    QuestionDifficulty? difficulty,
    String? topic,
    String? search,
    bool resetType = false,
    bool resetDifficulty = false,
  }) {
    return QuestionFilter(
      type: resetType ? null : (type ?? this.type),
      difficulty: resetDifficulty ? null : (difficulty ?? this.difficulty),
      topic: topic ?? this.topic,
      search: search ?? this.search,
    );
  }
}
