import 'package:intl/intl.dart';

class Formatters {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: 'MK',
    decimalDigits: 2,
  );

  static final NumberFormat _numberFormat = NumberFormat('#,##0.00');

  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      symbol: 'MK ',
      decimalDigits: 2,
      locale: 'en_US',
    );
    return formatter.format(amount);
  }

  static String formatNumber(double number) {
    return _numberFormat.format(number);
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('MMM d, y • h:mm a');
    return formatter.format(dateTime);
  }

  static String formatPhoneNumber(String phone) {
    if (phone.startsWith('+')) {
      return phone;
    }
    return '+$phone';
  }

  static String maskAccountNumber(String accountNumber) {
    if (accountNumber.length < 4) return accountNumber;
    final lastFour = accountNumber.substring(accountNumber.length - 4);
    return '••••$lastFour';
  }
}
