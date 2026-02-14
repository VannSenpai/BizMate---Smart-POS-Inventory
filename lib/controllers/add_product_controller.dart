import 'package:bizmate/controllers/auth_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../providers/product_provider.dart';

class AddProductController extends GetxController {
  final _productsProvider = Get.find<ProductProvider>();
  final _authC = Get.find<AuthController>();
  String? get userId => _authC.user.value?.uid;
  final isLoading = false.obs;

  late TextEditingController textName;
  late TextEditingController textSku;
  late TextEditingController textPrice;
  late TextEditingController textDescription;
  final stok = 0.obs;
  final imageUrl = ''.obs;

  @override
  void onInit() {
    textName = TextEditingController();
    textSku = TextEditingController();
    textPrice = TextEditingController();
    textDescription = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    imageUrl.value = '';
    textName.dispose();
    textSku.dispose();
    textPrice.dispose();
    textDescription.dispose();
    super.onClose();
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
    if(stok.value > 0){
      stok.value--;
    }
  }
}
