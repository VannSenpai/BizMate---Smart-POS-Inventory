import 'dart:async';

import 'package:bizmate/model/inventory_model.dart';
import 'package:bizmate/providers/inventory_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class InventoryController extends GetxController {
  final _provider = Get.find<InventoryProvider>();
  final allProduct = <InventoryModel>[].obs;
  final displayProduct = <InventoryModel>[].obs;
  final isLoading = false.obs;
  StreamSubscription<QuerySnapshot>? _streamSubscription;
  final keywordSearch = ''.obs;

  @override
  void onInit() {
    debounce(keywordSearch, (key) {
      searchProduct(key);
    }, time: Duration(seconds: 3));
    super.onInit();
  }

  void getAllProduct() {
    try {
      isLoading.value = true;

      _streamSubscription?.cancel();

      _streamSubscription = _provider.getProducts().listen((event) {
        final List<InventoryModel> loadedMenu = event.docs.map((e) {
          final data = e.data() as Map<String, dynamic>;

          return InventoryModel(
            id: e.id,
            gambar: data['gambar'] ?? '',
            nama: data['nama'] ?? 'Unkown',
            sku: data['sku'] ?? 'SKU',
            harga: data['harga'] ?? 0,
            stok: data['stok'] ?? 0,
          );
        }).toList();

        isLoading.value = false;
        if (loadedMenu.isEmpty) {
          allProduct.clear();
          isLoading.value = false;
        } else {
          allProduct.assignAll(loadedMenu);
          displayProduct.assignAll(loadedMenu);
          isLoading.value = false;
        }
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        e.message ?? 'Gagal menagambil data silahkan coba lagi nanti',
      );
    } catch (error) {
      Get.snackbar('Gagal', 'Terjadi kesalahan');
    }
  }

  InventoryModel? get lowStokItem {
    var firstItem = allProduct.firstWhereOrNull((element) => element.stok < 5);
    print(firstItem);
    return firstItem;
  }

  int get allPriceProduct {
    var productPrice = 0;

    for (var product in allProduct) {
      productPrice += product.harga * product.stok;
    }
    print(productPrice);
    return productPrice;
  }

  void searchProduct(String keyword) {
    if (keyword.isEmpty) {
      displayProduct.assignAll(allProduct);
      return;
    }

    final searchResult = allProduct.where((prod) {
      return prod.nama.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    if (searchResult.isEmpty) {
      displayProduct.clear();
    } else {
      displayProduct.assignAll(searchResult);
    }
  }
}
