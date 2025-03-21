import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/view/widget/cart/cardcart.dart';
import 'package:eccommerce_new/view/widget/cart/customtextfieldcoupon.dart';
import 'package:eccommerce_new/view/widget/shared/pricetext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class cart extends StatelessWidget {
  const cart({super.key});
  @override
  Widget build(BuildContext context) {
    Cartcontroller cartcontroller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("cart".tr),
        actions: [
          TextButton(
              onPressed: () {
                cartcontroller.deleteAllcart();
              },
              child: Text("delete_all".tr))
        ],
      ),
      body: GetBuilder<Cartcontroller>(
        builder: (controller) => Handlingdataview(
            statusRequest: controller.statusRequest,
            widgets: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.dataCartModels.length,
                      itemBuilder: (context, i) {
                        return CardCart(
                          cartModel: controller.dataCartModels[i],
                        );
                      }),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      spacing: 20,
                      children: [
                        controller.discount == 0
                            ? CouponTextField(controller: controller)
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "coupon".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      Text(controller.couponName.text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium),
                                    ],
                                  ),
                                  const Divider(
                                    height: 20,
                                  )
                                ],
                              ),
                        // const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "total".tr,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            PriceText(price: controller.totalPrice.toDouble())
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("discount".tr,
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            PriceText(
                                price: (controller.discount / 100) *
                                    controller.totalPrice),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "total_after".tr,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            PriceText(
                                price: controller.totalPrice -
                                    (controller.discount / 100) *
                                        controller.totalPrice)
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        controller.gotochechout();
                      },
                      child: Text("check_out".tr)),
                  // )
                ],
              ),
            )),
      ),
    );
  }
}
