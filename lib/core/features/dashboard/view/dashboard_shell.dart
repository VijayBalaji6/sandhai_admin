import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sandhai_admin/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:sandhai_admin/common/widgets/custom_text/custom_text.dart';
import 'package:sandhai_admin/core/features/admin/shop_selection/cubit/admin_shop_selection_cubit.dart';
import 'package:sandhai_admin/core/features/dashboard/view/nav_item.dart';
import 'package:sandhai_admin/core/features/dashboard/view/nav_tile.dart';
import 'package:sandhai_admin/core/network/dtos/shop_model.dart';

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
      body: Column(
        children: [
          _DashboardShopAppBar(colorScheme: colorScheme),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 75,
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
                    left: false,
                    top: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.center,
                          child: CustomText(text: 'Sandhai', fontSize: 16),
                        ),
                        const SizedBox(height: 50),
                        Expanded(
                          child: ListView.separated(
                            itemCount: navItems.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 24),
                            itemBuilder: (BuildContext context, int i) {
                              final NavItem item = navItems[i];
                              final bool selected =
                                  i == navigationShell.currentIndex;
                              return NavTile(
                                item: item,
                                selected: selected,
                                colorScheme: colorScheme,
                                onTap: () => _onTap(i),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: navigationShell),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardShopAppBar extends StatelessWidget {
  const _DashboardShopAppBar({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: colorScheme.surface,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 52,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.storefront_outlined, color: colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: BlocBuilder<AdminShopSelectionCubit,
                      AdminShopSelectionState>(
                    buildWhen: (AdminShopSelectionState previous,
                        AdminShopSelectionState current) {
                      return previous.status != current.status ||
                          previous.shops != current.shops ||
                          previous.selectedShopId != current.selectedShopId ||
                          previous.errorMessage != current.errorMessage;
                    },
                    builder: (BuildContext context,
                        AdminShopSelectionState state) {
                      if (state.status == AdminShopLoadStatus.loading) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.primary,
                            ),
                          ),
                        );
                      }

                      if (state.status == AdminShopLoadStatus.failure) {
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.errorMessage ?? 'Could not load shops',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: colorScheme.error,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            IconButton(
                              tooltip: 'Retry',
                              onPressed: () => context
                                  .read<AdminShopSelectionCubit>()
                                  .load(),
                              icon: const Icon(Icons.refresh),
                            ),
                          ],
                        );
                      }

                      final ShopModel? shop = state.selectedShop;
                      if (shop == null) {
                        return const SizedBox.shrink();
                      }

                      if (!state.canSwitchShops) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            shop.shopName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        );
                      }

                      return Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: state.selectedShopId,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: colorScheme.onSurface,
                            ),
                            items: state.shops
                                .map(
                                  (ShopModel s) => DropdownMenuItem<String>(
                                    value: s.id,
                                    child: Text(
                                      s.shopName,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? id) {
                              if (id == null) {
                                return;
                              }
                              context
                                  .read<AdminShopSelectionCubit>()
                                  .selectShop(id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
