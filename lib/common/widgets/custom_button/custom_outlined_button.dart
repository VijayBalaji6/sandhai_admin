import 'package:QuIDPe/src/common/widgets/custom_text/custom_text.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.buttonName,
    this.buttonAction,
    this.buttonFontColor,
    this.buttonBackgroundColor,
    this.buttonBorderColor,
    this.fontSize,
  });

  final String buttonName;
  final Color? buttonFontColor;
  final Color? buttonBackgroundColor;
  final Color? buttonBorderColor;
  final double? fontSize;
  final void Function()? buttonAction;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: buttonAction,
      style: OutlinedButton.styleFrom(
        backgroundColor: buttonBackgroundColor ?? AppColor.primaryColor,
        foregroundColor: buttonFontColor ?? AppColor.whiteColor,
        disabledBackgroundColor:
            buttonBackgroundColor ?? AppColor.primaryColor.withAlpha(70),
        disabledForegroundColor: buttonFontColor ?? AppColor.greyColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color:
                buttonBorderColor ??
                buttonBackgroundColor ??
                (buttonAction != null
                    ? AppColor.primaryColor
                    : AppColor.transparent),
            width: 1,
          ),
        ),
        elevation: 2,
      ),
      child: CustomText(
        text: buttonName,
        color: buttonFontColor ?? AppColor.whiteColor,
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
