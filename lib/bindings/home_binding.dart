import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:bizmate/providers/dashboard_provider.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut(() => DashboardProvider(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}