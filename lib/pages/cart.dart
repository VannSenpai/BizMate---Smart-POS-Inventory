import 'package:bizmate/controllers/cart_controller.dart';
import 'package:bizmate/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'checkout.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartC = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              cartC.items.clear();
            },
            child: Text(
              'Clear All',
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
          ),
        ],
      ),
      body: Obx(() {
        cartC.items.length;
        if (cartC.items.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.production_quantity_limits,
                  size: 25,
                  color: Colors.grey,
                ),
                Text(
                  'Belum ada Product niihh!!!...',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final cart = cartC.items[index];
                final qtyCart = cart.qty;

                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            cart.products.gambar,
                            width: 55,
                            height: 55,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 160,
                                  child: Text(
                                    cart.products.nama,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  FormatCurrency.toRupiah(cart.products.harga),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: BoxBorder.all(
                                      width: 0.2,
                                      color: Colors.green.shade200,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cartC.removeQty(cart.products.id!);
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          size: 15,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                      Text('$qtyCart'),
                                      SizedBox(width: 8),
                                      IconButton(
                                        onPressed: () {
                                          cartC.addQty(cart.products.id!);
                                        },
                                        style: IconButton.styleFrom(
                                          backgroundColor: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          tapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.add,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  '${FormatCurrency.toRupiah(cart.products.harga)} / unit',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: cartC.itemsLength),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(
        () => Container(
          padding: EdgeInsets.all(20),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  Text(
                    FormatCurrency.toRupiah(cartC.total),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),

              if(cartC.items.isNotEmpty)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Checkout.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Proceed to Payment',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
