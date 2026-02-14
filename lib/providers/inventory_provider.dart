import 'package:bizmate/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryProvider {
  final CollectionReference _products = FirebaseFirestore.instance.collection(
    'products',
  );

  Stream<QuerySnapshot<Object?>> getProducts() {
    return _products.orderBy('createdAt', descending: false).snapshots();
  }

  Future<void> delete(String id) async {
    try{
      await _products.doc(id).delete();
    }catch(error){
      throw Exception('Terjadi kesalahan');
    }
  }

  Future<void> editProductDoc(
    String id,
    String gambar,
    String nama,
    String deskripsi,
    String sku,
    String userId,
    int harga,
    int stok,
  ) async {
    try {
      final data = ProductModel(
        sku: sku,
        nama: nama,
        harga: harga,
        stok: stok,
        deskripsi: deskripsi,
        gambar: gambar,
        userId: userId,
        createdAt: FieldValue.serverTimestamp(),
      );
      await _products.doc(id).update(data.toMap());
    } catch (error) {
      throw Exception('Gagal: terjadi kesalahan $error');
    }
  }
}
