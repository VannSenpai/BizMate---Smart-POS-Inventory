import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final List<Tab> tabs = [
    const Tab(text: 'Home', icon: Icon(Icons.home_filled),),
    const Tab(text: 'Pos', icon: Icon(Icons.point_of_sale),),
    const Tab(text: 'Inventory', icon: Icon(Icons.inventory),),
  ];

  String today = DateFormat('EEEE, d MMM').format(DateTime.now());
}