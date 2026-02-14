import 'package:bizmate/controllers/inventory_controller.dart';
import 'package:bizmate/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Inventory extends GetView<InventoryController> {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inventory',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.account_circle_rounded,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsGeometry.all(12),
                child: TextField(
                  onChanged: (value) {
                    controller.keywordSearch.value = value;
                  },
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        style: BorderStyle.solid,
                        width: 0.9,
                      ),
                    ),
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: Divider()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsGeometry.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL VALUE',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            FormatCurrency.toRupiah(controller.allPriceProduct),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOW STOCK',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              color: Colors.blueGrey,
                            ),
                          ),

                          SizedBox(height: 5),

                          if (controller.lowStokItem != null)
                            Row(
                              children: [
                                Text(
                                  '${controller.lowStokItem?.stok} Items',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 3),
                                Icon(
                                  Icons.warning,
                                  size: 15,
                                  color: Colors.red,
                                ),
                              ],
                            )
                          else
                            Text('-'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Products (${controller.productLegnth})',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      'Sort by',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final data = controller.displayProduct[index];
                return ListTile(
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        height: 500,
                        width: double.infinity,
                        padding: EdgeInsetsGeometry.all(12),
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 230,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(data.gambar),
                                  fit: BoxFit.cover
                                  ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            Divider(),
                            SizedBox(height: 8,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(data.nama, style: TextStyle(
                                fontFamily: 'Poppons',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              
                              ),),
                            ),
                            SizedBox(height: 5,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('#${data.sku}', style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),),
                            ),
                            Expanded(child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(onPressed: (){
                                    Get.toNamed('/add', arguments: data.id);
                                  }, child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(width: 2,),
                                      Text('Edit'),
                                    ],
                                  )),
                                ),
                                SizedBox(width: 8,),
                                Expanded(
                                  child: ElevatedButton(onPressed: (){
                                    controller.deleteProduct(data.id!);
                                  }, 
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent.shade700,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete),
                                      SizedBox(width: 2,),
                                      Text('Delete Product'),
                                    ],
                                  )),
                                )
                              ],
                            ))
                          ],
                        ),
                      )
                    );
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(data.gambar, width: 50, fit: BoxFit.cover,),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(data.nama, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold
                        ),)),
                      Text(FormatCurrency.toRupiah(data.harga), style: TextStyle(
                        color: Theme.of(context).colorScheme.primary
                      ),)
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('#${data.sku}', style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),),
                      SizedBox(height: 5,),
                      if(data.stok < 5 && data.stok != 0)
                      Container(
                        width: 95,
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.production_quantity_limits_rounded, color: Colors.red, size: 15,),
                            SizedBox(width: 2,),
                            Text('${data.stok} in stock', style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      )
                      else if(data.stok > 5)
                      Container(
                        width: 95,
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${data.stok} in stock', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary
                            ),)
                          ],
                        ),
                        )
                        else if(data.stok == 0)
                        Container(
                          width: 95,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(10)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Out of stock', style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),)),
                        )
                    ],
                  ),
                  );
              }, childCount: controller.displayProduct.length),
            ),
          ],
        );
      }),
      floatingActionButton: IconButton(onPressed: () {
        Get.toNamed('/add');
      }, 
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      icon: Icon(Icons.add, size: 35,)),
    );
  }
}
