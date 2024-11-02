import 'package:eccommerce_new/core/my_function/curd.dart';
import 'package:eccommerce_new/data/remote/favorate_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/my_classes/statusrequest.dart';
import '../../core/my_function/handledata.dart';

class favoratecontroller extends GetxController {
  curd c = curd();

  List dataFavorite = [];
  late StatusRequest statusRequest;
  Favorite_data favorite_data = Favorite_data();

  getFavorite(int userid) async {
    dataFavorite = [];
    statusRequest = StatusRequest.loading;
    var response = await favorite_data.getFavorite(userid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      dataFavorite.addAll(response);
      // print(dataFavorite[0]);
    }
    update();
  }

  addFavorite({required int productID, required int userid}) async {
    statusRequest = StatusRequest.loading;
    var response = await favorite_data.addFavorite(productID, userid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم اضافة المنتج من المفضلة ",
          style: TextStyle(color: Colors.white)));
      dataFavorite.add(response);
    }
    update();
  }

  removeFavorite({required int productID, required int userid}) async {
    statusRequest = StatusRequest.loading;
    var response = await favorite_data.removeFavorite(productID, userid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      dataFavorite
          .removeWhere((element) => element['pr_fk']['pr_id'] == productID);
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
