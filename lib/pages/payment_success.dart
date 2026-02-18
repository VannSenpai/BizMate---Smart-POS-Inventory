import 'package:bizmate/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});
  static const routeName = '/paymentSuccess';

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;

    final id = args['transactionId'];
    final date = args['date'];
    final total = args['total'];

    final dateTime = DateFormat("MMM dd, yyyy • HH:mm").format(date);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Payment Success',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                width: 170,
                height: 170,
                child: LottieBuilder.asset(
                  'assets/lottie/SuccessCheck.json',
                  repeat: false,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Transaction Successful!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'Payment has been processed securely.',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    // Baris Transaction ID
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transaction ID',
                          style: TextStyle(color: Colors.grey),
                        ),
                        // Tampilkan sebagian ID (Karena ID Firestore panjang)
                        Text(
                          '#BZ-${id.substring(0, 6).toUpperCase()}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const Divider(height: 30),

                    // Baris Date & Time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date & Time',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          dateTime,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const Divider(height: 30),

                    // Baris Total Paid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Paid',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          FormatCurrency.toRupiah(
                            total,
                          ), 
                          style: TextStyle(
                            color: Color(0xff00A86B),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 180,
                  padding: EdgeInsetsGeometry.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.greenAccent.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.safety_check_outlined,
                        size: 15,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Verified By BizMate Secure',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/home');
              },
              child: Text('Back To Dashboard'),
            ),
          ),
        ),
      ),
    );
  }
}
