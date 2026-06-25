import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// Конвертер `Timestamp ↔ DateTime` для freezed/json_serializable моделей.
///
/// Firestore хранит даты как [Timestamp]; в моделях удобнее [DateTime].
/// Использование: `@TimestampConverter()` над полем модели.
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  // Нормализуем в UTC: храним и сравниваем время единообразно
  // (`Timestamp.toDate()` иначе возвращает локальное время).
  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate().toUtc();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

/// Версия конвертера для nullable-полей (`DateTime?`).
class NullableTimestampConverter
    implements JsonConverter<DateTime?, Timestamp?> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) => timestamp?.toDate().toUtc();

  @override
  Timestamp? toJson(DateTime? date) =>
      date == null ? null : Timestamp.fromDate(date);
}
