import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/serveces/serveces.dart';
import 'package:eccommerce_new/view/screan/auth/login.dart';
import 'package:eccommerce_new/view/screan/dashboard/categoris.dart';
import 'package:eccommerce_new/view/screan/dashboard/order.dart';
import 'package:eccommerce_new/view/screan/dashboard/product.dart';
import 'package:eccommerce_new/view/screan/dashboard/users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class dashhome extends StatelessWidget {
  const dashhome({super.key});
  @override
  Widget build(BuildContext context) {
    // homepagecontrolerimp controllerhome = Get.put(homepagecontrolerimp());
    setteng controller = Get.find();
    List<String> grid = ["Users", "Categories", "product","order"];
    List<Object> page = [
      const usersdash(),
      const categoriesdash(),
      const productdash(),
      const Orderdash()
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                controller.shared.remove("rule");
                Get.toNamed(AppRoute.login);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
            ),
            itemCount: grid.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Get.to(page[i]);
                },
                child: Card(
                    color: Colors.lightBlue,
                    child: Center(child: Text(grid[i]))),
              );
            }),
      ),
    );
  }
}
