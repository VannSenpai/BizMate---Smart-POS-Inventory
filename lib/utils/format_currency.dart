import 'package:intl/intl.dart';

class FormatCurrency {
  static String toRupiah(String price) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(price);
  }
}