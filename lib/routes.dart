import 'package:dartz/dartz.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/midleware.dart';
import 'package:eccommerce_new/view/screan/auth/forgerpass.dart';
import 'package:eccommerce_new/view/screan/auth/login.dart';
import 'package:eccommerce_new/view/screan/auth/resetpassowrd.dart';
import 'package:eccommerce_new/view/screan/auth/signup.dart';
import 'package:eccommerce_new/view/screan/auth/verifycode.dart';
import 'package:eccommerce_new/view/screan/contentapp/HomeScrean.dart';
import 'package:eccommerce_new/view/screan/contentapp/cart.dart';
import 'package:eccommerce_new/view/screan/contentapp/chechout.dart';
import 'package:eccommerce_new/view/screan/contentapp/detailsproduct.dart';
import 'package:eccommerce_new/view/screan/contentapp/favorate.dart';
import 'package:eccommerce_new/view/screan/contentapp/orderdetails.dart';
import 'package:eccommerce_new/view/screan/dashboard/addAds.dart';
import 'package:eccommerce_new/view/screan/dashboard/addCoupon.dart';
import 'package:eccommerce_new/view/screan/dashboard/addcategories.dart';
import 'package:eccommerce_new/view/screan/dashboard/addproduct.dart';
import 'package:eccommerce_new/view/screan/dashboard/categoris.dart';
import 'package:eccommerce_new/view/screan/dashboard/dashhome.dart';
import 'package:eccommerce_new/view/screan/contentapp/homepage.dart';
import 'package:eccommerce_new/view/screan/contentapp/product.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:eccommerce_new/view/screan/contentapp/order.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routeapp = [
  GetPage(
      name: AppRoute.login,
      page: () => const login(),
      middlewares: [Authmiddleware()]),
  GetPage(name: AppRoute.signup, page: () => const signup()),
  GetPage(name: AppRoute.forgerpassowrd, page: () => const frogetpassowrd()),
  GetPage(name: AppRoute.resetpassword, page: () => const Resetpassowrd()),
  GetPage(
      name: AppRoute.verfycodesignup,
      page: () => const Verifycode(
            action: "signup",
          )),
  GetPage(
      name: AppRoute.verfycoderesetpassword,
      page: () => const Verifycode(
            action: "reset_password",
          )),
  GetPage(name: AppRoute.homepage, page: () => const Homescrean()),
  GetPage(name: AppRoute.product, page: () => product()),
  GetPage(name: AppRoute.detailsProduct, page: () => const ProductDetailPage()),
  GetPage(name: AppRoute.dashhome, page: () => const dashhome()),
  GetPage(name: AppRoute.categorishome, page: () => const categoriesdash()),
  GetPage(name: AppRoute.homepage, page: () => const home()),
  GetPage(name: AppRoute.cart, page: () => const cart()),
  GetPage(name: AppRoute.favorite, page: () => const favorate()),
  GetPage(name: AppRoute.checkout, page: () => const Chechout()),
  GetPage(name: AppRoute.order, page: () => const Orders()),
  GetPage(name: AppRoute.orderdetail, page: () => const Orderdetails()),
  GetPage(
      name: AppRoute.insertproduct,
      page: () => const addproduct(typeevent: "add")),
  GetPage(
      name: AppRoute.insertcategories,
      page: () => const addcategories(typeevent: "add")),
  GetPage(
      name: AppRoute.edeteproduct,
      page: () => const addproduct(typeevent: "edete")),
  GetPage(
      name: AppRoute.edetecategories,
      page: () => const addcategories(typeevent: "edete")),
  GetPage(name: AppRoute.addads, page: () => const Addads(action: "add")),
  GetPage(name: AppRoute.editeads, page: () => const Addads(action: "edite")),
  GetPage(name: AppRoute.addcoupon, page: ()=> const Addcoupon())
];
