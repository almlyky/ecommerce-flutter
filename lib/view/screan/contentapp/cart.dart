import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/controler/contentapp/ordercontroller.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/data/model/cartmodel.dart';
import 'package:eccommerce_new/view/widget/cart/cardcart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class cart extends StatelessWidget {
  const cart({super.key});
  @override
  Widget build(BuildContext context) {
    Ordercontroller ordercontroller = Get.put(Ordercontroller());
    // double hieght = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("cart product"),
      //   actions: [
      //     TextButton(
      //         onPressed: () {
      //           //  controller.removeall();
      //         },
      //         child: const Text("delete all"))
      //   ],
      // ),
      body: GetBuilder<Cartcontroller>(
        builder: (controller) => Handlingdataview(
            statusRequest: controller.statusRequest,
            widgets: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.dataCartModels.length,
                      itemBuilder: (context, i) {
                        // if (page == "cart" &&
                        // controller.dataCartModels[i].order == 0) {
                        return CardCart(
                          cartModel: controller.dataCartModels[i],
                          // cartcontroller: controller,
                        );
                      }),
                  //   } else if (page == "order" &&
                  //       controller.dataCartModels[i].order! > 0) {
                  //     {
                  //       return controller.dataCartModels[i].order ==
                  //               ordercontroller.orderId
                  //           ? CardCart(
                  //               cartModel: controller.dataCartModels[i],
                  //               // cartcontroller: controller,
                  //             )
                  //           : null;
                  //     }
                  //   } else {
                  //     return const SizedBox.shrink();
                  //   }
                  // }),
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
                  // if (page == "cart")
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    // child: Padding(
                    // padding: const EdgeInsets.symmetric(horizontal: 14),
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
                          // SizedBox()
                          // const Divider(height: 30),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [

                          // Column(
                          //   children: [
                          //     Text("price",
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .displaySmall),
                          //     Text("${controller.totalPrice}\$",
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .displayMedium),
                          //   ],
                          // )
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
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                // topLeft: Radius.circular(10),
                // bottomLeft: Radius.circular(10)
              ))),
          child:  Text('confirm'.tr),
        ),
        // TextFormField(
        //   controller: controller.couponName,
        //   decoration: InputDecoration(
        //     contentPadding: const EdgeInsets.all(10),
        //     hintText: "Add coupon code",
        //       border: OutlineInputBorder(
        //           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft: Radius.circular(10))
        //         ),
        //     // suffixIcon: IconButton(
        //     //   icon: const Icon(Icons.check, color: Appcolor.iconcolor),
        //     //   onPressed: () {
        //     //     controller.checkCoupon();
        //     //   },
        //     // ),
        //   ),
        // ),
        // ElevatedButton(onPressed: (){}, child: Text("Add"))
      ],
    );
  }
}
