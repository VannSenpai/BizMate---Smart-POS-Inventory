class TransactionModel {
  String? id;
  int total;
  String payment;
  dynamic time;

  TransactionModel({
    this.id,
    required this.payment,
    required this.total,
    required this.time,
  });
}
