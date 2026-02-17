import 'package:bizmate/controllers/cart_controller.dart';
import 'package:bizmate/utils/format_currency.dart';
import 'package:bizmate/widgets/cart_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart.dart';

class Pos extends GetView<CartController> {
  const Pos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Point of Sale',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(
            () => CartBadge(
              value: '${controller.itemsLength}',
              child: IconButton(
                onPressed: () {
                  Get.toNamed(
                    Cart.routeName
                  );
                },
                icon: Icon(
                  Icons.shopping_bag,
                  color: Theme.of(context).colorScheme.primary,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        controller.items.length;
        if (controller.inventC.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsetsGeometry.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 15)),

              SliverToBoxAdapter(child: Divider()),

              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final data = controller.inventC.allProduct[index];
                  final qtyInCart = controller.getQtyInCart(
                    controller.inventC.allProduct[index].id!,
                  );

                  return Card(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              child: Image.network(
                                data.gambar,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (qtyInCart != 0)
                              Positioned(
                                left: 10,
                                top: 6,
                                child: Container(
                                  padding: EdgeInsetsGeometry.only(
                                    left: 6,
                                    right: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '$qtyInCart in cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                data.nama,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  FormatCurrency.toRupiah(data.harga),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.addCartProduct(data);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }, childCount: controller.inventC.allProduct.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
              ),
            ],
          ),
        );
      }),

      bottomNavigationBar: Obx(() {
        if (controller.items.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                FormatCurrency.toRupiah(controller.total),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              SizedBox(width: 5),

                              Text('/ ${controller.itemsLength} items'),
                            ],
                          ),
                        ],
                      ),
                      TextButton(onPressed: () {
                        Get.toNamed(Cart.routeName);
                      }, child: Text('View Cart')),
                    ],
                  ),

                  SizedBox(height: 8,),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_checkout),
                          SizedBox(width: 5),
                          Text('Checkout'),
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
