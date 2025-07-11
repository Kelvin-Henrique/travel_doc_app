import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String formatPercent() {
    return NumberFormat.decimalPercentPattern(locale: "pt-BR", decimalDigits: 2)
        .format(this);
  }
}
