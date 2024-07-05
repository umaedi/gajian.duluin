import 'package:intl/intl.dart';

String convertStringToCurrency(
  String nominalStringInput,
  String localeInput,
  String symbolInput,
) {
  return NumberFormat.currency(
    locale: localeInput,
    symbol: symbolInput,
    decimalDigits: 0,
  ).format(int.parse(nominalStringInput));
}

String convertIntegerToCurrency(
  int nominalIntegerInput,
  String localeInput,
  String symbolInput,
) {
  return NumberFormat.currency(
    locale: localeInput,
    symbol: symbolInput,
    decimalDigits: 0,
  ).format(nominalIntegerInput);
}
