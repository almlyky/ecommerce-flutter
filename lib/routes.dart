import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/midleware.dart';
import 'package:eccommerce_new/view/screan/auth/forgerpass.dart';
import 'package:eccommerce_new/view/screan/auth/login.dart';
import 'package:eccommerce_new/view/screan/auth/signup.dart';
import 'package:eccommerce_new/view/screan/auth/verfycode.dart';
import 'package:eccommerce_new/view/screan/contentapp/HomeScrean.dart';
import 'package:eccommerce_new/view/screan/dashboard/addcategories.dart';
import 'package:eccommerce_new/view/screan/dashboard/addproduct.dart';
import 'package:eccommerce_new/view/screan/dashboard/categoris.dart';
import 'package:eccommerce_new/view/screan/dashboard/dashhome.dart';
import 'package:eccommerce_new/view/screan/contentapp/homepage.dart';
import 'package:eccommerce_new/view/screan/contentapp/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routeapp = [
  GetPage(
      name: AppRoute.login,
      page: () => const login(),
      middlewares: [Authmiddleware()]),
  GetPage(name: AppRoute.signup, page: () => const signup()),
  GetPage(name: AppRoute.forgerpassowrd, page: () => const frogetpassowrd()),
  GetPage(name: AppRoute.verfycode, page: () => const veryfycode()),
  GetPage(name: AppRoute.homepage, page: () => const Homescrean()),
  GetPage(name: AppRoute.product, page: () => product()),
  GetPage(name: AppRoute.dashhome, page: () => const dashhome()),
  GetPage(name: AppRoute.categorishome, page: () => const categoriesdash()),
  GetPage(name: AppRoute.homepage, page: () => const home()),
  GetPage(name: AppRoute.insertproduct,page: () => const addproduct(typeevent: "add")),
  GetPage(name: AppRoute.insertcategories,page: () => const addcategories(typeevent: "add")),
  GetPage(name: AppRoute.edeteproduct,page: () => const addproduct(typeevent: "edete")),
  GetPage(name: AppRoute.edetecategories,page: () => const addcategories(typeevent: "edete"))

];

Map<String, Widget Function(BuildContext)> routeapp2 = {
  AppRoute.login: (context) => const login(),
  AppRoute.signup: (context) => const signup(),
  AppRoute.forgerpassowrd: (context) => const frogetpassowrd(),
  AppRoute.verfycode: (context) => const veryfycode(),
  AppRoute.homepage: (context) => const home(),
  AppRoute.product: (context) => product(),
  AppRoute.dashhome: (context) => const dashhome(),
  AppRoute.categorishome: (context) => const categoriesdash(),
  AppRoute.insertcategories: (context) => const addcategories(typeevent: "add"),
  AppRoute.insertproduct: (context) => const addproduct(typeevent: "add"),
  // AppRoute.edeteproduct: (context) => const addproduct(typeevent: "edete"),
  AppRoute.edetecategories: (context) =>
      const addcategories(typeevent: "edete"),
  AppRoute.edeteproduct: (context) => const addproduct(typeevent: "edete"),
};
