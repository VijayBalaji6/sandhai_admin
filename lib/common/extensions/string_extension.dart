extension StringToOrdinal on String {
  /// Converts the string to int and returns the ordinal (1st, 2nd, 3rd...)
  String toOrdinal() {
    final number = int.tryParse(this);

    if (number == null) return this; // return original if not a number

    final int lastDigit = number % 10;
    final int lastTwoDigits = number % 100;

    String suffix;

    // Special cases: 11, 12, 13
    if (lastTwoDigits >= 11 && lastTwoDigits <= 13) {
      suffix = "th";
    } else {
      switch (lastDigit) {
        case 1:
          suffix = "st";
          break;
        case 2:
          suffix = "nd";
          break;
        case 3:
          suffix = "rd";
          break;
        default:
          suffix = "th";
      }
    }

    return "$number$suffix";
  }
}

extension StringNumberParsing on String {
  /// Converts string → double (keeps decimals)
  double? toDoubleSafe() {
    try {
      final clean = replaceAll(',', '').trim();
      return double.parse(clean);
    } catch (_) {
      return null;
    }
  }

  /// Converts string → int (only if valid integer)
  int? toIntSafe() {
    try {
      final clean = replaceAll(',', '').trim();
      return int.parse(clean);
    } catch (_) {
      return null;
    }
  }
}

// String to cut off decimals after two places
extension StringRemoveDecimal on String {
  String? toTwoDecimal() {
    try {
      final clean = replaceAll(',', '').trim();
      final number = double.parse(clean);

      return number.toStringAsFixed(2);
    } catch (e) {
      return null; // invalid string
    }
  }
}
