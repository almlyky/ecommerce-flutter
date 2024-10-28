import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/test/serveces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescrean extends StatelessWidget {
  const Homescrean({super.key});

  @override
  Widget build(BuildContext context) {
    setteng contrller = Get.find();

    homepagecontrolerimp contrllerhom = Get.put(homepagecontrolerimp());
    return GetBuilder<homepagecontrolerimp>(
      init: homepagecontrolerimp(),
      builder: (contrllerhome) => Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assist/image/im1.png', height: 40), // ضع صورة شعارك هنا
              SizedBox(width: 8),
              Text(
                'Shopping APP',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: TextButton(
                        onPressed: () {
                          contrller.shared.remove('rule');
                          Get.toNamed('login');
                        },
                        child: const Text("Logout"))),
                const PopupMenuItem(child: Text("Settings"))
              ],
            )
            // CircleAvatar(
            //   radius: 30,
            //   backgroundImage:
            //   AssetImage('assist/image/logo.jpg'), // ضع صورة البروفايل هنا
            // ),
            // SizedBox(width: 16),
          ],
        ),
        body: IndexedStack(
            index: contrllerhom.selectedIndex,
            children: contrllerhom.widgetOptions),
        bottomNavigationBar: BottomNavigationBar(
            onTap: contrllerhome.onItemTapped,
            currentIndex: contrllerhome.selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_rounded),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ]),
      ),
    );
  }
}
