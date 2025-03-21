import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/serveces/serveces.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Authmiddleware extends GetMiddleware {
  setteng contrller = Get.find();
  @override
  RouteSettings? redirect(String? s) {
    if (contrller.shared.getString("rule") == "user") {
      return const RouteSettings(name: AppRoute.homepage);
    }
    if (contrller.shared.getString("rule") == "admin") {
      return const RouteSettings(name: AppRoute.dashhome);
    }
    if(contrller.shared.getString("rule") == "login"){
      return const RouteSettings(name: AppRoute.login);
    }
    return null;
  }
}

class Onboardingmiddleware extends GetMiddleware {
  setteng contrller = Get.find();
  @override
  RouteSettings? redirect(String? s) {
    if (contrller.shared.getBool("onboarding") == false) {
      return const RouteSettings(name: AppRoute.login);
    }
    return null;
  }
}