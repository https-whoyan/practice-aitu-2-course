import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// Единый каркас экрана. Все экраны строятся через [AppScaffold] — одна точка
/// для общих отступов, ограничения ширины контента и фоновых настроек.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.padded = true,
    this.constrainWidth = true,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool padded;
  final bool constrainWidth;

  @override
  Widget build(BuildContext context) {
    Widget content = body;
    if (padded) {
      content = Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: content,
      );
    }
    if (constrainWidth) {
      content = Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
          child: content,
        ),
      );
    }

    return Scaffold(
      appBar: appBar ??
          (title != null
              ? AppBar(title: Text(title!), actions: actions)
              : null),
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(child: content),
    );
  }
}

/// Карточка-контейнер (единый стиль из `cardTheme`).
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.onTap, this.padding});

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
          child: child,
        ),
      ),
    );
  }
}

/// Заголовок секции (для dashboard'ов и списков).
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
