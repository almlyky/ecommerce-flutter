import 'package:dartz/dartz_unsafe.dart';
import 'package:eccommerce_new/core/my_function/curd.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/data/remote/homedata.dart';
import 'package:eccommerce_new/data/remote/items_data.dart';
import 'package:eccommerce_new/view/screan/contentapp/cart.dart';
import 'package:eccommerce_new/view/screan/contentapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/my_classes/statusrequest.dart';
import '../core/my_function/handledata.dart';

class homepagecontrolerimp extends GetxController {
  curd c = curd();
  int selectedIndex = 0;
  Homedata homedata = Homedata();
  ItemsData itemsData = ItemsData();
  bool isSearch = false;

  List dataCat = [];
  List catName = [];
  // List dataProduct = [];
  List dataProductSearch = [];

  late StatusRequest statusRequestCat;
  // late StatusRequest statusRequestCatProduct;
  late StatusRequest statusRequestSearch;

  // late StatusRequest statusRequestAllProduct;

  getcategories() async {
    statusRequestCat = StatusRequest.loading;
    var response = await homedata.getdatacat();
    statusRequestCat = handlingData(response);
    if (StatusRequest.success == statusRequestCat) {
      dataCat.addAll(response);
    }
    for (var items in dataCat) {
      catName.add(items["cat_name"]);
    }
    update();
  }

  searchproduct(int userid, String search) async {
    dataProductSearch = [];
    statusRequestSearch = StatusRequest.loading;
    var response = await itemsData.searchdata(userid, search);
    statusRequestSearch = handlingData(response);
    if (StatusRequest.success == statusRequestSearch) {
      dataProductSearch.addAll(response);
    }
    update();
  }

  @override
  void onInit() {
    print("init cat==========================");
    getcategories();
    super.onInit();
  }

  TextEditingController searchtext = TextEditingController();
  checkSearch(val) {
    if (val == "") {
      isSearch = false;
    }
    update();
  }

  onSearchItems() {
    isSearch = true;
    searchproduct(1, searchtext.text);
    update();
  }

  // getcategories() async{
  //   var respons=await c.getrequest(djcatlist);
  //   return respons;
  // }
  //
  // getallproduct()async{
  //   var response=await c.postrequest(linkproduct2, {});
  //   return response;
  // }
  // getproduct(int id)async{
  //   // String id2=id.toString();
  //   var response=await c.getrequest("$djproduct/$id/");
  //   return response;
  // }
  gotoproduct() {
    Get.toNamed(AppRoute.product);
  }

  List<Widget> widgetOptions = <Widget>[
    const home(),
    const cart(),
    const Text(
      'Index 2: School',
      // style: optionStyle,
    ),
  ];
  onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
