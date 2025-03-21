import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/core/localization/changelang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        GetBuilder<localecontroler>(
          builder: (local) => ElevatedButton(
            onPressed: () {
              controller.checkCoupon();
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: local.language.languageCode == "ar"
                      ? Radius.circular(10)
                      : Radius.circular(0),
                  topLeft: local.language.languageCode == 'ar'
                      ? Radius.circular(10)
                      : Radius.circular(0),
                  bottomRight: local.language.languageCode == 'ar'
                      ? Radius.circular(0)
                      : Radius.circular(10),
                  topRight: local.language.languageCode == 'ar'
                      ? Radius.circular(0)
                      : Radius.circular(10),
                  // topLeft: Radius.circular(10),
                  // bottomLeft: Radius.circular(10)
                ))),
            child: Text('confirm'.tr),
          ),
        ),
      ],
    );
  }
}
