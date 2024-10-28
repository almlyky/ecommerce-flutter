import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
// import 'package:eccommerce_new/core/constant/linksapi.dart';
// import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_function/curd.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

import '../../core/my_classes/statusrequest.dart';
import '../../core/my_function/handledata.dart';
import '../../data/remote/items_data.dart';

class Productcontroller extends GetxController {
  Cartcontroller controller = Get.put(Cartcontroller());
  curd c = curd();

  late ProductModel productModel;

  // String? image, name, details;
  // int? cat_id;
  int quantity = 1;

  ItemsData itemsData = ItemsData();
  List dataProduct = [];
  // List dataProductSearch = [];
  List dataAllProduct = [];

  late StatusRequest statusRequestCatProduct;
  late StatusRequest statusRequestSerch;

  late StatusRequest statusRequestAllProduct;

  initquantity(int productid) {
    for (var elemelnt in controller.dataCart) {
      if (elemelnt['pr_fk']['pr_id'] == productid) {
        quantity = elemelnt['quantity'];
      }
    }
  }

  getproduct(int productId, int userid) async {
    dataProduct = [];
    statusRequestCatProduct = StatusRequest.loading;
    var response = await itemsData.getdataproduct(productId, userid);
    statusRequestCatProduct = handlingData(response);
    if (StatusRequest.success == statusRequestCatProduct) {
      dataProduct.addAll(response);
    }
    update();
  }

  // getallproduct() async {
  //   statusRequestAllProduct = StatusRequest.loading;
  //   var response = await itemsData.getdataAllproduct();
  //   statusRequestAllProduct = handlingData(response);
  //   if (StatusRequest.success == statusRequestAllProduct) {
  //     dataAllProduct.addAll(response);
  //   }
  // }

  updatequantity(String event) {
    if (event == "plus") {
      quantity++;
    } else if (event == "minus") {
      if (quantity > 1) quantity--;
    }
    update();
  }

  // @override
  // getallproductwithfavorite() async {
  //   var res = await c.postrequest(linkfavorite, {});
  //   return res["data"];
  // }
 

  @override
  void onInit() {
    print("+++++++++++++++++++++++++++++++++++++++++++++init product");

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    print("+++++++++++++++++++++++++++++++++++++++++++++closed product");

    super.onClose();
  }
}
