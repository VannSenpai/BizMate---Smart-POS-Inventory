import 'package:bizmate/controllers/auth_controller.dart';
import 'package:bizmate/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends GetView<RegisterController> {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final authC = Get.find<AuthController>();
    return Scaffold(
      body: Obx(() {
        if (authC.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsGeometry.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(45),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Icon(
                          Icons.storefront,
                          color: Theme.of(context).colorScheme.primary,
                          size: 40,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Join BizMate to manage your business effectively.',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                    ),

                    SizedBox(height: 25),

                    Form(
                      key: formKey,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Business Name',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            TextFormField(
                              controller: controller.regisBusiness,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value.contains('@') ||
                                    value.contains('#') ||
                                    value.contains('%')) {
                                  return 'Nama business tidak boleh mengandung simbol';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Retailers',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xff007E6E),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xff007E6E),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 15),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Username',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            TextFormField(
                              controller: controller.regisUsername,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value.contains('@') ||
                                    value.contains('#') ||
                                    value.contains('%')) {
                                  return 'Nama tidak boleh mengandung simbol';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'John Doe',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xff007E6E),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xff007E6E),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 15),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Email',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            TextFormField(
                              controller: controller.regisEmail,
                              validator: (value) {
                                if (!GetUtils.isEmail(value!) ||
                                    value.isEmpty) {
                                  return 'Email tidak valid';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'name@Company.com',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xff007E6E),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xff007E6E),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 15),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Password',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            TextFormField(
                              controller: controller.regisPass,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return 'Password terlalu pendek';
                                } else {
                                  return null;
                                }
                              },
                              obscureText: controller.visibilityRegis.value
                                  ? false
                                  : true,
                              decoration: InputDecoration(
                                hintText: '******',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.visibilityRegis.toggle();
                                  },
                                  icon: controller.visibilityRegis.value
                                      ? Icon(
                                          Icons.visibility,
                                          color: Colors.blueGrey,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Colors.blueGrey,
                                        ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xff007E6E),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xff007E6E),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authC.register(
                                      controller.regisUsername.text,
                                      controller.regisEmail.text,
                                      controller.regisPass.text,
                                      controller.regisBusiness.text,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    vertical: 15,
                                  ),
                                ),
                                child: const Text('Register'),
                              ),
                            ),

                            SizedBox(height: 15),

                            Divider(),

                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already have an account?'),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
