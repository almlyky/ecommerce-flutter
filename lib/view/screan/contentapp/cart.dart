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
        builder: (controller) => Handlingdataview(
            statusRequest: controller.statusRequest,
            widgets: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.dataCart.length,
                  itemBuilder: (context, i) {
                    controller.data[controller.dataCart[i]['cart_id']] =
                        controller.dataCart[i];
                    return CardCart(
                      cartModel: CartModel.fromJson(controller.dataCart[i]),
                      // cartcontroller: controller,
                    );
                  },
                ),
                // Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         Text("Total Pice",
                //             style: Theme.of(context).textTheme.displayMedium),
                //         Text("${controller.totalPrice}\$",
                //             style: Theme.of(context).textTheme.displaySmall),
                //       ],
                //     ),
                //     SizedBox(
                //         width: 300,
                //         child: ElevatedButton(
                //             onPressed: () {}, child: const Text("check out"))),
                //     const SizedBox(height: 10)
                //   ],
                // )
                Card(
                  child: Column(
                    children: [
                      TextFormField(
                        
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                            hintText: "Add coupon code",
                            suffixIcon: Icon(Icons.discount),
                            border: InputBorder.none),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(  onPressed: (){}, child: Text("check out")),
                            Column(children: [
                              Text("price",style: Theme.of(context).textTheme.displaySmall),
                              Text("${controller.totalPrice}\$",style: Theme.of(context).textTheme.displayMedium),
                            ],)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
