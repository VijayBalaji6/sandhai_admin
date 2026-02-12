import 'package:QuIDPe/src/common/widgets/custom_radio_group/custom_radio_group.dart';
import 'package:QuIDPe/src/common/widgets/custom_radio_group/custom_radio_list_tile.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomSelectionBottomSelection<T> extends StatelessWidget {
  const CustomSelectionBottomSelection({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    this.customDropDownColor,
  });

  final T selectedItem;
  final List<T> items;
  final void Function(T?) onChanged;
  final Color? customDropDownColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: customDropDownColor ?? AppColor.whiteColor,
      child: Column(
        spacing: 20,
        children: [
          Text('Selected Item: $selectedItem'),
          CustomRadioGroup(
            groupValue: selectedItem,
            onChanged: (T? item) => onChanged(item),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final T currentItem = items[index];
                return CustomRadioListTile<T>(
                  groupValue: selectedItem,
                  itemValue: currentItem,
                  itemTitle: currentItem.toString(),
                  onChanged: (T? p1) {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
