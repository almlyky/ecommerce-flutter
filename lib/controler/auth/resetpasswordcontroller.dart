import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Resetpasswordcontroller extends GetxController {
  GlobalKey<FormState> resetform = GlobalKey<FormState>();
  TextEditingController passowrd = TextEditingController();
  TextEditingController confirmpassowrd = TextEditingController();
  late StatusRequest statusRequest;
  Controldata controldata = Controldata();
  late String otp;

  resetpassword() async {
    statusRequest = StatusRequest.loading;
    if (resetform.currentState!.validate()) {
      var response = await controldata.addDataWithoutToken(resetpasswordapi, {
        "password": passowrd.text,
        "confirmpassword": confirmpassowrd.text,
        "otp": otp
      });
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        Get.offNamed(AppRoute.login);
      }
    }
    update();
  }

  @override
  void onInit() {
    otp = Get.arguments['otp'];
    super.onInit();
  }
}
