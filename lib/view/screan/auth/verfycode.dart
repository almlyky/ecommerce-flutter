import 'package:eccommerce_new/controler/auth/forgetpasscontroler.dart';
import 'package:eccommerce_new/controler/auth/signupcontroler.dart';
import 'package:eccommerce_new/view/widget/login/costomtextfiald.dart';
import 'package:eccommerce_new/view/widget/login/custombuttonlogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class veryfycode extends StatelessWidget {
  const veryfycode({super.key});

  @override
  Widget build(BuildContext context) {
    forgetpassowrdcontrolerimp controler =
        Get.put(forgetpassowrdcontrolerimp());
    signupcontrolerimp signupcontroller = Get.put(signupcontrolerimp());
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 100),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              child: Text("verifi code",
                  style: Theme.of(context).textTheme.displayMedium),
            ),
          ),
          const SizedBox(height: 40),
          OtpTextField(
            // borderRadius: const BorderRadius.all(Radius.circular(20)),
            numberOfFields: 6,
            borderColor: const Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              signupcontroller.otp = verificationCode;
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AlertDialog(
              //         title: const Text("Verification Code"),
              //         // content: Text('Code entered is $verificationCode'),
              //       );
              //     });
            }, // end onSubmit
          ),
          SizedBox(height: 10),
          GetBuilder<signupcontrolerimp>(builder: (controller) {
            if (signupcontroller.errorotp.isNotEmpty) {
              return Text(
                signupcontroller.errorotp,
                style: TextStyle(color: Colors.red),
              );
            }
            return SizedBox();
          }),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                signupcontroller.chechoTp();
              },
              child: Text("Confirm"))
        ],
      ),
    ));
  }
}
