import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/serveces/serveces.dart';
import 'package:eccommerce_new/view/screan/contentapp/HomeScrean.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    setteng controller = Get.find();
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("Setting"),
        // ),
        body: ListView(
      children: [
         UserAccountsDrawerHeader(
          // arrowColor: Appcolor.primary,
          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          accountName:
              Text("accountName", style: TextStyle(color: Colors.black)),
          accountEmail:
              Text("accountEmail", style: TextStyle(color: Colors.black)),
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
        CostumListTile(icon: Icons.help, title: "المساعدة", onTap: () {}),
        CostumListTile(
            icon: Icons.support_agent, title: "الدعم الفني", onTap: () {}),
        CostumListTile(
            icon: Icons.logout,
            title: "تسجيل الخروج",
            onTap: () {
              controller.shared.remove('rule');
              Get.offAllNamed(AppRoute.login);
              Get.deleteAll();
            }),
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
      ],
    ));
  }
}
