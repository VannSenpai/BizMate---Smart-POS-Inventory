import 'package:bizmate/model/inventory_model.dart';

class CartModel {
  final InventoryModel products;
  int qty;

  CartModel({required this.products, required this.qty});

  Map<String, dynamic> toMap() {
    return {
      'sku': products.sku,
      'namaBarang': products.nama,
      'hargaSatuan': products.harga,
      'quantity': qty,
      'subTotal': products.harga * qty,
    };
  }
}
