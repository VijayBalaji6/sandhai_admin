import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
  });

  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Radio<T>(
      value: value,
      // groupValue: groupValue,
      // onChanged: (T? value) {
      //   onChanged?.call(value);
      // },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      activeColor: AppColor.primaryColor,
    );
  }
}
