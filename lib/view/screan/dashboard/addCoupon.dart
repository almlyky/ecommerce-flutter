import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/widget/shared/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addcoupon extends StatelessWidget {
  const Addcoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add coupon"),
      ),
      body: GetBuilder<homepagecontrolerimp>(
        builder: (controller) => Form(
          key: controller.forminsertcoupon,
          child: ListView(
            children: [
              CustomTextfild(
                  controller: controller.couponName,
                  hintext: "coupon name",
                  icon: Icons.price_change,
                  validate: (v) {
                    return validinput(v!, 6, 100, "");
                  }),
              CustomTextfild(
                  controller: controller.couponCount,
                  hintext: "coupon count",
                  icon: Icons.price_change,
                  validate: (v) {
                    return validinput(v!, 6, 100, "");
                  }),
              CustomTextfild(
                  controller: controller.couponDiscount,
                  hintext: "coupon discount",
                  icon: Icons.price_change,
                  validate: (v) {
                    return validinput(v!, 6, 100, "");
                  }),
              AbsorbPointer(
                absorbing: true,
                child: InkWell(
                  onTap: () {
                    controller.choseDate(context,controller.couponExpiredDate);
                  },
                  child: CustomTextfild(
                      controller: controller.couponExpiredDate,
                      hintext: "coupon name",
                      icon: Icons.price_change,
                      validate: (v) {
                        return validinput(v!, 6, 100, "");
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
