import 'package:intl/intl.dart';

extension StringExtension on String? {
  bool get isNotNullOrEmpty {
    return this != null && this!.isNotEmpty;
  }

  String? convertToAppDateTime({
    String fromPattern = "yyyy-MM-dd HH:mm:ss.SSS",
    String toPattern = 'dd/MM/yyyy',
  }) {
    if (this.isNotNullOrEmpty) {
      DateTime inputDate = DateFormat(fromPattern).parse(this!);
      DateFormat outputFormat = DateFormat(toPattern);
      String outputDate = outputFormat.format(inputDate);
      return outputDate;
    }
    return null;
  }
}