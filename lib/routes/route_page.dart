import 'package:bizmate/bindings/add_products_binding.dart';
import 'package:bizmate/bindings/home_binding.dart';
import 'package:bizmate/bindings/register_binding.dart';
import 'package:bizmate/pages/add_product.dart';
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
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/add', 
      page: () => AddProduct(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(milliseconds: 300),
      binding: AddProductsBinding(),
      ),
  ];
}
