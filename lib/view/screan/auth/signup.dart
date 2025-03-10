import 'package:eccommerce_new/controler/auth/signupcontroler.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/view/widget/login/costomtextfiald.dart';
import 'package:eccommerce_new/view/widget/login/custombuttonlogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import '../../../controler/auth/logincontrolers.dart';
import '../../../core/my_function/validinput.dart';

class signup extends StatelessWidget {
  const signup({super.key});

  @override
  Widget build(BuildContext context) {
    bool visible = false;
    Signupcontroler controler = Get.put(Signupcontroler());
    // Logincontrolers contrllog=Get.put(Logincontrolers());

    return Scaffold(
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<Signupcontroler>(
            builder: (controller) => Form(
              key: controler.formsignup,
              child: ListView(
                children: [
                  // Container(
                  //     margin: EdgeInsets.only(top: 70),
                  //     child: const CircleAvatar(
                  //       radius: 50,
                  //       child: Icon(
                  //         Icons.person,
                  //         size: 50,
                  //       ),
                  //     )),
                  SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Text("signup".tr,
                          style: Theme.of(context).textTheme.displayLarge),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(child: Text("welcom_sign".tr)),

                  const SizedBox(
                    height: 60,
                  ),

                  //textfield username
                  customtextfaild(
                      valid: (val) {
                        return validinput(val!, 6, 100, "username");

                        // return validinput(
                        //     val!, 6, 100, "username", controler.erroremail);
                      },
                      typeinput: TextInputType.text,
                      controller: controler.username,
                      hint: "username".tr,
                      checkpass: false,
                      icon: Icons.person),
                  const SizedBox(
                    height: 20,
                  ),

                  //textfield email
                  customtextfaild(
                      errorText: controler.errorText,
                      valid: (val) {
                        return validinput(val!, 6, 100, "email");
                      },
                      typeinput: TextInputType.emailAddress,
                      controller: controler.email,
                      hint: "email".tr,
                      checkpass: false,
                      icon: Icons.email),
                  const SizedBox(
                    height: 20,
                  ),

                  //textfield password
                  customtextfaild(
                      valid: (val) {
                        return validinput(val!, 6, 100, "password");
                      },
                      typeinput: TextInputType.text,
                      controller: controler.passowrd,
                      hint: "password".tr,
                      checkpass: true,
                      icon: Icons.lock_open_outlined),
                  const SizedBox(
                    height: 20,
                  ),

                  //textfield password
                  customtextfaild(
                      valid: (val) {
                        return validinput(val!, 6, 100, "password");
                      },
                      typeinput: TextInputType.text,
                      controller: controler.confirmpassowrd,
                      hint: "confirm_password".tr,
                      checkpass: true,
                      icon: Icons.lock_open_outlined),
                  const SizedBox(
                    height: 40,
                  ),

                  //circle proccessing
                  // GetBuilder<Signupcontroler>(
                  //   init: Signupcontroler(),
                  //   builder: (contr) => Visibility(
                  //     visible: contr.visable,
                  //     child: const Center(child: CircularProgressIndicator()),
                  //   ),
                  // ),

                  //buttons create acounts

                  AbsorbPointer(
                    absorbing: controler.load,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: controller.load
                                ? const Color.fromARGB(255, 140, 139, 139)
                                : Appcolor.buttoncolor),
                        onPressed: () {
                          controler.signupp();
                        },
                        child: controler.load
                            ? Lottie.asset("assets/lottie/loading.json",
                                height: 40, width: 40)
                            : Text("signup".tr)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("have_acount".tr),
                      TextButton(
                          onPressed: () {
                            Get.offNamed(AppRoute.login);
                          },
                          child: Text("login".tr))
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
