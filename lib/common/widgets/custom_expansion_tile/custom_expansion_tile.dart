import 'package:QuIDPe/src/common/widgets/custom_divider/custom_divider.dart';
import 'package:QuIDPe/src/common/widgets/custom_text/custom_text.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile<T> extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    this.isInitiallyExpanded = false,
    this.expansionTileKey,
    this.titleIcon,
    required this.title,
    required this.child,
    this.enableDivider = false,
    this.expansionTileLeadingIcon,
    this.trailingIcon,
    this.subtitle,
  });

  final bool isInitiallyExpanded;
  final Key? expansionTileKey;
  final Widget? titleIcon;
  final String title;
  final Widget child;
  final bool enableDivider;
  final Widget? expansionTileLeadingIcon;
  final Widget? trailingIcon;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: trailingIcon,
      leading: expansionTileLeadingIcon,
      key: expansionTileKey,
      initiallyExpanded: isInitiallyExpanded,
      backgroundColor: AppColor.whiteColor,
      collapsedBackgroundColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tilePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      childrenPadding: EdgeInsets.zero,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 8,
        children: [
          ?titleIcon,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.clip,
                ),
                ?subtitle,
              ],
            ),
          ),
        ],
      ),
      // subtitle: subtitle,
      children: [
        if (enableDivider) ...[CustomDivider(), SizedBox(height: 20)],
        child,
      ],
      onExpansionChanged: (expanded) {},
    );
  }
}
