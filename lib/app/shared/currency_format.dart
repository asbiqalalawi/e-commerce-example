import 'package:intl/intl.dart';

class CurrencyFormat {
  static String usd(
    dynamic number, {
    int? decimalDigit,
  }) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'en',
      symbol: 'USD ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
