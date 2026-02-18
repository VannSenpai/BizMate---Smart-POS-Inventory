import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardProvider {
  final CollectionReference _reference = FirebaseFirestore.instance.collection('transaction');

  Stream<QuerySnapshot<Object?>> getTransaction() {
    return _reference.orderBy('tanggal', descending: true).snapshots();
  }
}