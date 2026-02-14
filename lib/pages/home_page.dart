import 'package:bizmate/controllers/home_controller.dart';
import 'package:bizmate/pages/inventory.dart';
import 'package:bizmate/pages/pos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        body: TabBarView(children: [Dashboard(), Pos(), Inventory()]),

        bottomNavigationBar: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: BoxBorder.all(width: 0.5, color: Colors.grey)
            ),
            child: TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorWeight: 5,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              tabs: controller.tabs,
            ),
          ),
        ),
      ),
    );
  }
}
