import 'package:bizmate/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends GetView<AddProductController> {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Product',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.5),
        ),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    AnimatedCrossFade(
                      firstChild: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: Color(0xff007E6E).withOpacity(0.5),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: Color(0xff007E6E),
                              size: 35,
                            ),

                            SizedBox(height: 5.0),

                            Text(
                              'Preview',
                              style: TextStyle(color: Color(0xff007E6E)),
                            ),
                          ],
                        ),
                      ),
                      secondChild: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(controller.imageUrl.value),
                            fit: BoxFit.contain,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: Color(0xff007E6E).withOpacity(0.5),
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      crossFadeState: controller.imageUrl.value.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 1500),
                    ),

                    SizedBox(height: 25),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Image Url',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),

                    SizedBox(height: 5),

                    TextFormField(
                      onChanged: (newValue) {
                        controller.imageUrl.value = newValue;
                      },
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('https')) {
                          return 'Url gambar tidak boleh kosong dan harus link';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.link, color: Color(0xff007E6E)),
                        hintText: 'https/:example.com/product.jpg',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.blueGrey.shade400,
                          fontSize: 13.5,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Color(0xff007E6E),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Product Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),

                    SizedBox(height: 5),

                    TextFormField(
                      controller: controller.textName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama product tidak boleh kosong';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'e.g., Green Tea Latte',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.blueGrey.shade400,
                          fontSize: 13.5,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Color(0xff007E6E),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'SKU',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),

                    SizedBox(height: 5),

                    TextFormField(
                      controller: controller.textSku,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'SKU tdak boleh kosong';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'enter SKU ',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.blueGrey.shade400,
                          fontSize: 13.5,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Color(0xff007E6E),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                TextFormField(
                                  controller: controller.textPrice,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Harga tidak boleh kosong';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Rp 0.00',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.blueGrey.shade400,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Stock Quantity',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 53.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      width: 0.6,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.kurangStok();
                                        },
                                        style: IconButton.styleFrom(),
                                        icon: Icon(Icons.remove, size: 18),
                                      ),

                                      Container(
                                        width: 60,
                                        height: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.symmetric(
                                            vertical: BorderSide(
                                              style: BorderStyle.solid,
                                              width: 0.6,
                                            ),
                                          ),
                                        ),
                                        child: Text('${controller.stok.value}'),
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          controller.tambahStok();
                                        },
                                        icon: Icon(Icons.add, size: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Deskripsi (Opsional)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),

                    TextFormField(
                      controller: controller.textDescription,
                      minLines: 3,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.grey.shade300, width: 1.2),
            ),
          ),
          padding: EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                controller.addProduct(
                  controller.textSku.text,
                  controller.textName.text,
                  controller.textPrice.text,
                  controller.stok.value,
                  controller.textDescription.text,
                  controller.imageUrl.value,
                );
              }
            },
            style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
            child: controller.isLoading.value
                ? CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save, color: Colors.white),

                      SizedBox(width: 5.0),

                      Text('Save Product'),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
