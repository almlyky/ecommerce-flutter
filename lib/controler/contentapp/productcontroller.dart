import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:eccommerce_new/data/model/cartmodel.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:get/get.dart';
import '../../core/my_classes/statusrequest.dart';
import '../../core/my_function/handledata.dart';

class Productcontroller extends GetxController
 {
  Cartcontroller cartcontroller = Get.put(Cartcontroller());
  homepagecontrolerimp homecontroller = Get.find();

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
  // late TabController tabController;
  Settingcontroller settingcontroller = Get.find();

  initquantity(int productid) {
    for (CartModel elemelnt in cartcontroller.dataCartModels) {
      if (elemelnt.prFk!.prId == productid) {
        quantity = elemelnt.quantity!;
      }
    }
  }

  getproduct(int catid) async {
    dataproductCategoristModel.clear();
    statusRequestCatProduct = StatusRequest.loading;
    var response = await controldata
        .getData("$djproduct/$catid/${settingcontroller.userid}/");
    statusRequestCatProduct = handlingData(response);
    if (StatusRequest.success == statusRequestCatProduct) {
      List<ProductModel> products = response.map<ProductModel>((item) {
        return ProductModel.fromJson(item);
      }).toList();
      dataproductCategoristModel.addAll(products);
    }
    else if (statusRequestCatProduct == StatusRequest.offlineFailure) {
      Get.rawSnackbar(
        message: "لا يوجد اتصال بالانترنت",
      );
    }
    update();
  }

  updatequantity(String event) {
    if (event == "plus") {
      quantity++;
    } else if (event == "minus") {
      if (quantity > 1) quantity--;
    }
    update();
  }

}
