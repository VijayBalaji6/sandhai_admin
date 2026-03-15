import 'package:sandhai_admin/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../custom_text/custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
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
    return ElevatedButton(
      onPressed: buttonAction,
      style: ElevatedButton.styleFrom(
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
