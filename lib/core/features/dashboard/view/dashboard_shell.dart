import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sandhai_admin/core/features/dashboard/view/nav_tile.dart';

class DashboardShell extends StatelessWidget {
  DashboardShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  final List<NavItem> _items = <NavItem>[
    NavItem(
      Icons.local_grocery_store_outlined,
      Icons.local_grocery_store,
      'Products',
    ),
    NavItem(Icons.receipt_long_outlined, Icons.receipt_long, 'Orders'),
    NavItem(Icons.history_outlined, Icons.history, 'History'),
    NavItem(Icons.storefront_outlined, Icons.storefront, 'Shop'),
    NavItem(Icons.people_outline, Icons.people, 'Users'),
  ];

  void _onTap(int index) => navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      body: Stack(
        children: [
          Positioned.fill(child: navigationShell),
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: 72,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(28),
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
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_items.length, (i) {
                    final item = _items[i];
                    final selected = i == navigationShell.currentIndex;
                    return NavTile(
                      item: item,
                      selected: selected,
                      colorScheme: colorScheme,
                      onTap: () => _onTap(i),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
