import 'package:bizmate/controllers/cart_controller.dart';
import 'package:bizmate/controllers/inventory_controller.dart';
import 'package:bizmate/providers/inventory_provider.dart';
import 'package:bizmate/providers/pos_provider.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => InventoryProvider(), fenix: true);
    Get.lazyPut(() => PosProvider(), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => InventoryController(), fenix: true);
  }
}