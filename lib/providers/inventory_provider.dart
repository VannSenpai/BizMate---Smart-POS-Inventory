import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryProvider {
  final CollectionReference _products = FirebaseFirestore.instance.collection('products');

  Stream<QuerySnapshot<Object?>> getProducts() {
    return _products.orderBy('createdAr', descending: false).snapshots();
  }
}