import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/my_function/curd.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:eccommerce_new/data/model/favoritemodel.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:eccommerce_new/data/remote/favorate_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/my_classes/statusrequest.dart';
import '../../core/my_function/handledata.dart';

class favoratecontroller extends GetxController {
  curd c = curd();

  List<FavoriteModel> dataFavoriteModel = [];
  late StatusRequest statusRequest;
  // Favorite_data favorite_data = Favorite_data();
  Controldata controldata = Controldata();

  getFavorite(int userid) async {
    dataFavoriteModel.clear();
    statusRequest = StatusRequest.loading;
    var response = await controldata.getData("$favoriteList/$userid/");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      List<FavoriteModel> favorite = response.map<FavoriteModel>((item) {
        return FavoriteModel.fromJson(item);
      }).toList();
      dataFavoriteModel.addAll(favorite);
    }
    update();
  }

  addFavorite({required int productID, required int userid}) async {
    statusRequest = StatusRequest.loading;
    var data = {"user_fk": "$userid", "pr_fk": "$productID"};
    var response = await controldata.addData(insert_Fav, data);
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
  }

  removeFavorite({required int productID, required int userid}) async {
    statusRequest = StatusRequest.loading;

    var response =
        await controldata.deleteData("$delete_Fav/$productID/$userid/");
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
      addFavorite(productID: productModel.prId!, userid: 1);
    } else {
      setfavorate(productModel.prId, 0);
      removeFavorite(productID: productModel.prId!, userid: 1);
    }
    update();
  }

  @override
  void onInit() {
    getFavorite(1);
    super.onInit();
  }
  // addfavorite(int user_id,int pr_id)async{
  //
  //   update();
  // }

//  removefav(int id)async{
//   var res=await c.deleteData("http://10.0.2.2:8000/pages/deletfav/$id/");
//   update();
// }

// getfavorite()async{
//     var res=await c.getrequest("http://10.0.2.2:8000/pages/fav/");
//     return res;
//   }

  // dbase db=new dbase();
  //
  //
  // addfavorite(String name,String image,String details,int price,int pr_no)async{
  //   String sql='''
  //       insert into favorite (pr_name,pr_image,pr_detail,pr_price,pr_no)
  //       values ('${name}','${image}','${details}',${price},${pr_no})
  //       ''';
  //   int response=  await db.insertdata(sql);
  //   return response;
  // }

  // getfavorite()async{
  //   String sql='''
  //       select * from favorite
  //       ''';
  //   var response=  await db.readdata(sql);
  //   return response;
  // }

  // Future<dynamic> foundfavorite(String product)async{
  //    List<dynamic> fav=await getfavorite();
  //   for(int i=0;i<fav.length;i++){
  //     if(product==fav[i]["pr_name"])
  //       return true;
  //   }
  // }
  //
  // removefavorite(int pr_id)async{
  //   var response=  await db.deletedata("delete from favorite where pr_no =${pr_id}");
  //   return response;
  // }
  //
  // removeall()async{
  //   var response=  await db.deletedata("delete from favorite");
  //   return response;
  // }
}
