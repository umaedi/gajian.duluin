import 'package:intl/intl.dart';

String formatDateString(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd MMMM yyyy').format(dateTime);
}

String formatDateMonthThreeWord(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd MMM yyyy').format(dateTime);
}
