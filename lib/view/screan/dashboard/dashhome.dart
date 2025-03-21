import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/controler/dashboard/dashhomecontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/serveces/serveces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashhome extends StatelessWidget {
  const Dashhome({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => homepagecontrolerimp(), fenix: true);
    Get.lazyPut(() => Settingcontroller(), fenix: true);
    setteng controller = Get.find();
    Dashhomecontroller dashhomecontroller = Get.put(Dashhomecontroller());


    return Scaffold(
      appBar: AppBar(
        title: Text("dashboard".tr),
        actions: [
          IconButton(
              onPressed: () {
                controller.shared.remove("rule");
                Get.toNamed(AppRoute.login);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
          ),
          itemCount: dashhomecontroller.grid.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Get.to(dashhomecontroller.page[i]);
              },
              child: Card(
                  // color: Colors.lightBlue,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Icon(dashhomecontroller.icons[i]),
                  Text(dashhomecontroller.grid[i]),
                ],
              )),
            );
          }),
    );
  }
}
