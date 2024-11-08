import 'package:eccommerce_new/controler/contentapp/favoratecontroller.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/product/cardproduct.dart';

class favorate extends StatelessWidget {
  const favorate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("favorate product")),
        body: GetBuilder<favoratecontroller>(
            // init: favoratecontroller(),
            builder: (controller) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                childAspectRatio: 0.6,
              ),
              itemCount:  controller.dataFavorite.length,
              itemBuilder: (context, i) {
                return InkWell(
                  child: myProductCard(
                    productModel: ProductModel.fromJson(
                        controller.dataFavorite[i]['pr_fk']),
                  ),
                );
              });
          // return ListView.builder(
          //     itemCount: controller.dataFavorite.length,
          //     itemBuilder: (context, i) {
          //       return InkWell(
          //         child: myProductCard(
          //           productModel: ProductModel.fromJson(
          //               controller.dataFavorite[i]['pr_fk']),
          //         ),
          //       );
          //     });
        }));
  }
}
