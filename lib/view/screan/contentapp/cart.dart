import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/data/model/cartmodel.dart';
import 'package:eccommerce_new/view/widget/cart/cardcart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class cart extends StatelessWidget {
  const cart({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("cart product"),
        actions: [
          TextButton(
              onPressed: () {
                //  controller.removeall();
              },
              child: const Text("delete all"))
        ],
      ),
      body: GetBuilder<Cartcontroller>(
        init: Cartcontroller(),
        builder: (controller) => Handlingdataview(
            statusRequest: controller.statusRequest,
            widgets: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.dataCart.length,
                  itemBuilder: (context, i) {
                    return CardCart(
                      cartModel: CartModel.fromJson(controller.dataCart[i]),
                      cartcontroller: controller,
                    );
                  },
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Total Pice",
                            style: Theme.of(context).textTheme.displayMedium),
                        Text("${controller.totalPrice}\$",
                            style: Theme.of(context).textTheme.displaySmall),
                      ],
                    ),
                    SizedBox(
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("check out"))),
                    const SizedBox(height: 10)
                  ],
                )
              ],
            )),
      ),
    );
  }
}
