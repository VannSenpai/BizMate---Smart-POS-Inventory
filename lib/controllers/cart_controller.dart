import 'package:bizmate/controllers/auth_controller.dart';
import 'package:bizmate/controllers/inventory_controller.dart';
import 'package:bizmate/model/inventory_model.dart';
import 'package:bizmate/pages/payment_success.dart';
import 'package:bizmate/providers/pos_provider.dart';
import 'package:get/get.dart';
import '../model/cart_model.dart';

class CartController extends GetxController {
  final items = <CartModel>[].obs;
  final _authC = Get.find<AuthController>();
  final inventC = Get.find<InventoryController>();
  final _posProvider = Get.find<PosProvider>();
  final isLoading = false.obs;
  
  final tax = 12000;
  final service = 5000;
  final paymentMethod = ''.obs;

  int get itemsLength => items.length;

  int get total {
    var harga = 0.obs;
    for (var prod in items) {
      harga += prod.products.harga * prod.qty;
    }
    return harga.value;
  }

  int get totalPrice {
    var harga = 0.obs;
    for (var prod in items) {
      harga += prod.products.harga * prod.qty;
    }
    return harga.value + tax + service;
  }

  int? getQtyInCart(String productId) {
    final prodQty = items
        .firstWhereOrNull((element) => element.products.id == productId)
        .obs;

    return prodQty.value?.qty ?? 0;
  }

  void addQty(String prodId) {
    final itemsIndex = items.indexWhere((prod) => prod.products.id == prodId);

    if (itemsIndex != -1) {
      items[itemsIndex].qty++;
      items.refresh();
    }
  }

  void removeQty(String prodId) {
    final itemsIndex = items.indexWhere((prod) => prod.products.id == prodId);

    if (itemsIndex != -1) {
      if (items[itemsIndex].qty > 1) {
        items[itemsIndex].qty--;
        items.refresh();
      } else {
        items.removeAt(itemsIndex);
      }
    }
  }

  void addCartProduct(InventoryModel product) {
    final existingProductIndex = items.indexWhere(
      (prod) => prod.products.id == product.id,
    );

    if (existingProductIndex != -1) {
      items[existingProductIndex].qty++;

      items.refresh();
    } else {
      items.add(CartModel(products: product, qty: 1));
    }
  }

  Future<void> transactionUser() async {
    if(items.isEmpty) return;

    isLoading.value = true;
    try {

      final totalBayar = totalPrice;

     final transactionId = await _posProvider.addTransaction(
        _authC.user.value!.uid,
        totalBayar,
        items,
        paymentMethod.value,
      );

      isLoading.value = false;
      items.clear();
      paymentMethod.value = '';
      Get.toNamed(PaymentSuccess.routeName, arguments: {
        'transactionId': transactionId,
        'date': DateTime.now(), 
        'total': totalBayar,
      });
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Gagal', 'Gagal melakukan Transaksi: $error');
    }
  }
}
