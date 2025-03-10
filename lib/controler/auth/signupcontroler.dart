import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signupcontroler extends GetxController {
  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController passowrd;
  late TextEditingController confirmpassowrd;
  GlobalKey<FormState> formsignup = GlobalKey<FormState>();
  late StatusRequest statusRequestsignup;
  // String erroremail = "";
  bool visable = false;
  int? userId;
  bool load = false;
  String? errorText;

  Controldata controldata = Controldata();
  StatusRequest? statusRequest;

  @override
  void onInit() {
    confirmpassowrd = TextEditingController();
    username = TextEditingController();
    email = TextEditingController();
    passowrd = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    passowrd.dispose();
    confirmpassowrd.dispose();
    super.dispose();
  }

  signupp() async {
    var formdata = formsignup.currentState;
    if (formdata!.validate()) {
      statusRequestsignup = StatusRequest.loading;
      load = true;
      errorText = null;
      update();
      var response = await controldata.addDataWithoutToken(djsignup, {
        "username": username.text,
        "password": passowrd.text,
        "confirmPassword": confirmpassowrd.text,
        "email": email.text
      });
      // print(response);
      statusRequestsignup = handlingData(response);
      load = false;
      update();
      if (StatusRequest.success == statusRequestsignup) {
        if (response["status"] == "successfuly") {
          userId = response['user']['pk'];
          Get.toNamed(AppRoute.verfycodesignup);
          // return null;
        } else {
          // errorText = response["message"];
          Get.rawSnackbar(
              // title: "اشعار",
              backgroundColor: Colors.white,
              messageText: Text(response["message"],
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 0, 0),
                  )));
        }
      }
    }
    update();
  }
}
