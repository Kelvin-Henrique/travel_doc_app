import 'package:intl/intl.dart';
import '../utils/settings.dart';

extension CurrencyExtension on double {
  String formatCurrency() {
    return NumberFormat.currency(
      locale: Settings.locale,
      symbol: 'R\$',
    ).format(this);
  }
}
