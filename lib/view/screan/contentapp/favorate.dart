import 'package:eccommerce_new/controler/contentapp/favoratecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/product/cardproduct.dart';

class favorate extends StatelessWidget {
  const favorate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("favorite".tr)),
        body: GetBuilder<Favoratecontroller>(
            builder: (controller) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                childAspectRatio: 0.8,
              ),
              itemCount: controller.dataFavoriteModel.length,
              itemBuilder: (context, i) {
                return InkWell(
                  child: myProductCard(
                    productModel: controller.dataFavoriteModel[i].prFk!,
                  ),
                );
              });
        }));
  }
}
