import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.autoFocus = false,
    this.inputFormatters,
    this.style = const TextStyle(color: AppColor.whiteColor),
    this.onChanged,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autoFocus,
      style: TextStyle(color: AppColor.whiteColor),
      keyboardType: keyboardType,
      cursorColor: AppColor.primaryColor,
      inputFormatters: inputFormatters,
      onChanged: (value) => onChanged?.call(value),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColor.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColor.primaryColor,
          ), // Highlight when focused
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.greyColor),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.only(left: 12),
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColor.greyColor,
        ),
      ),
    );
  }
}
