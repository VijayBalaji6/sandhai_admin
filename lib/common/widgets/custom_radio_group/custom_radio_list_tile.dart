import 'package:QuIDPe/src/common/widgets/custom_text/custom_text.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  const CustomRadioListTile({
    super.key,
    required this.itemValue,
    required this.itemTitle,
    required this.groupValue,
    required this.onChanged,
  });

  final T itemValue;
  final T? groupValue;
  final String itemTitle;
  final Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(itemValue),
      child: RadioListTile<T?>(
        activeColor: AppColor.primaryColor,
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        value: itemValue,
        groupValue: groupValue,
        title: CustomText(
          text: itemTitle,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
