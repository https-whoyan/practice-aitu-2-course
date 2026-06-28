import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// Тип учебного материала (ТЗ §7.6).
///
/// Определяет, как материал хранится и отображается студенту: текст/ссылка
/// рендерятся inline, файловые типы открываются по `fileUrl`, YouTube — во
/// встроенном плеере. Геттер [isFileBased] управляет показом загрузчика файла
/// в форме, [icon] — иконкой в списках.
enum CourseMaterialType {
  @JsonValue('text')
  text('text', 'Текст'),
  @JsonValue('link')
  link('link', 'Ссылка'),
  @JsonValue('youtube')
  youtube('youtube', 'YouTube'),
  @JsonValue('file')
  file('file', 'Файл'),
  @JsonValue('presentation')
  presentation('presentation', 'Презентация'),
  @JsonValue('pdf')
  pdf('pdf', 'PDF'),
  @JsonValue('image')
  image('image', 'Изображение');

  const CourseMaterialType(this.code, this.label);

  final String code;
  final String label;

  static CourseMaterialType fromCode(String? code) => CourseMaterialType.values.firstWhere(
        (t) => t.code == code,
        orElse: () => CourseMaterialType.text,
      );

  /// Файловые типы — для них в форме показывается загрузка файла в Storage.
  bool get isFileBased =>
      {file, presentation, pdf, image}.contains(this);

  /// Иконка типа для списков/карточек.
  IconData get icon {
    switch (this) {
      case CourseMaterialType.text:
        return Icons.notes;
      case CourseMaterialType.link:
        return Icons.link;
      case CourseMaterialType.youtube:
        return Icons.smart_display;
      case CourseMaterialType.file:
        return Icons.insert_drive_file;
      case CourseMaterialType.presentation:
        return Icons.slideshow;
      case CourseMaterialType.pdf:
        return Icons.picture_as_pdf;
      case CourseMaterialType.image:
        return Icons.image;
    }
  }
}
