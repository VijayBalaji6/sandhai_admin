import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/theme/app_colors.dart';
import '../custom_text/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.centreTitle,
    this.leadingWidget,
    this.appBarBackgroundColor,
    this.trailingWidget,
    this.elevation,
    this.hasBackButton = false,
  });

  final String? title;
  final double? elevation;
  final bool? centreTitle;
  final Widget? leadingWidget;
  final List<Widget>? trailingWidget;
  final Color? appBarBackgroundColor;
  final bool hasBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: hasBackButton ? 40 : 104,
      actionsPadding: EdgeInsets.only(right: 16),
      surfaceTintColor: AppColor.transparent,
      automaticallyImplyLeading: false,
      elevation: elevation ?? 0.0,
      title: title != null
          ? CustomText(text: title!, fontSize: 20, fontWeight: FontWeight.w700)
          : null,
      centerTitle: centreTitle,
      leading: hasBackButton
          ? InkWell(
              onTap: () => context.pop(),
              child: Icon(Icons.keyboard_arrow_left_outlined, size: 24),
            )
          : Padding(padding: EdgeInsets.only(left: 16.0), child: leadingWidget),
      actions: trailingWidget,
      backgroundColor: appBarBackgroundColor ?? AppColor.primaryColor,
    );
  }
}
