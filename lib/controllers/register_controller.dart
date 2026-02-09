import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  late TextEditingController regisBusiness;
  late TextEditingController regisUsername;
  late TextEditingController regisEmail;
  late TextEditingController regisPass;

  final visibilityRegis = false.obs;

  @override
  void onInit() {
    regisBusiness = TextEditingController();
    regisUsername = TextEditingController();
    regisEmail = TextEditingController();
    regisPass = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    regisBusiness.dispose();
    regisUsername.dispose();
    regisEmail.dispose();
    regisPass.dispose();
    super.onClose();
  }
}