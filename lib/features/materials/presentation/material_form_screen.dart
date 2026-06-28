import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../data/material_providers.dart';
import '../data/material_storage_service.dart';
import '../domain/material.dart';
import '../domain/material_type.dart';
import '../domain/youtube_utils.dart';

/// Форма создания/редактирования материала недели (ТЗ §7.6).
///
/// [materialId] == null — создание, иначе редактирование (форма переиспользуется).
class MaterialFormScreen extends ConsumerStatefulWidget {
  const MaterialFormScreen({
    super.key,
    required this.courseId,
    required this.weekId,
    this.materialId,
  });

  final String courseId;
  final String weekId;
  final String? materialId;

  @override
  ConsumerState<MaterialFormScreen> createState() => _MaterialFormScreenState();
}

class _MaterialFormScreenState extends ConsumerState<MaterialFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _url = TextEditingController();

  CourseMaterialType _type = CourseMaterialType.text;
  bool _isPublished = false;
  String? _fileUrl;
  String? _fileName;

  bool _isEdit = false;
  bool _seeded = false;
  bool _saving = false;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.materialId != null;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _url.dispose();
    super.dispose();
  }

  /// Заполняет форму данными материала один раз (режим редактирования).
  void _seed(CourseMaterial m) {
    if (_seeded) return;
    _seeded = true;
    _title.text = m.title;
    _description.text = m.description;
    _url.text = m.url ?? '';
    _type = m.type;
    _isPublished = m.isPublished;
    _fileUrl = m.fileUrl;
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles(withData: true);
    final file = result?.files.singleOrNull;
    if (file == null || file.bytes == null) return;

    setState(() => _uploading = true);
    try {
      final uid = ref.read(appUserProvider).valueOrNull?.uid ?? 'unknown';
      final url = await ref.read(materialStorageServiceProvider).uploadMaterialFile(
            courseId: widget.courseId,
            weekId: widget.weekId,
            uid: uid,
            fileName: file.name,
            bytes: file.bytes!,
          );
      if (!mounted) return;
      setState(() {
        _fileUrl = url;
        _fileName = file.name;
      });
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _save(CourseMaterial? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_type.isFileBased && (_fileUrl == null || _fileUrl!.isEmpty)) {
      AppSnackbar.show(context, 'Выберите файл');
      return;
    }
    setState(() => _saving = true);
    final repo = ref.read(materialRepositoryProvider);
    final now = DateTime.now();
    try {
      if (existing == null) {
        await repo.addMaterial(
          CourseMaterial(
            materialId: '',
            courseId: widget.courseId,
            weekId: widget.weekId,
            title: _title.text.trim(),
            description: _description.text.trim(),
            type: _type,
            url: _type == CourseMaterialType.link || _type == CourseMaterialType.youtube
                ? _url.text.trim()
                : null,
            fileUrl: _type.isFileBased ? _fileUrl : null,
            orderIndex: 0,
            isPublished: _isPublished,
            createdAt: now,
            updatedAt: now,
          ),
        );
      } else {
        await repo.updateMaterial(
          existing.copyWith(
            title: _title.text.trim(),
            description: _description.text.trim(),
            type: _type,
            url: _type == CourseMaterialType.link || _type == CourseMaterialType.youtube
                ? _url.text.trim()
                : null,
            fileUrl: _type.isFileBased ? _fileUrl : null,
            isPublished: _isPublished,
            updatedAt: now,
          ),
        );
      }
      ref.invalidate(materialsProvider(widget.weekId));
      if (!mounted) return;
      AppSnackbar.show(context, existing == null ? 'Материал создан' : 'Сохранено');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isEdit) {
      return AppScaffold(
        title: 'Новый материал',
        body: _form(existing: null),
      );
    }

    final materialAsync = ref.watch(materialByIdProvider(widget.materialId!));
    return AppScaffold(
      title: 'Материал',
      body: materialAsync.when(
        data: (material) {
          if (material == null) {
            return const AppEmptyView(message: 'Материал не найден');
          }
          _seed(material);
          return _form(existing: material);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () =>
              ref.invalidate(materialByIdProvider(widget.materialId!)),
        ),
      ),
    );
  }

  Widget _form({required CourseMaterial? existing}) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          DropdownButtonFormField<CourseMaterialType>(
            initialValue: _type,
            decoration: const InputDecoration(labelText: 'Тип'),
            items: [
              for (final t in CourseMaterialType.values)
                DropdownMenuItem(
                  value: t,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(t.icon, size: 18),
                      AppSpacing.gapSm,
                      Text(t.label),
                    ],
                  ),
                ),
            ],
            onChanged: (t) {
              if (t != null) setState(() => _type = t);
            },
          ),
          AppSpacing.gapMd,
          AppTextField(
            label: 'Название',
            controller: _title,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Введите название' : null,
          ),
          AppSpacing.gapMd,
          ..._typeFields(),
          AppSpacing.gapMd,
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Опубликован'),
            subtitle: const Text('Виден студентам'),
            value: _isPublished,
            onChanged: (v) => setState(() => _isPublished = v),
          ),
          AppSpacing.gapXl,
          PrimaryButton(
            label: 'Сохранить',
            isLoading: _saving,
            onPressed: () => _save(existing),
          ),
        ],
      ),
    );
  }

  List<Widget> _typeFields() {
    switch (_type) {
      case CourseMaterialType.text:
        return [
          TextFormField(
            controller: _description,
            maxLines: 5,
            decoration: const InputDecoration(labelText: 'Текст'),
          ),
        ];

      case CourseMaterialType.link:
        return [
          AppTextField(
            label: 'Ссылка',
            controller: _url,
            keyboardType: TextInputType.url,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Введите ссылку' : null,
          ),
        ];

      case CourseMaterialType.youtube:
        return [
          AppTextField(
            label: 'Ссылка',
            controller: _url,
            keyboardType: TextInputType.url,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Введите ссылку';
              if (!isValidYoutubeUrl(v.trim())) {
                return 'Некорректная ссылка YouTube';
              }
              return null;
            },
          ),
        ];

      case CourseMaterialType.file:
      case CourseMaterialType.pdf:
      case CourseMaterialType.presentation:
      case CourseMaterialType.image:
        return [
          SecondaryButton(
            label: 'Выбрать файл',
            isLoading: _uploading,
            onPressed: _uploading ? null : _pickFile,
          ),
          if (_fileName != null || _fileUrl != null) ...[
            AppSpacing.gapSm,
            Text(
              _fileName ?? 'Файл загружен',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ];
    }
  }
}
