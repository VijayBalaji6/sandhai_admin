import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider(
      {super.key, this.dividerColor, this.thickness, this.height});

  final Color? dividerColor;
  final double? thickness;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: dividerColor ?? AppColor.dottedLineColor,
      thickness: thickness ?? 1,
      height: height ?? 1,
    );
  }
}
