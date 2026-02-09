import 'package:bizmate/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<AuthController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Center(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(50),
                      border: BoxBorder.all(
                        width: 0.5,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.storefront,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  SizedBox(height: 15),

                  Text(
                    'BizMate',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Welcome back, please login to your \naccount.',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(fontSize: 15, color: Color(0xff007E6E)),
                  ),

                  SizedBox(height: 20),

                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
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
                            controller: controller.emailC,
                            validator: (String? value) {
                              if(GetUtils.isEmail(value!)){
                                return null;
                              } else{
                                return 'Email Tidak Valid';
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xff007E6E),
                              ),
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
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

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
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
                            controller: controller.passC,
                            validator: (value) {
                              if(value!.isEmpty || value.length < 6){
                                return 'Password kependekan (Min 6 karakter)';
                              } else {
                                return null;
                              }
                            },
                            obscureText: controller.visibilityPass.value
                                ? false
                                : true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xff007E6E),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.visibilityPass.toggle();
                                },
                                icon: controller.visibilityPass.value
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Color(0xff007E6E),
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Color(0xff007E6E),
                                      ),
                              ),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
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

                          SizedBox(height: 8),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                controller.messageForgotPassword();
                              },
                              child: Text('Forgot Password?'),
                            ),
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.login(
                                  controller.emailC.text,
                                  controller.passC.text,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ),

                          SizedBox(height: 5),

                          Divider(),

                          SizedBox(height: 5),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                              border: BoxBorder.all(width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.signInWithGoogle();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/logo/GoogleLogo.png',
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  Text(
                                    'Sign in With Google',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed('/register');
                                  },
                                  child: Text('Register'),
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
        );
      }),
    );
  }
}
