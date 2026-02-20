import 'package:flutter/material.dart';

abstract final class AppColor {
  static const Color transparent = Colors.transparent;
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color primaryLightGreyColor = Color(0xFFF5F5F5);
  static const Color primaryDarkGreyColor = Color(0xFF1E1E1E);

  static Color surfaceColor(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color onSurfaceColor(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color scaffoldBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? primaryDarkGreyColor
          : primaryLightGreyColor;
}
