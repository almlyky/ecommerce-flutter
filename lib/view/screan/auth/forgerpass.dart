import 'package:eccommerce_new/controler/auth/forgetpasscontroler.dart';
import 'package:eccommerce_new/view/widget/login/costomtextfiald.dart';
import 'package:eccommerce_new/view/widget/login/custombuttonlogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/my_function/validinput.dart';

class frogetpassowrd extends StatelessWidget {
  const frogetpassowrd({super.key});

  @override
  Widget build(BuildContext context) {
    forgetpassowrdcontrolerimp controler =
        Get.put(forgetpassowrdcontrolerimp());
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              child: Text(
                "Forget passowrd",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          const SizedBox(height: 40),
          customtextfaild(
            valid: (val) {
              return validinput(val!, 10, 100, "email", "");
            },
            typeinput: TextInputType.emailAddress,
            controller: controler.email,
            icon: Icons.email_outlined,
            hint: "email",
            checkpass: false,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                controler.gotoveryfycode();
              },
              child: const Text(
                "veryfy code",
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    ));
  }
}
