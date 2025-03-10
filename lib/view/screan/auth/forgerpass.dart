import 'package:eccommerce_new/controler/auth/forgetpasscontroler.dart';
import 'package:eccommerce_new/view/widget/login/costomtextfiald.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/my_function/validinput.dart';

class frogetpassowrd extends StatelessWidget {
  const frogetpassowrd({super.key});

  @override
  Widget build(BuildContext context) {
    Forgetpassowrdcontroler controler = Get.put(Forgetpassowrdcontroler());
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              child: Text(
                "forget_password".tr,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "enter_email_forget".tr,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Form(
            key: controler.forgetpasswordform,
            child: customtextfaild(
              valid: (val) {
                return validinput(
                  val!,
                  6,
                  100,
                  "email",
                );
              },
              typeinput: TextInputType.emailAddress,
              controller: controler.email,
              icon: Icons.email_outlined,
              hint: "email".tr,
              checkpass: false,
            ),
          ),
          const SizedBox(height: 20),
          GetBuilder<Forgetpassowrdcontroler>(
            builder: (controler) => AbsorbPointer(
              absorbing: controler.loading ? true : false,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: controler.loading
                          ? const Color.fromARGB(255, 140, 139, 139)
                          : Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    controler.forgetpassword();
                  },
                  child: Text(
                    "send".tr,
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          )
        ],
      ),
    ));
  }
}
