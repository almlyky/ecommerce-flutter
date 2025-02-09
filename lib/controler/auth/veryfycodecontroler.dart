import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class veryfycodecontroler extends GetxController {
  late TextEditingController code;
  gotoveryfycode();
}

class veryfycodecontrolerimp extends veryfycodecontroler {
  @override
  @override
  void onInit() {
    code = TextEditingController();
    super.onInit();
  }



  @override
  void dispose() {
    code.dispose();

    super.dispose();
  }

  @override
  gotoveryfycode() {
    Get.toNamed(AppRoute.signup);
  }
}
