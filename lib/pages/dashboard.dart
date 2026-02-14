import 'package:bizmate/controllers/auth_controller.dart';
import 'package:bizmate/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    final authC = Get.find<AuthController>();

    final user = authC.user.value!;

    return Center(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            homeC.today,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              color: Color(0xff007E6E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Hello, ${user.displayName}!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),

                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(user.photoURL ?? ''),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 35),

              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Sales",
                            style: TextStyle(
                              color: Color(0xff007E6E),
                              fontFamily: 'Inter',
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Rp 12.000',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
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
                            'Low Stock Items',
                            style: TextStyle(
                              color: Color(0xff007E6E),
                              fontFamily: 'Inter',
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '12',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25,),

              Align(
                alignment: Alignment.centerLeft,
                child: Text('Recent Activities', style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 17.5,
                ),),
              ),

              SizedBox(height: 25,),

              Expanded(child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.receipt_long, color: Colors.blue, size: 28,),
                    title: Text('Order #1024', style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),),
                    subtitle: Text('Just now'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('+ Rp45.000',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                        ),),
                        Text('Credit Card', style: TextStyle(
                          fontSize: 12,
                        ),),
                      ],
                    ),
                  ),

                  SizedBox(height: 15,),

                  ListTile(
                    leading: Icon(Icons.receipt_long, color: Colors.blue, size: 28,),
                    title: Text('Order #1024', style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),),
                    subtitle: Text('Just now'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('+ Rp45.000',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                        ),),
                        Text('Credit Card', style: TextStyle(
                          fontSize: 12,
                        ),),
                      ],
                    ),
                  ),

                  SizedBox(height: 15,),

                  ListTile(
                    leading: Icon(Icons.receipt_long, color: Colors.blue, size: 28,),
                    title: Text('Order #1024', style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),),
                    subtitle: Text('Just now'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('+ Rp45.000',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                        ),),
                        Text('Credit Card', style: TextStyle(
                          fontSize: 12,
                        ),),
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Quick Actions', style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.5,
                  ),),),

                  SizedBox(height: 5,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            IconButton(onPressed: (){
                              Get.toNamed('/add');
                            }, 
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              padding: EdgeInsets.all(15.0),
                              shadowColor: Theme.of(context).colorScheme.primary,
                            ),
                            icon: Icon(Icons.add, color: Colors.white, size: 20,)),
                  
                            SizedBox(height: 5.0,),
                  
                            Text('New Sale', style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
