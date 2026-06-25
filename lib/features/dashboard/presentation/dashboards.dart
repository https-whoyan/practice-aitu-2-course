import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/widgets.dart';
import '../../../theme/app_spacing.dart';
import '../../auth/data/auth_providers.dart';

/// Карточка-секция dashboard'а с пустым состоянием (данные — Сессия 2).
class _DashboardSection extends StatelessWidget {
  const _DashboardSection({required this.title, required this.emptyMessage});

  final String title;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title),
          AppCard(
            child: SizedBox(
              height: 160,
              child: AppEmptyView(message: emptyMessage),
            ),
          ),
        ],
      ),
    );
  }
}

/// Приветствие с именем текущего пользователя.
class _Greeting extends ConsumerWidget {
  const _Greeting(this.role);

  final String role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(appProfileProvider).valueOrNull?.fullName ?? '';
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Text(
        name.trim().isEmpty ? 'Здравствуйте!' : 'Здравствуйте, $name!',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView({required this.role, required this.sections});

  final String role;
  final List<({String title, String empty})> sections;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _Greeting(role),
        for (final s in sections)
          _DashboardSection(title: s.title, emptyMessage: s.empty),
      ],
    );
  }
}

/// Dashboard администратора (структура секций — ТЗ §5.3.6).
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) => const _DashboardView(
        role: 'admin',
        sections: [
          (title: 'Сводка по системе', empty: 'Метрики появятся в Сессии 2'),
          (title: 'Последние действия', empty: 'Журнал пока пуст'),
          (title: 'Пользователи', empty: 'Нет данных'),
        ],
      );
}

/// Dashboard преподавателя (структура секций — ТЗ §5.4.1).
class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) => const _DashboardView(
        role: 'teacher',
        sections: [
          (title: 'Мои курсы', empty: 'Курсы появятся в Сессии 2'),
          (title: 'Требуют проверки', empty: 'Нет заданий на проверке'),
          (title: 'Активные квизы', empty: 'Нет активных квизов'),
        ],
      );
}

/// Dashboard студента (структура секций — ТЗ §5.6.1).
class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) => const _DashboardView(
        role: 'student',
        sections: [
          (title: 'Мои курсы', empty: 'Вы пока не записаны на курсы'),
          (title: 'Ближайшие дедлайны', empty: 'Дедлайнов нет'),
          (title: 'Последние оценки', empty: 'Оценок пока нет'),
        ],
      );
}
