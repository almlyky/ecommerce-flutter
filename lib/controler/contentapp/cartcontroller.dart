import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/model/cartmodel.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  int totalPrice = 0;
  List<CartModel> dataCartModels = [];

  late StatusRequest statusRequest;
  int discount = 0;
  RxInt cartcount = 0.obs;
  late StatusRequest statusRequestCoupon;
  TextEditingController couponName = TextEditingController();
  Controldata controldata = Controldata();
  Settingcontroller settingcontroller = Get.find();

  getdatacart() async {
    statusRequest = StatusRequest.loading;
    var response =
        await controldata.getData("$cartList/${settingcontroller.userid}/");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      List<CartModel> cartList = response.map<CartModel>((cart) {
        return CartModel.fromJson(cart);
      }).toList();
      dataCartModels.addAll(cartList);
      cartcount.value = dataCartModels.length;
      initTotal();
    } else if (statusRequest == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }
    update();
  }

  addcart({required int productID, required int quantity}) async {
    statusRequest = StatusRequest.loading;
    var response = await controldata.addData(
        insertcart,
        {
          "user_fk": "${settingcontroller.userid}",
          "pr_fk": "$productID",
          "quantity": "$quantity"
        },
        settingcontroller.accesstoken!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      CartModel cartModel = CartModel.fromJson(response['data']);
      if (response['status'] == "exist") {
        for (var element in dataCartModels) {
          if (element.prFk!.prId == productID) {
            element.quantity = cartModel.quantity;
            totalPrice += cartModel.prFk!.prCost!;
          }
        }
      } else {
        dataCartModels.add(cartModel);
        cartcount.value += 1;
        int price = cartModel.prFk!.prCost!;
        totalPrice += price;
      }
    } else if (statusRequest == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }
    update();
  }

  deleteAllcart() async {
    statusRequest = StatusRequest.loading;
    var response = await controldata.deleteData(
        "$deleteallcart/${settingcontroller.userid}/",
        settingcontroller.accesstoken!);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      dataCartModels.clear();
      totalPrice = 0;
      cartcount = 0.obs;
    }
    update();
  }

  removecart(int cartId) async {
    statusRequest = StatusRequest.loading;

    var response = await controldata.deleteData(
        "$deletecart/$cartId/", settingcontroller.accesstoken!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // CartModel cartModel=
      dataCartModels.removeWhere((element) => element.cartId == cartId);
      cartcount.value -= 1;

      initTotal();
    } else if (statusRequest == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }

    update();
  }

  updatequantitys(String action, int cartid) async {
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
            totalPrice -= element.prFk!.prCost!;
          }
        }
      }
    }
    else if (statusRequest == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }
    update();
  }

  initTotal() {
    totalPrice = 0;
    for (var element in dataCartModels) {
      int price1 = element.prFk!.prCost! * element.quantity!;
      totalPrice += price1;
    }
  }

  checkCoupon() async {
    statusRequestCoupon = StatusRequest.loading;
    var response = await controldata.addData(checkcoupon,
        {"co_name": couponName.text}, settingcontroller.accesstoken!);
    statusRequestCoupon = handlingData(response);
    if (statusRequestCoupon == StatusRequest.success) {
      discount = response['data']['co_discount'];
    } else if (statusRequestCoupon == StatusRequest.failure) {
      discount = 0;
      Get.rawSnackbar(
          title: "اشعار",
          messageText: Text("the_coupon_not_exist_or_is_expired".tr,
              style: TextStyle(
                color: Colors.white,
              )));
    }
    else if (statusRequestCoupon == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }
    update();
  }

  gotochechout() {
    discount = 0;
    Get.toNamed(AppRoute.checkout);
  }

  @override
  void onInit() {
    getdatacart();
    super.onInit();
  }
}
