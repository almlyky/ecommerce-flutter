import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/remote/cartdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  CartData cartData = CartData();
  int totalPrice = 0;
  List dataCart = [];
  late StatusRequest statusRequest;

  Map<int, Map> data = {};
  

  getdatacart(int userid) async {
    dataCart.clear();
    statusRequest = StatusRequest.loading;
    var response = await cartData.getCart(userid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      dataCart.addAll(response);
    }
    update();
  }

  addcart(
      {required int productID,
      required int userid,
      required int quantity}) async {
    statusRequest = StatusRequest.loading;
    var response = await cartData.addcart(productID, userid, quantity);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Get.rawSnackbar(
      //     title: "اشعار",
      //     messageText: const Text("تم اضافة المنتج الى السله ",
      //         style: TextStyle(color: Colors.white)));
      if (response['status'] == "exist") {
        for (var element in dataCart) {
          if (element['pr_fk']['pr_id'] == productID) {
            element['quantity'] = response['data']["quantity"];
            int price = response['data']['pr_fk']['pr_cost'];
            totalPrice += price;
          }
        }
      } else {
        dataCart.add(response['data']);
        int price = response['data']['pr_fk']['pr_cost'];
        totalPrice += price;
      }
    }
    update();
  }

  removecart({required int productID, required int userid}) async {
    statusRequest = StatusRequest.loading;
    var response = await cartData.removeCart(productID, userid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      dataCart.removeWhere((element) => element['pr_fk']['pr_id'] == productID);
      initTotal();
      // for (var element in dataCart) {
      //   if (element['pr_fk']['pr_id'] == productID) {
      //     int x = element['pr_fk']['pr_cost'] * element['quantity'];
      //     totalPrice -= x;
      //   }
      // }

      // Get.rawSnackbar(
      //     title: "اشعار",
      //     messageText: const Text("تم حذف المنتج من المفضلة ",
      //         style: TextStyle(
      //           color: Colors.white,
      //         )));
      // dataFavorite.addAll(response);
    }
    update();
  }

  updatequantity(String action, int cartid) async {
    statusRequest = StatusRequest.loading;
    var response = await cartData.updatequantitys(action, cartid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (action == "plus") {
        data[cartid]!['quantity'] += 1;
        int price = data[cartid]!['pr_fk']['pr_cost'];
        totalPrice += price;
      } else if (action == "minus" && data[cartid]!['quantity'] > 1) {
        data[cartid]!['quantity'] -= 1;
        int price = data[cartid]!['pr_fk']['pr_cost'];
        totalPrice -= price;
      }

      // for (var element in dataCart) {
      //   if (element['cart_id'] == cartid) {
      //     if (action == "plus") {
      //       element['quantity'] += 1;
      //       int price = element['pr_fk']['pr_cost'];
      //       totalPrice += price;
      //     } else if (action == "minus" && element['quantity'] > 1) {
      //       element['quantity'] -= 1;
      //       int price = element['pr_fk']['pr_cost'];
      //       totalPrice -= price;
      //     }
      //   }
      // }
      // Get.rawSnackbar(
      //     title: "اشعار",
      //     messageText: const Text("تم حذف المنتج من المفضلة ",
      //         style: TextStyle(
      //           color: Colors.white,
      //         )));
      // // dataFavorite.addAll(response);
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

  @override
  void onInit() async {
    await getdatacart(1);
    initTotal();
    super.onInit();
  }

  // dbase db=new dbase();

  // addcart(String name,String image,int price,int cat_id,int cart_quantity)async{
  //   String sql='''
  //       insert into cart (cat_fk,pr_name,pr_image,pr_price,cart_quantity)
  //       values (${cat_id},'${name}','${image}',${price},${cart_quantity})
  //       ''';
  //  int response=  await db.insertdata(sql);
  //  return response;
  // }

  // getcart()async{
  //   String sql='''
  //       select * from cart
  //       ''';
  //  var response=  await db.readdata(sql);
  //   return response;
  // }

  // removecart(int cart_id)async{
  //   var response=  await db.deletedata("delete from cart where cart_no =${cart_id}");
  //   return response;
  // }

  // removeall()async{
  //   var response=  await db.deletedata("delete from cart");
  //   return response;
  // }

  // updatequntety(int cart_id,String event)async{
  //   var response;
  //   if(event=="plus")
  //    response=  await db.updatedata("update cart set cart_quantity=cart_quantity+1 where cart_no =${cart_id}");
  //   else if(event=="minus") {

  //      response = await db.updatedata(
  //         "update cart set cart_quantity=cart_quantity-1 where cart_no =${cart_id} and cart_quantity>1");
  //   }
  //   return response;
  // }
}
