import 'dart:async';

import 'package:bizmate/controllers/auth_controller.dart';
import 'package:bizmate/model/inventory_model.dart';
import 'package:bizmate/providers/inventory_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class InventoryController extends GetxController {
  final _provider = Get.find<InventoryProvider>();
  final allProduct = <InventoryModel>[].obs;
  final displayProduct = <InventoryModel>[].obs;
  final isLoading = false.obs;
  StreamSubscription<QuerySnapshot>? _streamSubscription;
  final keywordSearch = ''.obs;
  final _authC = Get.find<AuthController>();
  String? get userId => _authC.user.value?.uid; 

  @override
  void onInit() {
    getAllProduct();

    debounce(keywordSearch, (key) {
      searchProduct(key);
    }, time: Duration(milliseconds: 500));
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }

  Future<void> deleteProduct(String id) async {
    final existingId = allProduct.indexWhere((element) => element.id == id);

    if (existingId > 0) {
      InventoryModel? existingProduct = allProduct[existingId];
      allProduct.removeAt(existingId);

      try {
        await _provider.delete(id);
        existingProduct = null;

        Get.back();
        Get.snackbar(
          'Berhasil',
          'Berhasil menghapus Product',
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Colors.white,
        );
      } catch (error) {
        allProduct.insert(existingId, existingProduct!);
        Get.snackbar('Gagal', 'Tidak Bisa Menghapus Data Product ini');
      }
    } else {
      Get.snackbar('Gagal', 'Product tidak di temukan');
    }
  }

  void getAllProduct() {
    try {
      isLoading.value = true;

      _streamSubscription?.cancel();

      _streamSubscription = _provider.getProducts(userId!).listen((event) {
        final List<InventoryModel> loadedMenu = event.docs.map((e) {
          final data = e.data() as Map<String, dynamic>;

          return InventoryModel(
            id: e.id,
            gambar: data['gambar'] ?? '',
            nama: data['nama'] ?? 'Unkown',
            sku: data['sku'] ?? 'SKU',
            deskripsi: data['deskripsi'] ?? '-',
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

  get lowStokItem {
    var firstItem = allProduct.firstWhereOrNull((element) => element.stok < 5);

    return firstItem;
  }

  int get allPriceProduct {
    var productPrice = 0;

    for (var product in allProduct) {
      productPrice += (product.harga * product.stok);
    }

    return productPrice;
  }

  int get productLegnth {
    return allProduct.length;
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
