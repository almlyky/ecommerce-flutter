import 'package:eccommerce_new/controler/auth/logincontrolers.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/screan/auth/signup.dart';
import 'package:eccommerce_new/view/widget/login/costomtextfiald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../widget/login/custombuttonlogin.dart';
import '../../widget/onboarding/buttons.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    logincontrolersimp controler = Get.put(logincontrolersimp());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: controler.formstae,
          child: ListView(
            children: [
              Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: Text("5".tr,
                        style: Theme.of(context).textTheme.displayMedium)),
              ),
              const SizedBox(
                height: 60,
              ),

              //textfield email
              customtextfaild(
                chech: (val) {
                  controler.error = "";
                },
                valid: (val) {
                  return validinput(val!, 5, 50, "username", controler.error);
                },
                typeinput: TextInputType.emailAddress,
                controller: controler.email,
                hint: "6".tr,
                icon: Icons.person,
                checkpass: false,
              ),
              const SizedBox(
                height: 20,
              ),
              //textfield password
              customtextfaild(
                  chech: (val) {
                    controler.error = "";
                  },
                  valid: (val) {
                    return validinput(
                        val!, 5, 100, "password", controler.error);
                  },
                  typeinput: TextInputType.text,
                  controller: controler.passowrd,
                  hint: "7".tr,
                  icon: Icons.lock_open_outlined,
                  checkpass: true),

              //textbutton forgetpassword
              const SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        controler.gotoforget();
                      },
                      child: Text(
                        "8".tr,
                      ))),

              //button login
              GetBuilder<logincontrolersimp>(
                builder: (controlerlogin) => ElevatedButton(
                    onPressed: () {
                      controler.login();
                    },
                    child: controlerlogin.load
                        ? SizedBox(
                            height: 50,
                            width: 50,
                            child: Lottie.asset("assist/lottie/loading.json"),
                          )
                        : Text("9".tr)),
              ),
              const SizedBox(
                height: 40,
              ),

              Center(
                  child: Text(
                "10".tr,
                style: const TextStyle(color: Colors.grey),
              )),
              const SizedBox(
                height: 20,
              ),

              //buttons authintecation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //  button facebook
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                      ),
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "f",
                            style: TextStyle(fontSize: 30, fontFamily: "Cairo"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "facebook",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),

                  //button google
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),

                        backgroundColor: Colors.red,
                        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                      ),
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "G",
                            style: TextStyle(fontSize: 30, fontFamily: "Cairo"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Google",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              //textbutton signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("11".tr),
                  TextButton(
                      onPressed: () {
                        controler.gotosignup();
                      },
                      child: Text("12".tr))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
