import 'package:intl/intl.dart';

class FormatCurrency {
  static String toRupiah(int price) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(price);
  }
}