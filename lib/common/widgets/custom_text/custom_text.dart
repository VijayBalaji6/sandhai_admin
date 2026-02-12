import 'package:QuIDPe/src/common/utils/number_formatter_utils.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w500,
    this.color = AppColor.blackColor,
    this.overflow = TextOverflow.clip,
    this.isCurrency = false,
    this.decoration,
    this.textAlign,
    this.softWrap,
    this.maxLines,
    this.fontStyle,
    this.prefixText,
    this.letterSpacing,
    this.shadows,
  });

  final String? text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextOverflow overflow;
  final bool isCurrency;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final bool? softWrap;
  final int? maxLines;
  final FontStyle? fontStyle;
  final String? prefixText;
  final double? letterSpacing;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    final String? displayText = isCurrency
        ? NumberFormatterUtils.convertToRupees(
                text,
                addRupeeSymbol: isCurrency,
              ) ??
              text
        : text;

    final String? finalText = prefixText != null
        ? '$prefixText$displayText'
        : displayText;

    return Text(
      finalText ?? '',
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        overflow: overflow,
        decoration: decoration,
        letterSpacing: letterSpacing,
        shadows: shadows,
      ),
    );
  }
}
