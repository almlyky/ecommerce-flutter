import 'package:eccommerce_new/core/constant/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class onboardingcontroler extends GetxController {
  gotologin();
  onpagechanged(int index);
  nex();
}

class onboardingcontrolerimp extends onboardingcontroler {
  late PageController pageController;
  int curentindex = 0;
  @override
  nex() {
    curentindex++;
    pageController.animateToPage(curentindex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    if (curentindex == 4) {
      gotologin();
    }
  }

  @override
  onpagechanged(int index) {
    curentindex = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  gotologin() {
    Get.toNamed(AppRoute.login);
  }
}
