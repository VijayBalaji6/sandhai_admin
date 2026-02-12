import 'package:QuIDPe/src/common/widgets/custom_text/custom_text.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomOverlayLoader extends StatelessWidget {
  const CustomOverlayLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(
        color: AppColor.blackColor.withValues(alpha: 0.50),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 24,
              children: [
                CircularProgressIndicator(color: AppColor.primaryColor),
                CustomText(
                  text: 'Loading...',
                  color: AppColor.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
