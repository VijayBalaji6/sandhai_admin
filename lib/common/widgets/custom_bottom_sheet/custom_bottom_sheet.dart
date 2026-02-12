import 'dart:async';

import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomBottomSheetWidget {
  static Future<void> showBottomSheet<T>({
    required BuildContext context,
    required Widget Function(BuildContext sheetContext) childBuilder,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 18.0,
      vertical: 32,
    ),
  }) async {
    await showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext sheetContext) {
        return Padding(padding: padding, child: childBuilder(sheetContext));
      },
    );
  }
}
