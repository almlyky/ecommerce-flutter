import 'package:eccommerce_new/core/constant/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class forgetpassowrdcontroler extends GetxController {
  late TextEditingController email;
  gotoveryfycode();
}

class forgetpassowrdcontrolerimp extends forgetpassowrdcontroler {
  @override
  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();

    super.dispose();
  }

  @override
  gotoveryfycode() {
    Get.toNamed(AppRoute.verfycode);
  }
}
