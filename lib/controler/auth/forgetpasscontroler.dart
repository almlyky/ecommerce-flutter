import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgetpassowrdcontroler extends GetxController {
  late TextEditingController email;
  late GlobalKey<FormState> forgetpasswordform;
  late Controldata controldata;
  late StatusRequest statusRequest;
  bool loading = false;

  @override
  void onInit() {
    email = TextEditingController();
    forgetpasswordform = GlobalKey<FormState>();
    controldata = Controldata();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
 
  forgetpassword() async {
    statusRequest = StatusRequest.loading;
    if (forgetpasswordform.currentState!.validate()) {
      loading = true;
      update();
      var response = await controldata
          .addDataWithoutToken(forgetpasswordapi, {"email": email.text});
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        Get.toNamed(AppRoute.verfycoderesetpassword);
      }
      loading = false;
      update();
    }
  }
}
