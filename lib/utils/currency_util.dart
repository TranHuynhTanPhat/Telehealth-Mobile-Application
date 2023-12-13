import 'package:healthline/utils/log_data.dart';
import 'package:intl/intl.dart';

String convertToVND(num price) {
  try {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return currencyFormat.format(price);
  } catch (e) {
    logPrint(e);
    return "undefine";
  }
}
