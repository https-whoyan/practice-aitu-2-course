import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../data/submission_providers.dart';
import '../domain/submission.dart';
import '../domain/submission_status.dart';

/// Экран отправки ответа на задание студентом (ТЗ §7.8, шаг 18).
///
/// Поля формы зависят от [submissionType] задания (`text`/`link`/`file`/
/// `combined`/`none`) — фича намеренно развязана от модуля заданий и получает
/// тип строкой. Дедлайн enforce-ится Security Rules: перевод отправки в
/// `submitted` после дедлайна без `allowLateSubmission` отклоняется сервером
/// (firestore.rules, P0-3), поэтому клиент здесь просто отправляет.
class SubmitScreen extends ConsumerStatefulWidget {
  const SubmitScreen({
    super.key,
    required this.assignmentId,
    required this.courseId,
    required this.submissionType,
  });

  final String assignmentId;
  final String courseId;
  final String submissionType;

  @override
  ConsumerState<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends ConsumerState<SubmitScreen> {
  final _textAnswer = TextEditingController();
  final _linkAnswer = TextEditingController();

  final List<String> _fileUrls = [];
  SubmissionStatus _status = SubmissionStatus.draft;

  bool _seeded = false;
  bool _saving = false;
  bool _submitting = false;
  bool _uploading = false;

  bool get _needsText =>
      widget.submissionType == 'text' || widget.submissionType == 'combined';
  bool get _needsLink =>
      widget.submissionType == 'link' || widget.submissionType == 'combined';
  bool get _needsFile =>
      widget.submissionType == 'file' || widget.submissionType == 'combined';
  bool get _isInfoOnly => widget.submissionType == 'none';

  @override
  void dispose() {
    _textAnswer.dispose();
    _linkAnswer.dispose();
    super.dispose();
  }

  /// Заполняет форму ранее сохранённым ответом один раз.
  void _seed(Submission s) {
    if (_seeded) return;
    _seeded = true;
    _textAnswer.text = s.textAnswer ?? '';
    _linkAnswer.text = s.linkAnswer ?? '';
    _fileUrls
      ..clear()
      ..addAll(s.fileUrls);
    _status = s.status;
  }

  /// Собирает модель ответа из текущего состояния формы.
  Submission _build(String uid, SubmissionStatus status) => Submission(
        submissionId: Submission.idFor(widget.assignmentId, uid),
        assignmentId: widget.assignmentId,
        courseId: widget.courseId,
        studentId: uid,
        textAnswer: _needsText ? _textAnswer.text.trim() : null,
        linkAnswer: _needsLink ? _linkAnswer.text.trim() : null,
        fileUrls: _needsFile ? List<String>.from(_fileUrls) : <String>[],
        status: status,
        updatedAt: DateTime.now(),
      );

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles(withData: true);
    final file = result?.files.singleOrNull;
    if (file == null || file.bytes == null) return;

    final uid = ref.read(appUserProvider).valueOrNull?.uid;
    if (uid == null) return;

    setState(() => _uploading = true);
    try {
      final url = await ref.read(submissionRepositoryProvider).uploadFile(
            assignmentId: widget.assignmentId,
            studentId: uid,
            fileName: file.name,
            bytes: file.bytes!,
          );
      if (!mounted) return;
      setState(() => _fileUrls.add(url));
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _saveDraft() async {
    final uid = ref.read(appUserProvider).valueOrNull?.uid;
    if (uid == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(submissionRepositoryProvider)
          .saveDraft(_build(uid, SubmissionStatus.draft));
      ref.invalidate(mySubmissionProvider(widget.assignmentId));
      if (!mounted) return;
      AppSnackbar.show(context, 'Черновик сохранён');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _submit() async {
    final uid = ref.read(appUserProvider).valueOrNull?.uid;
    if (uid == null) return;
    setState(() => _submitting = true);
    try {
      await ref
          .read(submissionRepositoryProvider)
          .submit(_build(uid, SubmissionStatus.submitted));
      ref.invalidate(mySubmissionProvider(widget.assignmentId));
      if (!mounted) return;
      AppSnackbar.show(context, 'Задание отправлено');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final submissionAsync = ref.watch(mySubmissionProvider(widget.assignmentId));
    return AppScaffold(
      title: 'Отправка задания',
      body: submissionAsync.when(
        data: (submission) {
          if (submission != null) _seed(submission);
          return _form(submission);
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () =>
              ref.invalidate(mySubmissionProvider(widget.assignmentId)),
        ),
      ),
    );
  }

  Widget _form(Submission? submission) {
    if (_isInfoOnly) {
      return const AppEmptyView(
        icon: Icons.info_outline,
        message: 'Это информационное задание, отправка не требуется',
      );
    }

    return ListView(
      children: [
        if (submission != null) ...[
          Row(
            children: [
              Chip(label: Text(_status.label)),
            ],
          ),
          AppSpacing.gapMd,
        ],
        if (_needsText) ...[
          TextFormField(
            controller: _textAnswer,
            maxLines: 6,
            decoration: const InputDecoration(labelText: 'Ответ'),
          ),
          AppSpacing.gapMd,
        ],
        if (_needsLink) ...[
          AppTextField(
            label: 'Ссылка',
            controller: _linkAnswer,
            keyboardType: TextInputType.url,
          ),
          AppSpacing.gapMd,
        ],
        if (_needsFile) ...[
          SecondaryButton(
            label: 'Прикрепить файл',
            isLoading: _uploading,
            onPressed: _uploading ? null : _pickFile,
          ),
          if (_fileUrls.isNotEmpty) ...[
            AppSpacing.gapSm,
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (var i = 0; i < _fileUrls.length; i++)
                  Chip(
                    label: Text('Файл ${i + 1}'),
                    onDeleted: () => setState(() => _fileUrls.removeAt(i)),
                  ),
              ],
            ),
          ],
          AppSpacing.gapMd,
        ],
        AppSpacing.gapLg,
        SecondaryButton(
          label: 'Сохранить черновик',
          isLoading: _saving,
          onPressed: _saving ? null : _saveDraft,
        ),
        AppSpacing.gapMd,
        PrimaryButton(
          label: 'Отправить',
          isLoading: _submitting,
          onPressed: _submitting ? null : _submit,
        ),
      ],
    );
  }
}
