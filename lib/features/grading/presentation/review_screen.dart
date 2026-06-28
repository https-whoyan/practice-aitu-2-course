import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../assignments/data/assignment_providers.dart';
import '../../auth/data/auth_providers.dart';
import '../../groups/data/group_providers.dart';
import '../data/grade_providers.dart';

/// Экран проверки отправки студента (ТЗ §5.5.4).
///
/// Отвязан от фич `submissions`/`assignments`: данные отправки приходят через
/// параметры маршрута, сам документ читается «сырым» Firestore через
/// [GradeRepository.getSubmissionRaw]. Преподаватель выставляет оценку,
/// возвращает работу на доработку или принимает её.
class ReviewSubmissionScreen extends ConsumerStatefulWidget {
  const ReviewSubmissionScreen({
    super.key,
    required this.submissionId,
    required this.assignmentId,
    required this.studentId,
    required this.courseId,
    required this.maxScore,
  });

  final String submissionId;
  final String assignmentId;
  final String studentId;
  final String courseId;
  final int maxScore;

  @override
  ConsumerState<ReviewSubmissionScreen> createState() =>
      _ReviewSubmissionScreenState();
}

class _ReviewSubmissionScreenState
    extends ConsumerState<ReviewSubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scoreController = TextEditingController();
  final _commentController = TextEditingController();

  Future<Map<String, dynamic>?>? _submissionFuture;
  Map<String, dynamic>? _data;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _submissionFuture = ref
        .read(gradeRepositoryProvider)
        .getSubmissionRaw(widget.submissionId);
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  String? _validateScore(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) return 'Введите балл';
    final parsed = num.tryParse(raw);
    if (parsed == null) return 'Введите число';
    if (parsed < 0 || parsed > widget.maxScore) {
      return 'Балл от 0 до ${widget.maxScore}';
    }
    return null;
  }

  String? get _commentOrNull {
    final text = _commentController.text.trim();
    return text.isEmpty ? null : text;
  }

  /// Группа студента в этом курсе — для groupId оценки (P2-12).
  Future<String?> _resolveGroupId() async {
    try {
      final groups =
          await ref.read(courseGroupsProvider(widget.courseId).future);
      for (final g in groups) {
        if (g.studentIds.contains(widget.studentId)) return g.groupId;
      }
    } catch (_) {/* groupId опционален */}
    return null;
  }

  /// Дата отправки из «сырого» документа (для проверки просрочки, P2-9).
  DateTime? get _submittedAt {
    final raw = _data?['submittedAt'];
    if (raw == null) return null;
    try {
      return (raw as dynamic).toDate() as DateTime;
    } catch (_) {
      return null;
    }
  }

  Future<void> _grade() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final teacherId = ref.read(appUserProvider).valueOrNull?.uid;
    if (teacherId == null) return;
    var score = num.parse(_scoreController.text.trim());

    setState(() => _submitting = true);
    try {
      // Штраф за просрочку (P2-9): если сдано после дедлайна и задан latePenalty.
      final assignment =
          await ref.read(assignmentByIdProvider(widget.assignmentId).future);
      final deadline = assignment?.deadline;
      final penalty = assignment?.latePenalty ?? 0;
      final submittedAt = _submittedAt;
      final isLate = deadline != null &&
          submittedAt != null &&
          submittedAt.isAfter(deadline);
      var penaltyApplied = false;
      if (isLate && penalty > 0) {
        score = ((score * (100 - penalty) / 100) * 100).round() / 100;
        penaltyApplied = true;
      }

      final groupId = await _resolveGroupId();
      await ref.read(gradeRepositoryProvider).gradeSubmission(
            submissionId: widget.submissionId,
            assignmentId: widget.assignmentId,
            studentId: widget.studentId,
            courseId: widget.courseId,
            teacherId: teacherId,
            score: score,
            maxScore: widget.maxScore,
            comment: _commentOrNull,
            groupId: groupId,
          );
      if (mounted) {
        AppSnackbar.show(
          context,
          penaltyApplied
              ? 'Оценка выставлена со штрафом за просрочку: $score'
              : 'Оценка выставлена',
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _setStatus(String status, String successMessage,
      {String? teacherComment}) async {
    setState(() => _submitting = true);
    try {
      await ref.read(gradeRepositoryProvider).setSubmissionStatus(
            widget.submissionId,
            status,
            teacherComment: teacherComment,
          );
      if (mounted) {
        AppSnackbar.show(context, successMessage);
        context.pop();
      }
    } catch (e) {
      if (mounted) AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Проверка работы',
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _submissionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }
          if (snapshot.hasError) {
            return AppErrorView(failure: snapshot.error as Failure);
          }
          final data = snapshot.data;
          if (data == null) {
            return const AppEmptyView(message: 'Отправка не найдена');
          }
          _data = data; // для проверки просрочки при оценивании (P2-9)
          return _buildForm(context, data);
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, Map<String, dynamic> data) {
    final theme = Theme.of(context);
    final textAnswer = (data['textAnswer'] as String?)?.trim() ?? '';
    final linkAnswer = (data['linkAnswer'] as String?)?.trim() ?? '';
    final fileUrls = (data['fileUrls'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .where((e) => e.isNotEmpty)
            .toList() ??
        const <String>[];

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ответ студента', style: theme.textTheme.titleMedium),
                AppSpacing.gapMd,
                if (textAnswer.isNotEmpty) ...[
                  Text('Текст', style: theme.textTheme.labelLarge),
                  AppSpacing.gapXs,
                  SelectableText(textAnswer, style: theme.textTheme.bodyMedium),
                  AppSpacing.gapMd,
                ],
                if (linkAnswer.isNotEmpty) ...[
                  Text('Ссылка', style: theme.textTheme.labelLarge),
                  AppSpacing.gapXs,
                  InkWell(
                    onTap: () => _openLink(linkAnswer),
                    child: Text(
                      linkAnswer,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  AppSpacing.gapMd,
                ],
                if (fileUrls.isNotEmpty) ...[
                  Text('Файлы', style: theme.textTheme.labelLarge),
                  AppSpacing.gapXs,
                  for (final url in fileUrls)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.attach_file),
                      title: Text(url, maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      trailing: const Icon(Icons.download),
                      onTap: () => _openLink(url),
                    ),
                ],
                if (textAnswer.isEmpty &&
                    linkAnswer.isEmpty &&
                    fileUrls.isEmpty)
                  Text(
                    'Студент не приложил материалов',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          AppSpacing.gapLg,
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Оценка', style: theme.textTheme.titleMedium),
                AppSpacing.gapMd,
                AppTextField(
                  label: 'Балл (макс. ${widget.maxScore})',
                  controller: _scoreController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: _validateScore,
                ),
                AppSpacing.gapMd,
                TextFormField(
                  controller: _commentController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Комментарий (необязательно)',
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.gapLg,
          PrimaryButton(
            label: 'Выставить оценку',
            icon: Icons.grade,
            isLoading: _submitting,
            onPressed: _submitting ? null : _grade,
          ),
          AppSpacing.gapMd,
          SecondaryButton(
            label: 'Взять на проверку',
            onPressed: _submitting
                ? null
                : () => _setStatus('inReview', 'Работа взята на проверку'),
          ),
          AppSpacing.gapMd,
          SecondaryButton(
            label: 'Вернуть на доработку',
            onPressed: _submitting
                ? null
                : () => _setStatus(
                      'returned',
                      'Работа возвращена на доработку',
                      teacherComment: _commentOrNull,
                    ),
          ),
          AppSpacing.gapMd,
          SecondaryButton(
            label: 'Не принято',
            onPressed: _submitting
                ? null
                : () => _setStatus(
                      'rejected',
                      'Работа отклонена',
                      teacherComment: _commentOrNull,
                    ),
          ),
          AppSpacing.gapMd,
          SecondaryButton(
            label: 'Принять',
            onPressed:
                _submitting ? null : () => _setStatus('accepted', 'Работа принята'),
          ),
        ],
      ),
    );
  }
}
