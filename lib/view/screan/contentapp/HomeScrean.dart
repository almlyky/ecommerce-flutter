import 'package:eccommerce_new/controler/contentapp/refreshalldatacontroller.dart';
import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/serveces/serveces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescrean extends StatelessWidget {
  const Homescrean({super.key});

  @override
  Widget build(BuildContext context) {
    // setteng contrller = Get.find();
    homepagecontrolerimp contrllerhom = Get.put(homepagecontrolerimp());
    DataController dataController = Get.put(DataController());
    return GetBuilder<homepagecontrolerimp>(
      // init: homepagecontrolerimp(),
      builder: (contrllerhome) => RefreshIndicator(
        onRefresh: dataController.fetchData,
        child: Scaffold(
          // resizeToAvoidBottomInset: true,
        
          

          body: contrllerhom.widgetOptions[contrllerhome.selectedIndex],
          // IndexedStack(
          //     index: contrllerhom.selectedIndex,
          //     children: contrllerhom.widgetOptions),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Appcolor.primary, // لون العنصر المحدد
              // unselectedItemColor: Colors.grey,
              onTap: contrllerhome.onItemTapped,
              currentIndex: contrllerhome.selectedIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_rounded),
                  label: 'السلة',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'الإعدادات',
                ),
              ]),
        ),
      ),
    );
  }
}

class CostumListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final subtitle;
  final Function()? onTap;
  const CostumListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }
}
