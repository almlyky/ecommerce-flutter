import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/crud.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/model/cartmodel.dart';
import 'package:eccommerce_new/data/remote/cartdata.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  CartData cartData = CartData();
  int totalPrice = 0;
  List dataCart = [];
  List<CartModel> dataCartModels = [];

  List dataCoupon = [];
  late StatusRequest statusRequest;
  int discount = 0;


  late StatusRequest statusRequestCoupon;
  TextEditingController couponName = TextEditingController();
  Controldata controldata = Controldata();

  // Map<int, Map> data = {};

  getdatacart(int userid) async {
    dataCart.clear();
    statusRequest = StatusRequest.loading;
    var response = await cartData.getCart(userid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      List<CartModel> cartList = response.map<CartModel>((cart) {
        int prCost = cart['pr_fk']['pr_cost'];
        totalPrice += prCost;
        // print(prCost);
        return CartModel.fromJson(cart);
      }).toList();
      dataCartModels.addAll(cartList);
      // dataCart.addAll(response);
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
      CartModel cartModel = CartModel.fromJson(response['data']);

      // Get.rawSnackbar(
      //     title: "اشعار",
      //     messageText: const Text("تم اضافة المنتج الى السله ",
      //         style: TextStyle(color: Colors.white)));
      if (response['status'] == "exist") {
        // for (var element in dataCartMo) {
        //   if (element['pr_fk']['pr_id'] == productID) {
        //     element['quantity'] = response['data']["quantity"];
        //     int price = response['data']['pr_fk']['pr_cost'];
        //     totalPrice += price;
        //   }
        // }

        for (var element in dataCartModels) {
          if (element.prFk!.prId == productID) {
            element.quantity = cartModel.quantity;
            // int price = response['data']['pr_fk']['pr_cost'];
            totalPrice += cartModel.prFk!.prCost!;
          }
        }
      } else {
        // dataCart.add(response['data']);
        dataCartModels.add(cartModel);
        int price = cartModel.prFk!.prCost!;
        totalPrice += price;
      }
    }
    update();
  }

  deleteAllcart(int userId) async {
    statusRequest = StatusRequest.loading;
    var response = await controldata.deleteData("$deleteallcart/$userId/");
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      dataCartModels.clear();
    }
    update();
  }

  removecart(int cartId) async {
    statusRequest = StatusRequest.loading;

    var response = await controldata.deleteData("$deletecart/$cartId/");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      dataCartModels.removeWhere((element) => element.cartId == cartId);
      // dataCart.removeWhere((element) => element['pr_fk']['pr_id'] == productID);
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
      // if (action == "plus") {
      //   data[cartid]!['quantity'] += 1;
      //   int price = data[cartid]!['pr_fk']['pr_cost'];
      //   totalPrice += price;
      // } else if (action == "minus" && data[cartid]!['quantity'] > 1) {
      //   data[cartid]!['quantity'] -= 1;
      //   int price = data[cartid]!['pr_fk']['pr_cost'];
      //   totalPrice -= price;
      // }
      // if (action == "plus") {
      //   data[cartid]!['quantity'] += 1;
      //   int price = data[cartid]!['pr_fk']['pr_cost'];
      //   totalPrice += price;
      // } else if (action == "minus" && data[cartid]!['quantity'] > 1) {
      //   data[cartid]!['quantity'] -= 1;
      //   int price = data[cartid]!['pr_fk']['pr_cost'];
      //   totalPrice -= price;
      // }
      for (var element in dataCartModels) {
        if (element.cartId == cartid) {
          if (action == "plus") {
            element.quantity = element.quantity! + 1;
            // int price = element['pr_fk']['pr_cost'];
            totalPrice += element.prFk!.prCost!;
          } else if (action == "minus" && element.quantity! > 1) {
            element.quantity = element.quantity! - 1;
            // int price = element['pr_fk']['pr_cost'];
            totalPrice -= element.prFk!.prCost!;
          }
        }
      }
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

  // int check = 0;
  checkCoupon() async {
    statusRequestCoupon = StatusRequest.loading;
    var response = await cartData.checkCoupon(couponName.text);
    statusRequestCoupon = handlingData(response);
    if (statusRequestCoupon == StatusRequest.success) {
      discount = response['data']['co_discount'];
      // if (check == 0) {
      totalPrice -= discount;
      //   check++;
      // }
    } else if (statusRequestCoupon == StatusRequest.failure) {
      discount = 0;
      // initTotal();
      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("the coupon not found or expired !",
              style: TextStyle(
                color: Colors.white,
              )));
    }
    update();
  }

  gotochechout() {
    Get.toNamed(AppRoute.checkout);
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
