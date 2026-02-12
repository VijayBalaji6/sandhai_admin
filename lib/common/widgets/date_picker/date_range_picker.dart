import 'package:QuIDPe/src/common/utils/date_time_utils.dart';
import 'package:QuIDPe/src/common/widgets/custom_date_time_picker/custom_date_time_picker.dart';
import 'package:QuIDPe/src/common/widgets/custom_text/custom_text.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DateRangeSelector extends StatefulWidget {
  final String? label;
  final String? noteText;
  final DateTime? fromDate;
  final DateTime? toDate;
  final Function(DateTime? from, DateTime? to)? onDateChanged;
  final int? maxRangeInDays;

  const DateRangeSelector({
    super.key,
    this.label,
    this.noteText,
    this.fromDate,
    this.toDate,
    this.onDateChanged,
    this.maxRangeInDays,
  });

  @override
  DateRangeSelectorState createState() => DateRangeSelectorState();
}

class DateRangeSelectorState extends State<DateRangeSelector> {
  DateTime? fromDate;
  DateTime? toDate;
  String? errorText;

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTimeUtils.getCurrentDateTime();
    fromDate = widget.fromDate ?? DateTime(now.year, now.month - 1, now.day);
    toDate = widget.toDate ?? now;
    _validate(); // run initial validation
  }

  void _validate() {
    final DateTime now = DateTimeUtils.getCurrentDateTime();
    if (fromDate == null || toDate == null) {
      errorText = "Both dates are required.";
    } else if (fromDate!.isAfter(toDate!)) {
      errorText = "From Date cannot be after To Date.";
    } else if (fromDate!.isAfter(now) || toDate!.isAfter(now)) {
      errorText = "Dates cannot be in the future.";
    } else if (widget.maxRangeInDays != null &&
        toDate!.difference(fromDate!).inDays > widget.maxRangeInDays!) {
      errorText = "Date range cannot exceed ${widget.maxRangeInDays} days.";
    } else {
      errorText = null;
    }

    setState(() {}); // refresh UI
  }

  Future<void> _pickDate({required bool isFromDate}) async {
    final DateTime now = DateTimeUtils.getCurrentDateTime();
    DateTime initial = isFromDate ? (fromDate ?? now) : (toDate ?? now);

    if (initial.isAfter(now)) initial = now;

    final DateTime? picked = await CustomDateTimePicker.showCustomDatePicker(
      context: context,
      initial: initial,
      startDate: null,
      endDate: toDate,
      isFromDate: isFromDate,
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (picked != null) {
      if (isFromDate) {
        fromDate = picked;
        // if user tries to pick fromDate > toDate, adjust toDate
        if (toDate != null && fromDate!.isAfter(toDate!)) {
          toDate = fromDate;
        }
      } else {
        toDate = picked;
      }
      setState(() {});
      _validate();
      if (errorText == null) {
        widget.onDateChanged?.call(fromDate, toDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Color borderColor = errorText != null
    //     ? Colors.red
    //     : ColorsHelper.greyContainerColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 12,
          children: [
            if (widget.label != null) ...[
              CustomText(
                text: widget.label!,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.grey5Color),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    datePickerWidget(
                      onTapAction: () => _pickDate(isFromDate: true),
                      label: fromDate == null ? "From Date" : null,
                      value: fromDate,
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.grey.shade300,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    datePickerWidget(
                      onTapAction: () => _pickDate(isFromDate: false),
                      label: toDate == null ? "To Date" : null,
                      value: toDate,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          CustomText(text: errorText!, color: Colors.red, fontSize: 12),
        ],
        if (widget.noteText != null) ...[
          const SizedBox(height: 8),
          CustomText(
            text: widget.noteText!,
            fontSize: 13,
            color: AppColor.greyColor,
            fontStyle: FontStyle.italic,
          ),
        ],
      ],
    );
  }

  Expanded datePickerWidget({
    Function()? onTapAction,
    String? label,
    DateTime? value,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTapAction,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text:
                  label ??
                  DateTimeUtils.getFormattedDateTime(
                    dateTimeData: value,
                    dateTimeFormat: DateFormatUtils.yyyyMMdd,
                  ),

              fontSize: 16,
              color: label != null
                  ? AppColor.grey5Color
                  : AppColor.greyGreenColor,
            ),
            Icon(
              LucideIcons.calendarDays,
              size: 20,
              color: AppColor.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
