import 'package:eccommerce_new/controler/auth/signupcontroler.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/view/widget/login/costomtextfiald.dart';
import 'package:eccommerce_new/view/widget/login/custombuttonlogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controler/auth/logincontrolers.dart';
import '../../../core/my_function/validinput.dart';

class signup extends StatelessWidget {
  const signup({super.key});

  @override
  Widget build(BuildContext context) {
    bool visible = false;
    signupcontrolerimp controler = Get.put(signupcontrolerimp());
    // logincontrolersimp contrllog=Get.put(logincontrolersimp());

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: controler.formsignup,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
                  child: const CircleAvatar(
                    radius: 50,
                child: Icon(Icons.person,size: 50,),
              )),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Text("Let's Get Started!",
                      style: Theme.of(context).textTheme.displayMedium),
                ),
              ),
              const SizedBox(
                height: 60,
              ),

              //textfield username
              customtextfaild(
                  valid: (val) {
                    return validinput(
                        val!, 6, 100, "username", controler.erroremail);
                  },
                  typeinput: TextInputType.text,
                  controller: controler.Username,
                  hint: "username".tr,
                  checkpass: false,
                  icon: Icons.person),
              const SizedBox(
                height: 20,
              ),

              //textfield email
              customtextfaild(
                  chech: (val) {
                    controler.erroremail = "";
                  },
                  valid: (val) {
                    return validinput(
                        val!, 6, 100, "email", controler.erroremail);
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
                    return validinput(
                        val!, 6, 100, "password", controler.erroremail);
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
                    return validinput(
                        val!, 6, 100, "password", controler.erroremail);
                  },
                  typeinput: TextInputType.text,
                  controller: controler.cofirmpassowrd,
                  hint: "confirm_password".tr,
                  checkpass: true,
                  icon: Icons.lock_open_outlined),
              const SizedBox(
                height: 40,
              ),

              //circle proccessing
              GetBuilder<signupcontrolerimp>(
                init: signupcontrolerimp(),
                builder: (contr) => Visibility(
                  visible: contr.visable,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),

              //buttons create acounts
              ElevatedButton(
                  onPressed: () {
                    controler.signupp();
                  },
                  child: Text("signup".tr)),
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
      ),
    );
  }
}
