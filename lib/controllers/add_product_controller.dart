import 'package:bizmate/controllers/auth_controller.dart';
import 'package:bizmate/controllers/inventory_controller.dart';
import 'package:bizmate/providers/inventory_provider.dart';
import 'package:bizmate/utils/format_currency.dart';
import 'package:get/get.dart';
import '../providers/product_provider.dart';
import 'package:flutter/material.dart';

class AddProductController extends GetxController {
  final _productsProvider = Get.find<ProductProvider>();
  final _inventP = Get.find<InventoryProvider>();
  final _inventC = Get.find<InventoryController>();
  final _authC = Get.find<AuthController>();
  String? get userId => _authC.user.value?.uid;
  final isLoading = false.obs;

  late TextEditingController textName;
  late TextEditingController textSku;
  late TextEditingController textPrice;
  late TextEditingController textDescription;
  late TextEditingController textImage;
  Rx<int> stok = 0.obs;

  String? productId = Get.arguments;
  bool isEdit = false;
  late String isEditMode;

  @override
  void onInit() {
    textName = TextEditingController();
    textSku = TextEditingController();
    textPrice = TextEditingController();
    textDescription = TextEditingController();
    textImage = TextEditingController();

    if (productId != null) {
      isEdit = true;

      isEditMode = productId!;
      final prod = _inventC.allProduct.firstWhere(
        (element) => element.id == isEditMode,
      );

      textImage.text = prod.gambar;
      textName.text = prod.nama;
      textPrice.text = FormatCurrency.toRupiah(prod.harga);
      textSku.text = prod.sku;
      textDescription.text = prod.deskripsi!;
      stok.value = prod.stok;
    }

    super.onInit();
  }

  @override
  void onClose() {
    textImage.dispose();
    textName.dispose();
    textSku.dispose();
    textPrice.dispose();
    textDescription.dispose();
    super.onClose();
  }

  Future<void> editProduct(
    String gambar,
    String nama,
    String deskripsi,
    String sku,
    String harga,
    int stok,
  ) async {
    isLoading.value = true;
    try {
      final hargaInt = int.parse(
        harga.replaceAll('.', '').replaceAll(',', '').replaceAll('Rp', ''),
      );

      await _inventP.editProductDoc(
        productId!,
        gambar,
        nama,
        deskripsi,
        sku,
        userId!,
        hargaInt,
        stok,
      );

      Get.back();
      Get.back();

      Get.snackbar(
        'Berhasil',
        'Berhasil melakukan update pada Product $nama',
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Gagal',
        'Gagal Update product $nama, Terjadi kesalahan $error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> addProduct(
    String sku,
    String nama,
    String harga,
    int stok,
    String deskripsi,
    String gambar,
  ) async {
    isLoading.value = true;
    try {
      final hargaInt = int.parse(harga.replaceAll('.', '').replaceAll(',', ''));

      await _productsProvider.addProductProvider(
        sku,
        nama,
        hargaInt,
        stok,
        deskripsi,
        gambar,
        userId!,
      );

      Get.back();
      Get.snackbar('Berhasil', 'Berhasil menambahkan data product');
    } catch (error) {
      Get.snackbar('Gagal', 'Terjadi kesahalan silahkan coba lagi nanti');
      print('Terjadi kesalahan $error');
    } finally {
      isLoading.value = false;
    }
  }

  void tambahStok() {
    stok.value++;
  }

  void kurangStok() {
    if (stok.value > 0) {
      stok.value--;
    }
  }
}
