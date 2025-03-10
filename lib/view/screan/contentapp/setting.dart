import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/localization/changelang.dart';
import 'package:eccommerce_new/core/serveces/serveces.dart';
import 'package:eccommerce_new/view/screan/contentapp/HomeScrean.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    setteng controller = Get.find();
    localecontroler localcontroller = Get.put(localecontroler());
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("Setting"),
        // ),
        body: ListView(
      children: [
        UserAccountsDrawerHeader(
          // arrowColor: Appcolor.primary,
          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          accountName: Text(controller.shared.getString("username")!,
              style: TextStyle(color: Colors.black)),
          accountEmail: Text(controller.shared.getString("email")!,
              style: TextStyle(color: Colors.black)),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage("assets/image/logo.jpg"),
          ),
        ),
        CostumListTile(
          title: "change_lang".tr,
          icon: Icons.language,
          onTap: () {
            Get.dialog(
              AlertDialog(
                title: Text('change_lang'.tr),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('English'),
                      onTap: () {
                        localcontroller.changelang('en');
                        // contrllerhom.changeLanguage('en');
                        Get.back();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('العربية'),
                      onTap: () {
                        localcontroller.changelang('ar');
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        CostumListTile(icon: Icons.help, title: "helps".tr, onTap: () {}),
        CostumListTile(
            icon: Icons.support_agent, title: "support".tr, onTap: () {}),
        CostumListTile(
            icon: Icons.logout,
            title: "logout".tr,
            onTap: () {
              controller.shared.remove('rule');
              controller.shared.remove('userId');
              controller.shared.remove('accesstoken');
              Get.offAllNamed(AppRoute.login);
              Get.deleteAll();
            }),
        CostumListTile(
            icon: Icons.shopping_cart,
            title: "order".tr,
            onTap: () {
              Get.toNamed(AppRoute.order);
            }),
        CostumListTile(
            icon: Icons.perm_device_info_rounded,
            title: "version".tr,
            subtitle: "1.3.4",
            onTap: () {})
      ],
    ));
  }
}
