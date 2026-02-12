import 'package:QuIDPe/src/common/widgets/custom_text/custom_text.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.buttonName,
    this.buttonAction,
    this.buttonFontColor,
    this.buttonBackgroundColor,
  });

  final String buttonName;
  final Color? buttonFontColor;
  final Color? buttonBackgroundColor;
  final void Function()? buttonAction;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: buttonAction,
      style: TextButton.styleFrom(
        backgroundColor: buttonBackgroundColor ?? AppColor.whiteColor,
        foregroundColor: buttonFontColor ?? AppColor.blackColor,
        disabledBackgroundColor: buttonBackgroundColor ?? AppColor.whiteColor,
        disabledForegroundColor: buttonFontColor ?? AppColor.blackColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      child: CustomText(
        text: buttonName,
        color: buttonFontColor ?? AppColor.blackColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
