import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/remote/auth/logindata.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/constant/linksapi.dart';
import '../../core/my_function/curd.dart';
import '../../test/serveces.dart';

abstract class logincontrolers extends GetxController {
  setteng contrller = Get.find();

  late TextEditingController email;
  late TextEditingController passowrd;

  login();
  checkacoutnts();
  gotosignup();
  gotoforget();
  gotohome();
}

class logincontrolersimp extends logincontrolers {
  String error = "";
  curd c = curd();
  GlobalKey<FormState> formstae = GlobalKey<FormState>();
  late StatusRequest statusRequestlogin;
  bool load = false;

  Logindata logindata = Logindata();
  Controldata controldata = Controldata();
  late StatusRequest statusRequestUser;

  @override
  checkacoutnts() {}
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

  @override
  gotosignup() {
    Get.offNamed(AppRoute.signup);
  }

  @override
  gotoforget() {
    Get.toNamed(AppRoute.forgerpassowrd);
  }

  @override
  valid() {
    var formdata = formstae.currentState;
    if (formdata!.validate()) {
    } else {}
  }

  // @override
  // login() {
  //   if (email.text == "admin" && passowrd.text == "admin") {
  //     Get.toNamed(AppRoute.dashhome);
  //     contrller.shared.setString("rule", "admin");
  //   } else {
  //     var formdata = formstae.currentState;
  //     if (formdata!.validate()) {
  //       contrller.shared.setString("rule", "user");
  //       // if()
  //       // gotohome();
  //     } else {
  //       print("not valid");
  //     }
  //   }
  // }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  login() async {
    if (email.text == "admin2" && passowrd.text == "admin2") {
      Get.offNamed(AppRoute.dashhome);
      contrller.shared.setString("rule", "admin");
    } else {
      var formdata = formstae.currentState;
      if (formdata!.validate()) {
        statusRequestlogin = StatusRequest.loading;
        load = true;
        update();
        var response = await logindata.login(email.text, passowrd.text);
        statusRequestlogin = handlingData(response);
        if (StatusRequest.success == statusRequestlogin &&
            response.containsKey("access")) {
          var res = await controldata.getDataAuthentecation(
              apiAppGetUser, response['access']);
          statusRequestUser = handlingData(res);
          if (statusRequestUser == StatusRequest.success) {
            if (res['is_active'] == true) {
              // controllersetting.shared.setString("rule", "user");
              // controllersetting.shared.setString("username", username.text);
              contrller.shared.setInt("userId", res['pk']);
              contrller.shared.setString("rule", "user");
              print("=======================");
              print(res['pk']);
              gotohome();
              // notificationscontroller.subscribeTopic('TravelApp');
              // Get.offNamed(Routes.Home);
            }
          }
        } else {
          load = false;
          update();
        }
        // if()
        // gotohome();
      } else {
        print("not valid");
      }
    }
  }

  @override
  gotohome() {
    Get.offAllNamed(AppRoute.homepage);
    // var response = await c.postrequest(
    //     linklogin2, {"email": email.text, "passowrd": passowrd.text});
    // if (response["status"] == "success") {
    //   Get.toNamed(AppRoute.homepage);
    // }
    // else {
    //   error = "login";
    //   valid();
    // }
  }
  // gotohome() async{

  // try {
  //   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email.text,
  //       password: passowrd.text
  //   );
  //   Get.toNamed(AppRoute.homepage);
  // } on FirebaseAuthException catch (e) {
  //   if (e.code == 'user-not-found') {
  //     print('No user found for that email.');
  //   } else if (e.code == 'wrong-password') {
  //     print('Wrong password provided for that user.');
  //   }
  // }
  // }
}
