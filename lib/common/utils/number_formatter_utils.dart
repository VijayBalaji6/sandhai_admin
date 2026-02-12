class NumberFormatterUtils {
  /// Formats a number according to the Indian numbering system
  /// and forces exactly 2 decimal places.
  ///
  /// Examples:
  ///  1000        → "1,000.00"
  ///  100000      → "1,00,000.00"
  ///  1234567.8   → "12,34,567.80"
  ///  1234567.897 → "12,34,567.90"
  ///  "345.1"     → "345.10"
  static String? convertToRupees(dynamic value, {bool addRupeeSymbol = false}) {
    if (value == null) return null;

    // Convert to double safely
    final doubleVal = double.tryParse(
      value.toString().replaceAll(',', '').trim(),
    );
    if (doubleVal == null) return null;

    // Always format to 2 decimals first
    final fixed = doubleVal.toStringAsFixed(2);

    final parts = fixed.split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    // Format integer part in Indian number style
    String formattedInteger;
    if (integerPart.length > 3) {
      final last3 = integerPart.substring(integerPart.length - 3);
      final rest = integerPart.substring(0, integerPart.length - 3);

      final grouped = rest.replaceAllMapped(
        RegExp(r'(\d)(?=(\d\d)+$)'),
        (m) => '${m[1]},',
      );

      formattedInteger = '$grouped,$last3';
    } else {
      formattedInteger = integerPart;
    }

    // 🔹 Remove .00 if decimal part is exactly 00
    final hasDecimal = decimalPart != '00';

    final finalValue = hasDecimal
        ? '$formattedInteger.$decimalPart'
        : formattedInteger;

    return addRupeeSymbol ? '₹$finalValue' : finalValue;
  }
}
