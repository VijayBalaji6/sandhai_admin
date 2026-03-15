import 'package:flutter/material.dart';
import 'package:sandhai_admin/common/widgets/custom_text/custom_text.dart';
import 'package:sandhai_admin/core/features/dashboard/view/nav_item.dart';

class NavTile extends StatelessWidget {
  const NavTile({
    super.key,
    required this.item,
    required this.selected,
    required this.colorScheme,
    required this.onTap,
  });

  final NavItem item;
  final bool selected;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = colorScheme.primary;
    final Color idleColor = colorScheme.onSurfaceVariant.withValues(alpha: .7);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: SizedBox(
            width: 60,
            height: 60,
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  selected ? item.selectedIcon : item.icon,
                  size: 26,
                  color: selected ? selectedColor : idleColor,
                ),

                CustomText(
                  text: item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected ? selectedColor : idleColor,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: 4,
          height: selected ? 44 : 0,
          decoration: BoxDecoration(
            color: selectedColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}
