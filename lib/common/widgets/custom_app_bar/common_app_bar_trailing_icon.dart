import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonAppBarTrailingIcon extends StatelessWidget {
  const CommonAppBarTrailingIcon(
      {super.key, this.tapAction, required this.trailingIcon});

  final VoidCallback? tapAction;
  final String trailingIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapAction,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: AppColor.primaryLightGreyColor,
        child: Center(
          child: SvgPicture.asset(
            trailingIcon,
            height: 16,
            width: 16,
          ),
        ),
      ),
    );
  }
}
