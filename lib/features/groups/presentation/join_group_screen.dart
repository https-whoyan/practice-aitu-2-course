import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/failure.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';
import '../../courses/data/course_providers.dart';
import '../data/group_functions.dart';

/// Вступление в группу по коду приглашения (ТЗ §5.4, шаг 16).
///
/// Код проверяется на сервере (срок/лимит); клиент вызывает callable и
/// инвалидирует профиль, чтобы список курсов обновился.
class JoinGroupScreen extends ConsumerStatefulWidget {
  const JoinGroupScreen({super.key});

  @override
  ConsumerState<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends ConsumerState<JoinGroupScreen> {
  final _code = TextEditingController();
  bool _joining = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _join() async {
    final code = _code.text.trim();
    if (code.isEmpty) {
      AppSnackbar.show(context, 'Введите код приглашения');
      return;
    }
    setState(() => _joining = true);
    try {
      final result = await ref.read(groupFunctionsProvider).joinGroupByCode(
            code,
          );
      ref.invalidate(appProfileProvider);
      ref.invalidate(coursesByGroupsProvider);
      if (!mounted) return;
      AppSnackbar.show(context, 'Вы вступили в группу «${result['title']}»');
      context.pop();
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showFailure(context, e as Failure);
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Вступление в группу',
      body: ListView(
        children: [
          Text(
            'Введите код приглашения, который выдал преподаватель. '
            'После вступления в группу её курсы появятся в разделе «Мои курсы».',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          AppSpacing.gapLg,
          TextFormField(
            controller: _code,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _join(),
            decoration: const InputDecoration(labelText: 'Код приглашения'),
          ),
          AppSpacing.gapXl,
          PrimaryButton(
            label: 'Вступить',
            isLoading: _joining,
            onPressed: _join,
          ),
        ],
      ),
    );
  }
}
