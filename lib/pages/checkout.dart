import 'package:bizmate/controllers/checkout_controller.dart';
import 'package:bizmate/pages/payment_success.dart';
import 'package:bizmate/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Checkout extends GetView<CheckoutController> {
  const Checkout({super.key});
  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: Obx(() {
        if(controller.cartC.isLoading.value){
          return Center(child: CircularProgressIndicator(),);
        }
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'PAYMENT METHOD',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: BoxBorder.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 0.5,
                  ),
                ),
                child: RadioListTile<String>(
                  title: const Text(
                    'QRIS / E-Wallet',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Gopay, OVO, Dana, ShopeePay'),
                  activeColor: const Color(0xff00A86B),

                  value: 'QRIS',
                  groupValue: controller.cartC.paymentMethod.value,
                  onChanged: (String? val) {
                    if (val != null) {
                      controller.cartC.paymentMethod.value = val;
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: BoxBorder.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 0.5,
                  ),
                ),
                child: RadioListTile<String>(
                  title: const Text(
                    'Bank Transfer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('BCA, BNI, BJB, BANK JAGO'),
                  activeColor: const Color(0xff00A86B),

                  value: 'Bank Transfer',
                  groupValue: controller.cartC.paymentMethod.value,
                  onChanged: (String? val) {
                    if (val != null) {
                      controller.cartC.paymentMethod.value = val;
                    }
                  },
                ),
              ),

              SizedBox(height: 15),

              Divider(),

              SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ORDER DETAIL',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.blueGrey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          FormatCurrency.toRupiah(controller.cartC.total),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.blueGrey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          FormatCurrency.toRupiah(controller.cartC.tax),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Service',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.blueGrey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          FormatCurrency.toRupiah(controller.cartC.service),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Total Amount',
                  style: TextStyle(fontFamily: 'Inter', color: Colors.blueGrey),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  FormatCurrency.toRupiah(controller.cartC.totalPrice),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  controller.cartC.transactionUser();
                }, child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Confirm Payment'),
                      SizedBox(width: 4,),
                      Icon(Icons.check)
                    ],
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
