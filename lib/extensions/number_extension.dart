import 'package:intl/intl.dart';

extension NumberExtension on double {
  String formatCurrency() {
    // Create a NumberFormat instance for the desired locale and currency symbol
    final NumberFormat formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    // Format the double value to a string with currency symbol and grouping separators
    return formatter.format(this);
  }
}

extension IntExtension on int {
  String formatCount() {
    if (this >= 100) {
      return '+99';
    } else {
      return this.toString();
    }
  }

  String formatCompact() {
    if (this < 1000) {
      return this.toString();
    } else if (this < 1000000) {
      double value = this / 1000.0;
      return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}k';
    } else {
      double value = this / 1000000.0;
      return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}M';
    }
  }
}
