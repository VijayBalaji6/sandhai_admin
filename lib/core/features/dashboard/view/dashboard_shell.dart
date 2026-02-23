import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sandhai_admin/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:sandhai_admin/core/features/dashboard/view/nav_item.dart';
import 'package:sandhai_admin/core/features/dashboard/view/nav_tile.dart';

class DashboardShell extends StatelessWidget {
  const DashboardShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) => navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return CustomScaffold(
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: .08),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: .04),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(navItems.length, (i) {
                final NavItem item = navItems[i];
                final bool selected = i == navigationShell.currentIndex;
                return NavTile(
                  item: item,
                  selected: selected,
                  colorScheme: colorScheme,
                  onTap: () => _onTap(i),
                );
              }),
            ),
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}
