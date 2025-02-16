import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/curd.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/remote/auth/signupdata.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

abstract class signupcontroler extends GetxController {
  late TextEditingController email;
  late TextEditingController Username;
  late TextEditingController passowrd;
  late TextEditingController confirmpassowrd;
  // gotologin();
  signupp();
}

class signupcontrolerimp extends signupcontroler {
  GlobalKey<FormState> formsignup = GlobalKey<FormState>();
  // curd c = curd();
  // Signupdata signupdata = Signupdata();

  late StatusRequest statusRequestsignup;

  String erroremail = "";
  bool visable = false;
  int? userId;
  String errorotp = "";
  String? otp;

  Controldata controldata = Controldata();
  StatusRequest? statusRequest;

  chechoTp() async {
    statusRequest = StatusRequest.loading;
    // var data={"otp":otp}
    var response = await controldata
        .addDataWithoutToken("$chechotp/$userId/", {"otp": otp});
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      Get.offNamed(AppRoute.login);
    } else {
      errorotp = "tho otp incorrect!";
    }
    update();
  }

  @override
  void onInit() {
    confirmpassowrd = TextEditingController();
    Username = TextEditingController();
    email = TextEditingController();
    passowrd = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    Username.dispose();
    email.dispose();
    passowrd.dispose();
    confirmpassowrd.dispose();
    super.dispose();
  }

  @override

  // signup()async{
  //   try {
  //     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email.text,
  //       password: passowrd.text,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // gotohome() async {
  //
  // }

  @override
  signupp() async {
    var formdata = formsignup.currentState;
    if (formdata!.validate()) {
      statusRequestsignup = StatusRequest.loading;
      var response = await controldata.addDataWithoutToken(djsignup, {
        "username": Username.text,
        "password": passowrd.text,
        "confirmPassword": confirmpassowrd,
        "email": email.text
      });
      // print(response);
      statusRequestsignup = handlingData(response);
      if (StatusRequest.success == statusRequestsignup &&
          response['status'] == "successfuly") {
        userId = response['user']['pk'];
        print(userId);
        Get.toNamed(AppRoute.verfycode);
      }
    } else {
      // visable = false;
      // update();
      // print("not valid");
    }
  }
}
