import 'package:bizmate/controllers/add_product_controller.dart';
import 'package:bizmate/providers/product_provider.dart';
import 'package:get/get.dart';

class AddProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductProvider());
    Get.lazyPut(() => AddProductController());
  }
}