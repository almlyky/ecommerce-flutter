import 'package:eccommerce_new/controler/auth/logincontrolers.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/widget/login/costomtextfiald.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class login extends StatelessWidget {
  const login({super.key});
  @override
  Widget build(BuildContext context) {
    Logincontrolers controler = Get.put(Logincontrolers());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: controler.formstae,
          child: ListView(
            children: [
              SizedBox(
                height: 70,
              ),
              Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 60),
                    child: Text("login".tr,
                        style: Theme.of(context).textTheme.displayLarge)),
              ),
              SizedBox(
                height: 10,
              ),
              Center(child: Text("welcom_login".tr)),
              const SizedBox(
                height: 60,
              ),

              //textfield email
              customtextfaild(
                valid: (val) {
                  return validinput(val!, 6, 60, "username");
                },
                typeinput: TextInputType.emailAddress,
                controller: controler.email,
                hint: "username".tr,
                icon: Icons.person,
                checkpass: false,
              ),
              const SizedBox(
                height: 20,
              ),
              //textfield password
              customtextfaild(
                  valid: (val) {
                    return validinput(val!, 6, 20, "password");
                  },
                  typeinput: TextInputType.text,
                  controller: controler.passowrd,
                  hint: "password".tr,
                  icon: Icons.lock_open_outlined,
                  checkpass: true),

              //textbutton forgetpassword
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                    onPressed: () {
                      controler.gotoforget();
                    },
                    child: Text(
                      textAlign: TextAlign.start,
                      "forget_password".tr,
                    )),
              ),

              //button login
              GetBuilder<Logincontrolers>(
                builder: (controlerlogin) => AbsorbPointer(
                  absorbing: controler.load,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: controler.load
                            ? const Color.fromARGB(255, 140, 139, 139)
                            : Appcolor.buttoncolor),
                    onPressed: () {
                      controler.login();
                    },
                    child: controlerlogin.load
                        ? SizedBox(
                            height: 50,
                            width: 50,
                            child: Lottie.asset("assets/lottie/loading.json"),
                          )
                        : Text("login".tr),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),

              Center(
                  child: Text(
                "login_using".tr,
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
                      onPressed: () {
                        Get.defaultDialog(
                          title: "نجاح",
                          titleStyle: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          content: Column(
                            children: [
                              Icon(Icons.check_circle,
                                  color: Colors.green, size: 70),
                              SizedBox(height: 10),
                              Text('تمت العملية بنجاح!',
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          // textConfirm: "موافق",
                          confirm: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("موافق")),
                          // confirmTextColor: Colors.white,
                          // textCancel: "إلغاء"
                          // onConfirm: ()=>Get.back()
                        );
                      },
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
                      onPressed: () {
                        controler.loginWithGoogle();
                      },
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
                  Text("dont_have_acount".tr),
                  TextButton(
                      onPressed: () {
                        controler.gotosignup();
                      },
                      child: Text("signup_new".tr))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
