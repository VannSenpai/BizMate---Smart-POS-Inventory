import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  Future<AppService> init() async {
    await Firebase.initializeApp();
    return this;
  }
}