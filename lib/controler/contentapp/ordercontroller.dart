import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/model/orderitemmodel.dart';
import 'package:eccommerce_new/data/model/ordermodel.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ordercontroller extends GetxController {
  StatusRequest? statusRequest;
  StatusRequest? statusRequestOrderItem = StatusRequest.loading;
  List<OrderModel> dataOrderModel = [];
  List<OrderItemModel> dataOrderItem = [];
  OrderModel? orderModel;
  Settingcontroller settingcontroller = Get.find();

  int? orderId;

  String selectedValueRadio = "cash";
  setselected(String value) {
    selectedValueRadio = value;
    update();
  }

  String typeorder = "delivery";
  changeTypeOrder(String type) {
    typeorder = type;
    update();
  }

  Controldata controldata = Controldata();
  Cartcontroller cartcontroller = Get.put(Cartcontroller());
  getOrder() async {
    statusRequest = StatusRequest.loading;
    var response = await controldata.getData(Order);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      List<OrderModel> orders = response.map<OrderModel>((order) {
        return OrderModel.fromJson(order);
      }).toList();
      dataOrderModel.addAll(orders);
    }
    else if (statusRequest == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }
    update();
  }

  updataOrder(int id) async {
    statusRequest = StatusRequest.loading;
    var response = await controldata.patchData(
        "$Order$id/", {"status": "delivered"}, settingcontroller.accesstoken!);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      for (int i = 0; i < dataOrderModel.length; i++) {
        if (response['id'] == dataOrderModel[i].id) {
          dataOrderModel[i].status = "delivered";
        }
      }

      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم قبول الطلب",
              style: TextStyle(
                color: Colors.white,
              )));
    }
    else if (statusRequest == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }
    update();
  }

  getOrderDetails(int orderId) async {
    dataOrderItem.clear();
    statusRequestOrderItem = StatusRequest.loading;
    var response = await controldata.getData("$OrderItemList$orderId/");
    statusRequestOrderItem = handlingData(response);
    if (statusRequestOrderItem == StatusRequest.success) {
      List<OrderItemModel> orders = response.map<OrderItemModel>((order) {
        return OrderItemModel.fromJson(order);
      }).toList();
      dataOrderItem.addAll(orders);
    }
    else if (statusRequestOrderItem == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }
    update();
  }

  gotoOrderDetails(int orderId) async {
    Get.toNamed(AppRoute.orderdetail);
    getOrderDetails(orderId);
  }

  addOrder() async {
    statusRequest = StatusRequest.loading;
    var data = {
      "user": "${settingcontroller.userid}",
      "address": "ib alodain",
      "total_order": "${cartcontroller.totalPrice}",
      "order_code": "ABuBDder23",
      "order_type":typeorder,
      "payment_status":selectedValueRadio
    };
    var response =
        await controldata.addData(Order, data, settingcontroller.accesstoken!);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      OrderModel orderModel = OrderModel.fromJson(response);
      dataOrderModel.add(orderModel);
      addOrderItem(orderModel.id!);
    }
    else if (statusRequest == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }
  }

  addOrderItem(int orderId) async {
    statusRequestOrderItem = StatusRequest.loading;
    var products = cartcontroller.dataCartModels.map((element) {
      return {
        "order": "$orderId",
        "product_id": "${element.prFk!.prId}",
        "quantity": "${element.quantity}"
      };
    }).toList();
    // products = Js(products) as List<Map<String, String>>;
    int count = cartcontroller.dataCartModels.length;
    var response = await controldata.addData(OrderItem, products,settingcontroller.accesstoken!);
    statusRequestOrderItem = handlingData(response);
    if (statusRequestOrderItem == StatusRequest.success) {
      await cartcontroller.deleteAllcart();
      List<OrderItemModel> orders = response.map<OrderItemModel>((order) {
        return OrderItemModel.fromJson(order);
      }).toList();
      dataOrderItem.addAll(orders);
      Get.rawSnackbar(
          title: "اشعار",
          messageText: Text("تم اضافة $count المنتجات الى الطلب ",
              style: const TextStyle(
                color: Colors.white,
              )));
    }
    else if (statusRequestOrderItem == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }
    update();
  }

  @override
  void onInit() {
    getOrder();
    // getOrderDetails(orderId)
    super.onInit();
  }
}
