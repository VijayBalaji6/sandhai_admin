import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.selectedItem,
    required this.items,
    this.customDropDownColor,
    this.onTapEvent,
    this.hintText,
    this.leadingIcon,
    required this.labelBuilder,
  });

  final T selectedItem;
  final List<T> items;
  final Color? customDropDownColor;
  final void Function(T)? onTapEvent;
  final String? hintText;
  final Widget? leadingIcon;
  final String Function(T) labelBuilder;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: DropdownMenu<T>(
        width: screenSize.width * .9,
        hintText: hintText ?? "Select an option",
        initialSelection: selectedItem,
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          //contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),

        trailingIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 26.0),
        selectedTrailingIcon: Icon(
          Icons.keyboard_arrow_up_outlined,
          size: 26.0,
        ),
        textStyle: TextStyle(
          color: AppColor.blackColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        menuStyle: MenuStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          elevation: WidgetStateProperty.all(4),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: WidgetStateProperty.all(AppColor.whiteColor),
          minimumSize: WidgetStateProperty.all(
            Size(screenSize.width * .9, screenSize.height * .1),
          ),
          maximumSize: WidgetStateProperty.all(
            Size(screenSize.width * .9, screenSize.height * .5),
          ),
        ),
        leadingIcon: leadingIcon,
        dropdownMenuEntries: items.map((T val) {
          return DropdownMenuEntry<T>(
            value: val,
            label: labelBuilder(val),
            leadingIcon: leadingIcon,
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
              textStyle: WidgetStateProperty.all(
                TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
        onSelected: (T? val) {
          if (val != null && onTapEvent != null) {
            onTapEvent!(val);
          }
        },
      ),
    );
  }
}
