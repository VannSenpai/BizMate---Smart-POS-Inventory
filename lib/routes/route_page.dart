import 'package:bizmate/bindings/register_binding.dart';
import 'package:bizmate/pages/home_page.dart';
import 'package:bizmate/pages/register.dart';
import 'package:get/get.dart';

class RoutePage {
  static final route = [
    GetPage(
      name: '/register',
      page: () => Register(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(milliseconds: 300),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];
}
