import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
// import 'package:eccommerce_new/core/constant/linksapi.dart';
// import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_function/curd.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:eccommerce_new/data/model/cartmodel.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

import '../../core/my_classes/statusrequest.dart';
import '../../core/my_function/handledata.dart';
import '../../data/remote/items_data.dart';

class Productcontroller extends GetxController with GetSingleTickerProviderStateMixin {
  Cartcontroller cartcontroller = Get.put(Cartcontroller());
  homepagecontrolerimp homecontroller = Get.find();
  curd c = curd();

  late ProductModel productModel;

  // String? image, name, details;
  // int? cat_id;
  int quantity = 1;

  // ItemsData itemsData = ItemsData();
  List dataProduct = [];
  // List dataProductSearch = [];
  List dataAllProduct = [];
  List<ProductModel> dataproductCategoristModel = [];
  Controldata controldata = Controldata();

  late StatusRequest statusRequestCatProduct;
late TabController tabController;


  initquantity(int productid) {
    for (CartModel elemelnt in cartcontroller.dataCartModels) {
      if (elemelnt.prFk!.prId == productid) {
        quantity = elemelnt.quantity!;
      }
    }
  }

  getproduct(int catid, int userid) async {
    dataproductCategoristModel.clear();
    statusRequestCatProduct = StatusRequest.loading;
    // // print(homecontroller.dataAllProduct)
    // for (ProductModel item in homecontroller.dataproductModels) {
    //   if (item.catFk == catid) {
    //     dataproductCategoristModel.add(item);
    //   }
    // }
    // statusRequestCatProduct = StatusRequest.success;
    // update();
    dataproductCategoristModel.clear();
    statusRequestCatProduct = StatusRequest.loading;
    var response = await controldata.getData("$djproduct/$catid/$userid/");
    statusRequestCatProduct = handlingData(response);
    if (StatusRequest.success == statusRequestCatProduct) {
      List<ProductModel> products = response.map<ProductModel>((item) {
        return ProductModel.fromJson(item);
      }).toList();
      dataproductCategoristModel.addAll(products);
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
    tabController=TabController(length: homecontroller.datacatModel.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    print("+++++++++++++++++++++++++++++++++++++++++++++closed product");
 tabController.dispose();
    super.onClose();
  }
}
