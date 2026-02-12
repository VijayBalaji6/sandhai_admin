import 'package:QuIDPe/src/common/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

class CustomDateTimePicker {
  static Future<DateTime?> showCustomDatePicker({
    required BuildContext context,
    required DateTime initial,
    DateTime? startDate,
    DateTime? endDate,
    bool isFromDate = true,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
  }) async {
    final DateTime now = DateTimeUtils.getCurrentDateTime();
    final DateTime defaultDate = DateTime(2000);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: isFromDate ? defaultDate : (startDate ?? defaultDate),
      lastDate: isFromDate ? (endDate ?? now) : now,
      locale: const Locale('en'),
      initialEntryMode: initialEntryMode,
      builder: (BuildContext context, Widget? child) {
        return child!;
        // return Theme(
        //   data: Theme.of(context).copyWith(
        //     // dialogBackgroundColor: AppColor.whiteColor,
        //     colorScheme: ColorScheme.light(
        //       primary: AppColor.primaryColor,
        //       onPrimary: AppColor.whiteColor,
        //       surface: AppColor.whiteColor,
        //       onSurface: AppColor.greyGreenColor,
        //     ),
        //   ),
        //   child: child!,
        // );
      },
    );
    return pickedDate;
  }
}
