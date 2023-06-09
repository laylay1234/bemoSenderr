import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:intl/intl.dart';

import '../utils/error_alerts_utils.dart';

class AmountFormatter {
  static final AmountFormatter _instance = AmountFormatter._internal();
  AmountFormatter._internal();
  factory AmountFormatter() => _instance;

  String formatByCurrency(String number, String currency_iso) {
    try {
      double amount = double.parse(number);
      String formated = NumberFormat.simpleCurrency(
        name: currency_iso.toUpperCase(),
      ).format(amount);
      return formated;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log('from formatByCurrency' + error.toString());
      return number;
    }
  }
}
