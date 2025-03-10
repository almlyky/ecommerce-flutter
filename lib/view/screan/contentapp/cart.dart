import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/core/localization/changelang.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/view/widget/cart/cardcart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class cart extends StatelessWidget {
  const cart({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cart".tr),
        actions: [
          TextButton(
              onPressed: () {
              },
              child:  Text("delete_all".tr))
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
                    child: Container(
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
                              Text("${controller.totalPrice} ريال",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                            ],
                          ),
                          // SizedBox(height: 10),
                          // const Divider(
                          //   height: 30,
                          // ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("discount".tr,
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                              Text("${controller.discount} ريال",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "total_after".tr,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Text("${controller.totalPrice} ريال",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                            ],
                          ),
                        
                        ],
                      ),
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

class CouponTextField extends StatelessWidget {
  final Cartcontroller controller;
  const CouponTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // localecontroler local=Get.find();
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller.couponName,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              hintText: 'coupon_hint'.tr,
              fillColor: const Color.fromARGB(255, 233, 234, 237),
              filled: true,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        // SizedBox(width: 10),
        GetBuilder<localecontroler>(builder: (local) => 
           ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                   bottomLeft: local.language.languageCode == "ar" ? Radius.circular(10) : Radius.circular(0),
                  topLeft: local.language.languageCode== 'ar' ? Radius.circular(10) : Radius.circular(0),
                  bottomRight:local.language.languageCode == 'ar' ? Radius.circular(0) : Radius.circular(10),
                 topRight: local.language.languageCode == 'ar' ? Radius.circular(0) : Radius.circular(10),
                  // topLeft: Radius.circular(10),
                  // bottomLeft: Radius.circular(10)
                ))),
            child:  Text('confirm'.tr),
          ),
        ),
      ],
    );
  }
}
