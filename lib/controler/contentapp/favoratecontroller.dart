import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:eccommerce_new/data/model/favoritemodel.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/my_classes/statusrequest.dart';
import '../../core/my_function/handledata.dart';

class Favoratecontroller extends GetxController {

  List<FavoriteModel> dataFavoriteModel = [];
  late StatusRequest statusRequest;
  Controldata controldata = Controldata();
  Settingcontroller settingcontroller = Get.find();

  getFavorite() async {
    dataFavoriteModel.clear();
    statusRequest = StatusRequest.loading;
    var response =
        await controldata.getData("$favoriteList/${settingcontroller.userid}/");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      List<FavoriteModel> favorite = response.map<FavoriteModel>((item) {
        return FavoriteModel.fromJson(item);
      }).toList();
      dataFavoriteModel.addAll(favorite);
    }
    update();
  }

  addFavorite({required int productID}) async {
    if (settingcontroller.userid != null) {
      statusRequest = StatusRequest.loading;
      var data = {
        "user_fk": "${settingcontroller.userid}",
        "pr_fk": "$productID"
      };
      var response = await controldata.addData(
          insert_Fav, data, settingcontroller.accesstoken!);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        FavoriteModel favoriteModel = FavoriteModel.fromJson(response);
        dataFavoriteModel.add(favoriteModel);
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("تم اضافة المنتج من المفضلة ",
                style: TextStyle(color: Colors.white)));
        // dataFavorite.add(response);
      }
      update();
    } else {
      Get.toNamed(AppRoute.login);
    }
  }

  removeFavorite({required int productID}) async {
    statusRequest = StatusRequest.loading;

    var response = await controldata.deleteData(
        "$delete_Fav/$productID/${settingcontroller.userid}/",
        settingcontroller.accesstoken!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      dataFavoriteModel
          .removeWhere((element) => element.prFk!.prId == productID);
      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم حذف المنتج من المفضلة ",
              style: TextStyle(
                color: Colors.white,
              )));
      // dataFavorite.addAll(response);
    }
    update();
  }

  Map<int, int> isfavorate = {};
  setfavorate(id, value) {
    isfavorate[id] = value;
  }

  onTapFavorite(ProductModel productModel) {
    if (isfavorate[productModel.prId] == 0) {
      setfavorate(productModel.prId, 1);
      addFavorite(productID: productModel.prId!);
    } else {
      setfavorate(productModel.prId, 0);
      removeFavorite(productID: productModel.prId!);
    }
    update();
  }

  @override
  void onInit() {
    getFavorite();
    super.onInit();
  }
}
