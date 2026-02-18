import 'package:bizmate/model/transaction_model.dart';
import 'package:bizmate/providers/dashboard_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final List<Tab> tabs = [
    const Tab(text: 'Home', icon: Icon(Icons.home_filled)),
    const Tab(text: 'Pos', icon: Icon(Icons.point_of_sale)),
    const Tab(text: 'Inventory', icon: Icon(Icons.inventory)),
  ];
  final allTransaction = <TransactionModel>[].obs;
  final _get = Get.find<DashboardProvider>();

  int get allPrice {
    var price = 0;
    for(var i in allTransaction){
      price += i.total;
    }
    return price;
  }

  String today = DateFormat('EEEE, d MMM').format(DateTime.now());

  @override
  void onInit() {
    getTransactionIn();
    super.onInit();
  }

  void getTransactionIn() async {
    try {
       _get.getTransaction().listen((event) {
        final List<TransactionModel> loadedData = event.docs.map((e) {
          final data = e.data() as Map<String, dynamic>;

          return TransactionModel(
            id: e.id,
            payment: data['metodePembayaran'],
            total: data['totalHarga'],
            time: data['tanggal'],
          );
        }).toList();

        allTransaction.assignAll(loadedData);
      }
      );
    } catch (error) {
      Get.snackbar('Gagal', 'Terjadi kesalahan');
    }
  }
}
