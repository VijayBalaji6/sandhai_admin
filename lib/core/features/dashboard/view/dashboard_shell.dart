import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sandhai_admin/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:sandhai_admin/common/widgets/custom_text/custom_text.dart';
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
            width: 106,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: .06),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(text: "Sandhai", fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
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
                ],
              ),
            ),
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}
