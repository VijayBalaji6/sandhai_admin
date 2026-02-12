import 'package:QuIDPe/src/common/widgets/custom_button/custom_elevated_button.dart';
import 'package:QuIDPe/src/common/widgets/custom_text/custom_text.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, this.message, this.onRetry});

  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: AppColor.orangeColor, size: 48),
          CustomText(
            text: message ?? 'An error occurred',
            fontSize: 24,
            color: AppColor.blackColor,
          ),
          CustomElevatedButton(
            buttonAction: () => onRetry?.call(),
            buttonName: 'Retry',
          ),
        ],
      ),
    );
  }
}
