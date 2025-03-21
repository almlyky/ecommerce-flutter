import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/controler/contentapp/favoratecontroller.dart';
import 'package:eccommerce_new/controler/contentapp/refreshalldatacontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescrean extends StatelessWidget {
  const Homescrean({super.key});

  @override
  Widget build(BuildContext context) {
    homepagecontrolerimp contrllerhom = Get.put(homepagecontrolerimp());
    DataController dataController = Get.put(DataController());
    Cartcontroller cartcontroller = Get.put(Cartcontroller());
    Favoratecontroller favoratecontroller=Get.put(Favoratecontroller());
    return GetBuilder<homepagecontrolerimp>(
      builder: (contrllerhome) => RefreshIndicator(
        onRefresh: dataController.fetchData,
        child: Scaffold(
          body: contrllerhom.widgetOptions[contrllerhome.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Appcolor.primary, // لون العنصر المحدد
              onTap: contrllerhome.onItemTapped,
              currentIndex: contrllerhome.selectedIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'homebar'.tr,
                ),
                BottomNavigationBarItem(
                  
                  icon: Obx(
                    () => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.shopping_cart_rounded),
                        ),
                        if (cartcontroller.cartcount.value > 0)
                          Positioned(
                            right: 0,
                            top: -5,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                cartcontroller.cartcount.value.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  label: 'cartbar'.tr,
                ),
                BottomNavigationBarItem(
                  icon: Obx(
                    () => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.favorite),
                        ),
                        if (favoratecontroller.favoriteCount.value > 0)
                          Positioned(
                            right: 0,
                            top: -5,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                favoratecontroller.favoriteCount.value.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  label: 'favorite'.tr,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'settingbar'.tr,
                ),
              ]),
        ),
      ),
    );
  }
}


