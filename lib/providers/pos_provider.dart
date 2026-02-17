import 'package:bizmate/model/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PosProvider {
  final _reference = FirebaseFirestore.instance;
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('products');

  Stream<QuerySnapshot<Object?>> getAllProduct() {
    return _collectionReference.orderBy('createdAt', descending: true).snapshots();
  }

  Future<String> addTransaction(
    String id,
    int total,
    List<CartModel> data,
    String transaction,
  ) async {
    final batch = _reference.batch();

    final docTransRef = _reference.collection('transaction').doc();

    final dataTransaction = {
      'idKasir': id,
      'tanggal': FieldValue.serverTimestamp(),
      'totalHarga': total,
      'metodePembayaran': transaction,
      'items': data.map((e) => e.toMap()).toList(),
    };

    batch.set(docTransRef, dataTransaction);

    for (var item in data) {
      final docProduct = _reference
          .collection('products')
          .doc(item.products.id);

      batch.update(docProduct, {'stok': FieldValue.increment(-item.qty)});
    }
    try {
      await batch.commit();
      return docTransRef.id;
    } catch (error) {
      throw Exception('Gagal, Terjadi Kesalahan');
    }
  }
}
