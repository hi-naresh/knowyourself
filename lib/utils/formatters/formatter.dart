import 'package:intl/intl.dart';

class KFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }
  // '${DateFormat.jm().format(task.startTime)} - ${DateFormat.jm().format(task.endTime)}',
  static String formatTime(DateTime? time) {
    time ??= DateTime.now();
    return DateFormat.jm().format(time);
  }

  // static String formatCurrency(double amount) {
  //   return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount); // Customize the currency locale and symbol as needed
  // }

}