import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../responsive/breakpoints.dart';
import 'nav_section.dart';

/// Адаптивная навигационная оболочка (ТЗ §6.1–6.2).
///
/// Web/desktop/планшет → боковое меню (`NavigationRail`); мобильный → нижняя
/// навигация (`NavigationBar`). Реализована поверх `StatefulShellRoute`, поэтому
/// каждая вкладка хранит свой стек/состояние. Разделов > 5 на мобильном —
/// первые 4 + «Ещё» (лист со всеми разделами).
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.navigationShell,
    required this.sections,
  });

  final StatefulNavigationShell navigationShell;
  final List<NavSection> sections;

  void _go(int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );

  @override
  Widget build(BuildContext context) {
    final current = navigationShell.currentIndex;
    final title = sections[current].label;

    return ResponsiveBuilder(
      builder: (context, type) {
        if (type == ScreenType.mobile) {
          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: SafeArea(child: navigationShell),
            bottomNavigationBar: _BottomNav(
              sections: sections,
              currentIndex: current,
              onSelect: _go,
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: SafeArea(
            child: Row(
              children: [
                _Rail(
                  sections: sections,
                  currentIndex: current,
                  extended: type == ScreenType.desktop,
                  onSelect: _go,
                ),
                const VerticalDivider(width: 1),
                Expanded(child: navigationShell),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Rail extends StatelessWidget {
  const _Rail({
    required this.sections,
    required this.currentIndex,
    required this.extended,
    required this.onSelect,
  });

  final List<NavSection> sections;
  final int currentIndex;
  final bool extended;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    // Прокрутка, если разделов больше, чем влезает по высоте.
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: NavigationRail(
              extended: extended,
              selectedIndex: currentIndex,
              onDestinationSelected: onSelect,
              labelType: extended
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              destinations: [
                for (final s in sections)
                  NavigationRailDestination(
                    icon: Icon(s.icon),
                    label: Text(s.label),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.sections,
    required this.currentIndex,
    required this.onSelect,
  });

  final List<NavSection> sections;
  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final hasMore = sections.length > 5;
    final primary = hasMore ? sections.take(4).toList() : sections;
    final selected =
        currentIndex < primary.length ? currentIndex : primary.length;

    return NavigationBar(
      selectedIndex: selected,
      onDestinationSelected: (index) {
        if (hasMore && index == primary.length) {
          _showMore(context);
        } else {
          onSelect(index);
        }
      },
      destinations: [
        for (final s in primary)
          NavigationDestination(icon: Icon(s.icon), label: s.label),
        if (hasMore)
          const NavigationDestination(icon: Icon(Icons.more_horiz), label: 'Ещё'),
      ],
    );
  }

  void _showMore(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (var i = 0; i < sections.length; i++)
              ListTile(
                leading: Icon(sections[i].icon),
                title: Text(sections[i].label),
                selected: i == currentIndex,
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  onSelect(i);
                },
              ),
          ],
        ),
      ),
    );
  }
}
