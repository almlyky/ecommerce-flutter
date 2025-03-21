import 'package:eccommerce_new/controler/dashboard/dashhomecontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/widget/shared/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addcoupon extends StatelessWidget {
  final String action;
  const Addcoupon({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    homepagecontrolerimp controllerhome = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(action == "add" ? "add_coupon".tr : "edit_coupon".tr),
      ),
      body: GetBuilder<Dashhomecontroller>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Form(
                key: controller.forminsertcoupon,
                child: Column(
                  spacing: 10,
                  children: [
                    CustomTextfild(
                        textInputType: TextInputType.text,
                        controller: controller.couponName,
                        hintext: "enter_coupon".tr,
                        icon: Icons.discount_rounded,
                        validate: (v) {
                          return validinput(v!, 1, 100, "");
                        }),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextfild(
                              textInputType: TextInputType.number,
                              controller: controller.couponCount,
                              hintext: "enter_count_coupon".tr,
                              icon: Icons.confirmation_number,
                              validate: (v) {
                                return validinput(v!, 1, 100, "");
                              }),
                        ),
                        SizedBox(width: 7),
                        Expanded(
                          child: CustomTextfild(
                              textInputType: TextInputType.number,
                              controller: controller.couponDiscount,
                              hintext: "enter_coupon_discount".tr,
                              icon: Icons.attach_money,
                              validate: (v) {
                                return validinput(v!, 1, 100, "");
                              }),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        controllerhome.choseDate(
                            context, controller.couponExpiredDate);
                      },
                      child: AbsorbPointer(
                        absorbing: true,
                        child: CustomTextfild(
                            textInputType: TextInputType.datetime,
                            controller: controller.couponExpiredDate,
                            hintext: "enter_expiry_date_coupon".tr,
                            icon: Icons.date_range_outlined,
                            validate: (v) {
                              return validinput(v!, 6, 100, "");
                            }),
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              action == "add"
                                  ? controller.addCoupon()
                                  : controller.updateCoupon(
                                      controller.couponModel.coId!);
                            },
                            child:
                                Text(action == "add" ? "add".tr : "edite".tr)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
