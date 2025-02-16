import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/crud.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/model/cartmodel.dart';
import 'package:eccommerce_new/data/remote/cartdata.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  CartData cartData = CartData();
  int totalPrice = 0;
  List dataCart = [];
  List<CartModel> dataCartModels = [];

  List dataCoupon = [];
  late StatusRequest statusRequest;
  int discount = 0;

  late StatusRequest statusRequestCoupon;
  TextEditingController couponName = TextEditingController();
  Controldata controldata = Controldata();
  Settingcontroller settingcontroller = Get.find();

  // Map<int, Map> data = {};

  getdatacart() async {
    dataCart.clear();
    statusRequest = StatusRequest.loading;
    var response = await controldata.getData("$cartList/${settingcontroller.userid}/");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      List<CartModel> cartList = response.map<CartModel>((cart) {
        int prCost = cart['pr_fk']['pr_cost'];
        totalPrice += prCost;
        // print(prCost);
        return CartModel.fromJson(cart);
      }).toList();
      dataCartModels.addAll(cartList);
      // dataCart.addAll(response);
    }
    update();
  }

  addcart(
      {required int productID,
      required int quantity}) async {
    statusRequest = StatusRequest.loading;
    var response = await controldata.addData(
        insertcart,
        {"user_fk": "${settingcontroller.userid}", "pr_fk": "$productID", "quantity": "$quantity"},
        settingcontroller.accesstoken!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      CartModel cartModel = CartModel.fromJson(response['data']);
      if (response['status'] == "exist") {
        for (var element in dataCartModels) {
          if (element.prFk!.prId == productID) {
            element.quantity = cartModel.quantity;
            // int price = response['data']['pr_fk']['pr_cost'];
            totalPrice += cartModel.prFk!.prCost!;
          }
        }
      } else {
        // dataCart.add(response['data']);
        dataCartModels.add(cartModel);
        int price = cartModel.prFk!.prCost!;
        totalPrice += price;
      }
    }
    update();
  }

  deleteAllcart() async {
    statusRequest = StatusRequest.loading;
    var response = await controldata.deleteData(
        "$deleteallcart/${settingcontroller.userid}/", settingcontroller.accesstoken!);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      dataCartModels.clear();
    }
    update();
  }

  removecart(int cartId) async {
    statusRequest = StatusRequest.loading;

    var response = await controldata.deleteData(
        "$deletecart/$cartId/", settingcontroller.accesstoken!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      dataCartModels.removeWhere((element) => element.cartId == cartId);
      // dataCart.removeWhere((element) => element['pr_fk']['pr_id'] == productID);
      initTotal();
    }
    update();
  }

  updatequantity(String action, int cartid) async {
    statusRequest = StatusRequest.loading;
    var response = await controldata.uppdateData("$updatequantity/$cartid/",
        {"action": action}, settingcontroller.accesstoken!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      for (var element in dataCartModels) {
        if (element.cartId == cartid) {
          if (action == "plus") {
            element.quantity = element.quantity! + 1;
            // int price = element['pr_fk']['pr_cost'];
            totalPrice += element.prFk!.prCost!;
          } else if (action == "minus" && element.quantity! > 1) {
            element.quantity = element.quantity! - 1;
            // int price = element['pr_fk']['pr_cost'];
            totalPrice -= element.prFk!.prCost!;
          }
        }
      }
    }
    update();
  }

  initTotal() {
    totalPrice = 0;
    for (var element in dataCart) {
      int price1 = element['pr_fk']['pr_cost'] * element['quantity'];
      totalPrice += price1;
    }
  }

  checkCoupon() async {
    statusRequestCoupon = StatusRequest.loading;
    var response = await controldata.addData(checkcoupon,
        {"co_name": couponName.text}, settingcontroller.accesstoken!);
    //  cartData.checkCoupon(couponName.text);
    statusRequestCoupon = handlingData(response);
    if (statusRequestCoupon == StatusRequest.success) {
      discount = response['data']['co_discount'];
      // if (check == 0) {
      totalPrice -= discount;
      //   check++;
      // }
    } else if (statusRequestCoupon == StatusRequest.failure) {
      discount = 0;
      // initTotal();
      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("the coupon not found or expired !",
              style: TextStyle(
                color: Colors.white,
              )));
    }
    update();
  }

  gotochechout() {
    Get.toNamed(AppRoute.checkout);
  }

  @override
  void onInit() async {
    await getdatacart();
    initTotal();
    super.onInit();
  }
}
