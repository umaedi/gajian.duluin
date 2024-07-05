import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

TextEditingValue currencyInputFormatter(
    TextEditingValue oldValue, TextEditingValue newValue) {
  if (newValue.selection.baseOffset == 0) {
    return newValue;
  }

  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
  final double value =
      double.parse(newValue.text.replaceAll(RegExp(r'[^\d]'), ''));
  final newText = formatter.format(value);
  final truncatedText = _truncateAfterComma(newText);

  final formattedLength = truncatedText.replaceAll(RegExp(r'[^\d]'), '').length;
  if (formattedLength > 7) {
    return oldValue;
  }

  return TextEditingValue(
    text: truncatedText,
    selection: TextSelection.collapsed(offset: truncatedText.length),
  );
}

String _truncateAfterComma(String text) {
  final commaIndex = text.indexOf(',');
  if (commaIndex != -1) {
    return text.substring(0, commaIndex);
  } else {
    return text;
  }
}
