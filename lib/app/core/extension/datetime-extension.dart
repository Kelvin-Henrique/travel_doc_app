import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatDayMonthYear() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String formatMonthYear() {
    return DateFormat('MM/yyyy').format(this);
  }

  String getHourFormated() {
    return DateFormat('HH:mi:ss').format(this);
  }

  String toFormat(String format) {
    return DateFormat(format).format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
