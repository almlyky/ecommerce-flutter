import 'package:eccommerce_new/controler/auth/resetpasswordcontroller.dart';
import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/widget/login/costomtextfiald.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Resetpassowrd extends StatelessWidget {
  const Resetpassowrd({super.key});

  @override
  Widget build(BuildContext context) {
    Resetpasswordcontroller resetpasswordcontroller =
        Get.put(Resetpasswordcontroller());
    return Scaffold(
      // appBar: AppBar(title: Text(""),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Form(
            key: resetpasswordcontroller.resetform,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("reset_password".tr),
                SizedBox(height: 20),
                customtextfaild(
                    valid: (val) {
                      return validinput(val!, 6, 100, "password");
                    },
                    typeinput: TextInputType.text,
                    controller: resetpasswordcontroller.passowrd,
                    hint: "password_new".tr,
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
                    controller: resetpasswordcontroller.confirmpassowrd,
                    hint: "confirm_password".tr,
                    checkpass: true,
                    icon: Icons.lock_open_outlined),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      resetpasswordcontroller.resetpassword();
                    },
                    child: Text("reset_password".tr))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
