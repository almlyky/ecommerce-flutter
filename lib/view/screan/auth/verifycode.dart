import 'package:eccommerce_new/controler/auth/signupcontroler.dart';
import 'package:eccommerce_new/controler/auth/verifycodecontroler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class Verifycode extends StatelessWidget {
  final String action;
  const Verifycode({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    Verifycodecontroler verifycodecontroler = Get.put(Verifycodecontroler());
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        
        children: [
          // SizedBox(height: 100),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              child: Text("verification_code".tr,
                  style: Theme.of(context).textTheme.displayMedium),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "enter_code".tr,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          OtpTextField(
            numberOfFields: 6,
            borderColor: const Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            onSubmit: (String verificationCode) {
              verifycodecontroler.otp = verificationCode;
            }, // end onSubmit
          ),
          SizedBox(height: 10),
          GetBuilder<Verifycodecontroler>(builder: (controller) {
            if (verifycodecontroler.errorotp.isNotEmpty) {
              return Text(
                verifycodecontroler.errorotp,
                style: TextStyle(color: Colors.red),
              );
            }
            return SizedBox();
          }),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                verifycodecontroler.chechoTp(action);
              },
              child: Text("confirm".tr)),
        ],
      ),
    )
    );
  }
}
