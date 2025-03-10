import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/remote/auth/logindata.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/constant/linksapi.dart';
import '../../core/serveces/serveces.dart';

class Logincontrolers extends GetxController {
  setteng contrller = Get.find();

  late TextEditingController email;
  late TextEditingController passowrd;
  String error = "";
  GlobalKey<FormState> formstae = GlobalKey<FormState>();
  late StatusRequest statusRequestlogin;
  bool load = false;

  Logindata logindata = Logindata();
  Controldata controldata = Controldata();
  late StatusRequest statusRequestUser;

  @override
  void onInit() {
    email = TextEditingController();
    passowrd = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    passowrd.dispose();
    super.dispose();
  }



  gotosignup() {
    Get.offNamed(AppRoute.signup);
  }

  gotoforget() {
    Get.offNamed(AppRoute.forgerpassowrd);
  }

  gotohome() {
    Get.offAllNamed(AppRoute.homepage);
  }

  // signin in firebase with google acount
  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    }
    return null;
  }

  // signin in App with google acount
  loginWithGoogle() async {
    statusRequestlogin = StatusRequest.loading;
    var user = await signInWithGoogle();
    var response = await controldata.signinWithgoogle(user!);
    statusRequestlogin = handlingData(response);
    if (statusRequestlogin == StatusRequest.success) {
      contrller.shared.setInt("userId", response['pk']);
      contrller.shared.setString("rule", "user");
      contrller.shared.setString("accesstoken", response["access_token"]);
      gotohome();
    } else {
      Get.rawSnackbar(
          title: "إشعار",
          messageText: Text("يوجد خطأ ",
              style: const TextStyle(
                color: Colors.white,
              )));
    }
  }

  // signin in App with email and password
  login() async {
    var formdata = formstae.currentState;
    if (formdata!.validate()) {
      statusRequestlogin = StatusRequest.loading;
      load = true;
      update();
      // print(djlogin);
      var response = await controldata.addDataWithoutToken(
          djlogin, {"username": email.text, "password": passowrd.text});
      statusRequestlogin = handlingData(response);
      if (StatusRequest.success == statusRequestlogin &&
          response.containsKey("access")) {
        var res = await controldata.getDataAuthentecation(
            apiAppGetUser, response['access']);
        statusRequestUser = handlingData(res);
        if (statusRequestUser == StatusRequest.success) {
          if (res['is_active'] == true && res['is_staff'] == false) {
            contrller.shared.setInt("userId", res['pk']);
            contrller.shared.setString("username", res['username']);
            contrller.shared.setString("email", res['email']);
            contrller.shared.setString("rule", "user");
            contrller.shared.setString("accesstoken", response["access"]);
            gotohome();
          } else if (res['is_active'] == true && res['is_staff'] == true) {
            contrller.shared.setString("rule", "admin");
            contrller.shared.setInt("userId", res['pk']);
            contrller.shared.setString("username", res['username']);
            contrller.shared.setString("email", res['email']);
            contrller.shared.setString("accesstoken", response["access"]);
            Get.offNamed(AppRoute.dashhome);
          }
        }
      } else {
        load = false;
        update();
      }
    }
  }
}
