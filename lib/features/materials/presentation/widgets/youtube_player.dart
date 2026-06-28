import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../theme/app_spacing.dart';

/// Просмотр YouTube-видео внутри карточки материала.
///
/// Принимает уже извлечённый [videoId] (см. `youtube_utils.dart`): показывает
/// превью-кадр с кнопкой воспроизведения и открывает видео по тапу.
///
/// Заметка: полноценный встроенный iframe-плеер (`youtube_player_iframe`) даёт
/// dot-shorthand в публичном API, на котором падает analyzer, привязанный к
/// build_runner (см. dev-runbook). До обновления тулчейна используем
/// кросс-платформенный превью+открытие; точка интеграции плеера — здесь.
class InAppYoutubePlayer extends StatelessWidget {
  const InAppYoutubePlayer({super.key, required this.videoId});

  final String videoId;

  Future<void> _open() async {
    final uri = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: InkWell(
        onTap: _open,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, _, _) => ColoredBox(
                  color: colors.surfaceContainerHighest,
                  child: Icon(Icons.smart_display,
                      size: 48, color: colors.onSurfaceVariant),
                ),
              ),
              const ColoredBox(color: Color(0x33000000)),
              const Center(
                child: Icon(Icons.play_circle_fill,
                    size: 64, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
