import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../theme/app_spacing.dart';
import '../../domain/material.dart';
import '../../domain/material_type.dart';
import '../../domain/youtube_utils.dart';
import 'youtube_player.dart';

/// Рендер одного материала по его типу (ТЗ §7.6).
///
/// Текст — inline, ссылка/файл — открываются во внешнем приложении, YouTube —
/// во встроенном плеере, изображение — `Image.network`.
class MaterialView extends StatelessWidget {
  const MaterialView({super.key, required this.material});

  final CourseMaterial material;

  Future<void> _open(String? url) async {
    if (url == null || url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (material.title.isNotEmpty) ...[
          Text(material.title, style: Theme.of(context).textTheme.titleMedium),
          AppSpacing.gapSm,
        ],
        _body(context),
      ],
    );
  }

  Widget _body(BuildContext context) {
    switch (material.type) {
      case CourseMaterialType.text:
        return SelectableText(material.description);

      case CourseMaterialType.link:
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.link),
          title: Text(material.url ?? ''),
          onTap: () => _open(material.url),
        );

      case CourseMaterialType.youtube:
        final id = extractYoutubeId(material.url ?? '');
        if (id == null) {
          return const Text('Некорректная ссылка');
        }
        return InAppYoutubePlayer(videoId: id);

      case CourseMaterialType.image:
        final url = material.fileUrl;
        if (url == null || url.isEmpty) {
          return const Text('Изображение недоступно');
        }
        return Image.network(
          url,
          errorBuilder: (context, error, stackTrace) =>
              const Text('Не удалось загрузить изображение'),
        );

      case CourseMaterialType.file:
      case CourseMaterialType.pdf:
      case CourseMaterialType.presentation:
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(material.type.icon),
          title: Text(material.title),
          subtitle: const Text('Открыть'),
          onTap: () => _open(material.fileUrl),
        );
    }
  }
}
