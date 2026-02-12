import 'package:intl/intl.dart';

class DateTimeUtils {
  static const Duration _istOffset = Duration(hours: 5, minutes: 30);

  /// Safely parses ISO with ANY fractional second length
  static DateTime _parseIsoAny(String input) {
    // Match fractional seconds: .25, .2, .12345 etc.
    final regex = RegExp(r'\.(\d+)([+-Z])');

    final fixed = input.replaceAllMapped(regex, (m) {
      final fraction = m.group(1)!;
      final next = m.group(2)!;

      // Pad or trim to 3 digits (milliseconds)
      String millis = fraction.padRight(3, '0');
      millis = millis.substring(0, 3);

      return '.$millis$next';
    });

    return DateTime.parse(fixed);
  }

  /// ALWAYS convert to IST
  static DateTime _toIST(DateTime dt) {
    return dt.toUtc().add(_istOffset);
  }

  /// ALWAYS return IST current time
  static DateTime getCurrentDateTime() {
    return _toIST(DateTime.now());
  }

  /// ALWAYS return IST after subtracting
  static DateTime getDifferenceTime({
    int hours = 0,
    int minutes = 0,
    int days = 0,
  }) {
    return _toIST(
      DateTime.now(),
    ).subtract(Duration(days: days, hours: hours, minutes: minutes));
  }

  static DateFormat getFormattedDate({String? dateFormat}) =>
      DateFormat(dateFormat ?? DateFormatUtils.dMMMYY);

  /// Parse → convert to IST
  static DateTime convertStringToDateTime({
    required String dateTimeString,
    String? format,
  }) {
    return _toIST(
      (format == null)
          ? _parseIsoAny(dateTimeString)
          : DateFormat(format).parse(dateTimeString),
    );
  }

  /// Format DateTime → IST
  static String getFormattedDateTime({
    DateTime? dateTimeData,
    String? dateTimeFormat,
  }) {
    final DateTime dt = _toIST(dateTimeData ?? DateTime.now());
    return getFormattedDate(dateFormat: dateTimeFormat).format(dt);
  }

  /// Input string UTC → IST → formatted
  static String getFormattedDateTimeFromString({
    required String dateTimeString,
    String? inputFormat,
    String? outputFormat,
  }) {
    final dt = DateFormat(
      inputFormat ?? DateFormatUtils.yyyyMMdd,
    ).parseUtc(dateTimeString);
    return getFormattedDate(dateFormat: outputFormat).format(_toIST(dt));
  }

  /// Format DateTime or String (UTC) → IST → formatted
  static String? getFormattedDynamicDateTime({
    required dynamic dateTimeInput,
    String? inputFormat,
    String? outputFormat,
  }) {
    DateTime dt;
    if (dateTimeInput is DateTime) {
      dt = _toIST(dateTimeInput);
    } else if (dateTimeInput is String) {
      dt = _toIST(
        DateFormat(
          inputFormat ?? DateFormatUtils.yyyyMMdd,
        ).parseUtc(dateTimeInput),
      );
    } else {
      return null;
    }
    return getFormattedDate(dateFormat: outputFormat).format(dt);
  }

  static String getShortMonth(DateTime date) {
    return DateFormat('MMM').format(_toIST(date));
  }

  static String? formatCompleteDateRange({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    if (startDate == null || endDate == null) return null;

    startDate = _toIST(startDate);
    endDate = _toIST(endDate);

    final months = DateFormatUtils.months;

    final start =
        '${startDate.day} ${months[startDate.month - 1]} ${startDate.year}';
    final end = '${endDate.day} ${months[endDate.month - 1]} ${endDate.year}';

    return '$start to $end';
  }
}

class DateFormatUtils {
  static final String dMMMYY = 'd MMM, yy';
  static final String ddMMMyyyy = 'dd MMM yyyy';
  static final String ddMMyyyy = 'dd/MM/yyyy';
  static final String MMMdyyyy = 'MMM d, yyyy';
  static final String yyyyMMdd = 'yyyy-MM-dd';
  static final String EddMMM = 'E, dd MMM';
  static final String hhmmA = 'hh:mm a';
  static final String ddMMMYY = "dd MMM, yy";
  static const String ddMMMYYhhmmA = "dd MMM yyyy, hh:mm a";
  static const String ddMMyyyyhhmmA = "dd/MM/yyyy  hh:mm a";

  static final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
}
