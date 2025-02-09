import 'package:eccommerce_new/controler/contentapp/refreshalldatacontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/test/serveces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescrean extends StatelessWidget {
  const Homescrean({super.key});

  @override
  Widget build(BuildContext context) {
    setteng contrller = Get.find();
    homepagecontrolerimp contrllerhom = Get.put(homepagecontrolerimp());
    DataController dataController = Get.put(DataController());
    return GetBuilder<homepagecontrolerimp>(
      // init: homepagecontrolerimp(),
      builder: (contrllerhome) => RefreshIndicator(
        onRefresh: dataController.fetchData,
        child: Scaffold(
          // resizeToAvoidBottomInset: true,
          drawer: Drawer(
            child: ListView(children: [
              UserAccountsDrawerHeader(
                // arrowColor: Appcolor.primary,
                decoration: BoxDecoration(color: Appcolor.primary),
                accountName: Text("accountName"),
                accountEmail: Text("accountEmail"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assist/image/logo.jpg"),
                ),
              ),
              CostumListTile(
                title: "تغيير اللغة",
                icon: Icons.language,
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('تغيير اللغة'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: const Text('إنجليزية'),
                            onTap: () {
                              // contrllerhom.changeLanguage('en');
                              Get.back();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: const Text('العربية'),
                            onTap: () {
                              // contrllerhom.changeLanguage('ar');
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              CostumListTile(
                  icon: Icons.help, title: "المساعدة", onTap: () {}),
              CostumListTile(
                  icon: Icons.support_agent,
                  title: "الدعم الفني",
                  onTap: () {}),
              CostumListTile(icon: Icons.logout, title: "تسجيل الخروج", onTap: () {}),
              CostumListTile(
                  icon: Icons.shopping_cart,
                  title: "طلباتي",
                  onTap: () {
                    Get.toNamed(AppRoute.order);
                  }),
              CostumListTile(
                  icon: Icons.perm_device_info_rounded,
                  title: "الإصدار",
                  subtitle: "1.3.4",
                  onTap: () {})
            ]),
          ),
          appBar: AppBar(
            title: Text(
              'Shopping APP',
              // style: TextStyle(color: Colors.blue),
            ),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     // Image.asset('assist/image/im1.png', height: 40), // ضع صورة شعارك هنا
            //     SizedBox(width: 8),
            //     Text(
            //       'Shopping APP',
            //       // style: TextStyle(color: Colors.blue),
            //     ),
            //   ],
            // ),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            contrller.shared.remove('rule');
                            Get.offAllNamed(AppRoute.login);
                            Get.deleteAll();
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
