import 'package:intl/intl.dart';

class MyAppFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'th', symbol: '฿').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assume a 10-digit Thai phone number format: 081-234-5678
    if (phoneNumber.length == 10) {
      return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6, 10)}';
    } else {
      return phoneNumber;
    }
  }
}
