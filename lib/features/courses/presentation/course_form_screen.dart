import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../firebase/firebase_providers.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/data/user_providers.dart';
import '../data/course_cover_service.dart';
import '../data/course_providers.dart';
import '../domain/course.dart';
import '../domain/course_status.dart';

/// Форма создания/редактирования курса преподавателем (ТЗ §5.4, шаг 14).
///
/// [courseId] == null — создание, иначе редактирование (форма переиспользуется).
/// Назван `TeacherCourseFormScreen`, чтобы не конфликтовать с админским
/// `CourseFormScreen` в общем роутере.
class TeacherCourseFormScreen extends ConsumerStatefulWidget {
  const TeacherCourseFormScreen({super.key, this.courseId});

  final String? courseId;

  @override
  ConsumerState<TeacherCourseFormScreen> createState() =>
      _TeacherCourseFormScreenState();
}

class _TeacherCourseFormScreenState
    extends ConsumerState<TeacherCourseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _coverUrl = TextEditingController();
  final _coTeacherEmail = TextEditingController();

  CourseStatus _status = CourseStatus.draft;
  DateTime? _startDate;
  DateTime? _endDate;

  bool _isEdit = false;
  bool _seeded = false;
  bool _saving = false;
  bool _uploadingCover = false;
  bool _addingTeacher = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.courseId != null;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _coverUrl.dispose();
    _coTeacherEmail.dispose();
    super.dispose();
  }

  /// Заполняет контроллеры данными курса один раз (в режиме редактирования).
  void _seed(Course course) {
    if (_seeded) return;
    _seeded = true;
    _title.text = course.title;
    _description.text = course.description;
    _coverUrl.text = course.coverUrl ?? '';
    _status = course.status;
    _startDate = course.startDate;
    _endDate = course.endDate;
  }

  static String _fmtDate(DateTime? d) => d == null
      ? 'не задано'
      : '${d.day.toString().padLeft(2, '0')}.'
          '${d.month.toString().padLeft(2, '0')}.${d.year}';

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final initial = (isStart ? _startDate : _endDate) ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
    });
  }

  Future<void> _uploadCover(String uid) async {
    final result = await FilePicker.pickFiles(
      type: FileType.image,
      withData: true,
    );
    final file = result?.files.singleOrNull;
    final bytes = file?.bytes;
    if (file == null || bytes == null) return;
    final ext = (file.extension ?? 'jpg').toLowerCase();
    final mime = switch (ext) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      'gif' => 'image/gif',
      _ => 'image/jpeg',
    };
    setState(() => _uploadingCover = true);
    try {
      final url = await ref.read(courseCoverServiceProvider).uploadCover(
            uid: uid,
            fileName: 'cover.$ext',
            bytes: bytes,
            contentType: mime,
          );
      if (!mounted) return;
      setState(() => _coverUrl.text = url);
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _uploadingCover = false);
    }
  }

  /// Добавляет соавтора-преподавателя по email (через CF, P2-1).
  Future<void> _addCoTeacher(String courseId) async {
    final email = _coTeacherEmail.text.trim();
    if (email.isEmpty) return;
    setState(() => _addingTeacher = true);
    try {
      await ref
          .read(firebaseFunctionsProvider)
          .httpsCallable('addCourseTeacherByEmail')
          .call<Object?>({'courseId': courseId, 'email': email});
      if (!mounted) return;
      _coTeacherEmail.clear();
      AppSnackbar.show(context, 'Соавтор добавлен');
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _addingTeacher = false);
    }
  }

  Future<void> _removeCoTeacher(Course course, String teacherId) async {
    final next = course.teacherIds.where((t) => t != teacherId).toList();
    try {
      await ref.read(courseRepositoryProvider).updateCourse(
            course.copyWith(teacherIds: next, updatedAt: DateTime.now()),
          );
      if (mounted) AppSnackbar.show(context, 'Соавтор удалён');
    } catch (e) {
      if (mounted) AppSnackbar.showFailure(context, e as Failure);
    }
  }

  Future<void> _save(Course? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final uid = ref.read(appUserProvider).valueOrNull?.uid;
    if (uid == null) return;
    setState(() => _saving = true);
    final repo = ref.read(courseRepositoryProvider);
    final now = DateTime.now();
    final cover = _coverUrl.text.trim();
    try {
      if (existing == null) {
        await repo.createCourse(
          Course(
            courseId: '',
            title: _title.text.trim(),
            description: _description.text.trim(),
            ownerTeacherId: uid,
            teacherIds: [uid],
            coverUrl: cover.isEmpty ? null : cover,
            status: _status,
            startDate: _startDate,
            endDate: _endDate,
            createdAt: now,
            updatedAt: now,
          ),
        );
      } else {
        await repo.updateCourse(
          existing.copyWith(
            title: _title.text.trim(),
            description: _description.text.trim(),
            coverUrl: cover.isEmpty ? null : cover,
            status: _status,
            startDate: _startDate,
            endDate: _endDate,
            updatedAt: now,
          ),
        );
      }
      ref.invalidate(ownerCoursesProvider(uid));
      if (existing != null) {
        ref.invalidate(courseByIdProvider(existing.courseId));
      }
      if (!mounted) return;
      AppSnackbar.show(context, existing == null ? 'Курс создан' : 'Сохранено');
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
        title: 'Новый курс',
        body: _form(existing: null),
      );
    }

    final courseAsync = ref.watch(courseByIdProvider(widget.courseId!));
    return AppScaffold(
      title: 'Курс',
      body: courseAsync.when(
        data: (course) {
          if (course == null) {
            return const AppEmptyView(message: 'Курс не найден');
          }
          _seed(course);
          return _form(existing: course);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(courseByIdProvider(widget.courseId!)),
        ),
      ),
    );
  }

  Widget _form({required Course? existing}) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          AppTextField(
            label: 'Название',
            controller: _title,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Введите название' : null,
          ),
          AppSpacing.gapMd,
          TextFormField(
            controller: _description,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Описание'),
          ),
          AppSpacing.gapMd,
          _coverSection(),
          AppSpacing.gapMd,
          Row(
            children: [
              Expanded(
                child: _dateTile('Начало', _startDate, () => _pickDate(isStart: true)),
              ),
              AppSpacing.gapSm,
              Expanded(
                child: _dateTile('Завершение', _endDate, () => _pickDate(isStart: false)),
              ),
            ],
          ),
          AppSpacing.gapMd,
          DropdownButtonFormField<CourseStatus>(
            initialValue: _status,
            decoration: const InputDecoration(labelText: 'Статус'),
            items: [
              for (final status in CourseStatus.values)
                DropdownMenuItem(
                  value: status,
                  child: Text(status.label),
                ),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _status = value);
            },
          ),
          if (existing != null) ...[
            AppSpacing.gapLg,
            _coTeachersSection(existing),
          ],
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

  Widget _coverSection() {
    final uid = ref.read(appUserProvider).valueOrNull?.uid;
    final url = _coverUrl.text.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (url.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(url,
                height: 120, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox.shrink()),
          ),
        AppSpacing.gapSm,
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: _uploadingCover || uid == null
                  ? null
                  : () => _uploadCover(uid),
              icon: _uploadingCover
                  ? const SizedBox(
                      width: 16, height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.image_outlined),
              label: const Text('Загрузить обложку'),
            ),
          ],
        ),
        AppSpacing.gapSm,
        AppTextField(
          label: 'или ссылка на обложку',
          controller: _coverUrl,
          keyboardType: TextInputType.url,
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }

  Widget _dateTile(String label, DateTime? value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: Text(_fmtDate(value)),
      ),
    );
  }

  /// Соавторы-преподаватели курса (P2-1): список с именами + добавление по email.
  Widget _coTeachersSection(Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Преподаватели курса',
            style: Theme.of(context).textTheme.titleSmall),
        AppSpacing.gapSm,
        for (final tId in course.teacherIds)
          _CoTeacherTile(
            uid: tId,
            isOwner: tId == course.ownerTeacherId,
            onRemove: tId == course.ownerTeacherId
                ? null
                : () => _removeCoTeacher(course, tId),
          ),
        AppSpacing.gapSm,
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Email соавтора',
                controller: _coTeacherEmail,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            AppSpacing.gapSm,
            _addingTeacher
                ? const Padding(
                    padding: EdgeInsets.all(AppSpacing.sm),
                    child: SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2)),
                  )
                : IconButton.filled(
                    icon: const Icon(Icons.person_add_alt),
                    tooltip: 'Добавить соавтора',
                    onPressed: () => _addCoTeacher(course.courseId),
                  ),
          ],
        ),
      ],
    );
  }
}

/// Строка преподавателя курса с именем из профиля и кнопкой удаления.
class _CoTeacherTile extends ConsumerWidget {
  const _CoTeacherTile({
    required this.uid,
    required this.isOwner,
    required this.onRemove,
  });

  final String uid;
  final bool isOwner;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileStreamProvider(uid)).valueOrNull;
    final name = (profile?.fullName.trim().isNotEmpty ?? false)
        ? profile!.fullName
        : uid;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: const Icon(Icons.school_outlined),
      title: Text(name),
      subtitle: isOwner ? const Text('Владелец') : null,
      trailing: onRemove == null
          ? null
          : IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Удалить',
              onPressed: onRemove,
            ),
    );
  }
}
