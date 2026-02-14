import 'package:bizmate/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductProvider {
  final _products = FirebaseFirestore.instance.collection('products');

  Future<void> addProductProvider(
    String sku,
    String nama,
    int harga,
    int stok,
    String? deskripsi,
    String gambar,
    String userId,
  ) async {
    try {
      final data = ProductModel(
        sku: sku,
        nama: nama,
        harga: harga,
        stok: stok,
        deskripsi: deskripsi ?? '-',
        gambar: gambar,
        userId: userId,
        createdAt: FieldValue.serverTimestamp(),
      );

      await _products.add(data.toMap());
    } catch (error) {
      throw Exception('Terjadi Kesalahan: $error');
    }
  }
}
