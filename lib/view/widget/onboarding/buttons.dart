import 'package:eccommerce_new/controler/onboardingcontroler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class costombuttononboarding extends GetView<onboardingcontrolerimp> {
  final textbutton;
  const costombuttononboarding(this.textbutton, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {
          controller.nex();
        },
        child: Container(
          width: 200,
          height: 40,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.blue),
          child: Center(
              child: Text(
            textbutton,
            style: TextStyle(color: Colors.white),
          )),
        ));
  }
}
