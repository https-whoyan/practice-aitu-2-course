// Утилиты разбора ссылок YouTube (ТЗ §7.6).
//
// Чистые функции без зависимостей — используются и в форме (валидация), и
// при рендере (получение videoId для плеера).

final RegExp _idPattern = RegExp(r'^[A-Za-z0-9_-]{11}$');

/// Извлекает 11-символьный videoId из ссылки YouTube, иначе `null`.
///
/// Поддерживает форматы: `youtu.be/ID`, `youtube.com/watch?v=ID`,
/// `youtube.com/embed/ID`, `youtube.com/shorts/ID`.
String? extractYoutubeId(String url) {
  final trimmed = url.trim();
  if (trimmed.isEmpty) return null;

  final uri = Uri.tryParse(trimmed);
  if (uri == null) return null;

  final host = uri.host.toLowerCase();

  // youtu.be/ID
  if (host.endsWith('youtu.be')) {
    final id = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';
    return _idPattern.hasMatch(id) ? id : null;
  }

  if (host.endsWith('youtube.com') || host.endsWith('youtube-nocookie.com')) {
    // youtube.com/watch?v=ID
    final queryId = uri.queryParameters['v'];
    if (queryId != null && _idPattern.hasMatch(queryId)) return queryId;

    // /embed/ID, /shorts/ID, /v/ID
    final segments = uri.pathSegments;
    if (segments.length >= 2 &&
        {'embed', 'shorts', 'v'}.contains(segments[0])) {
      final id = segments[1];
      return _idPattern.hasMatch(id) ? id : null;
    }
  }

  return null;
}

/// `true`, если из ссылки удаётся извлечь корректный videoId.
bool isValidYoutubeUrl(String url) => extractYoutubeId(url) != null;
