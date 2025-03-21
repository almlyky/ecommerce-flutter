import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/model/couponmodel.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:eccommerce_new/view/screan/dashboard/ads.dart';
import 'package:eccommerce_new/view/screan/dashboard/categoris.dart';
import 'package:eccommerce_new/view/screan/dashboard/coupon.dart';
import 'package:eccommerce_new/view/screan/dashboard/order.dart';
import 'package:eccommerce_new/view/screan/dashboard/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashhomecontroller extends GetxController {
  late StatusRequest statusRequestGetCoupon;
  late StatusRequest statusRequestAddCoupon;
  late StatusRequest statusRequestRemoveCoupon;
  late StatusRequest statusRequestUpdateCoupon;

  GlobalKey<FormState> forminsertcoupon = GlobalKey<FormState>();

  TextEditingController couponName = TextEditingController();
  TextEditingController couponCount = TextEditingController();
  TextEditingController couponDiscount = TextEditingController();
  TextEditingController couponExpiredDate = TextEditingController();

  Settingcontroller settingcontroller = Get.put(Settingcontroller());

  List<CouponModel> dataCoupon = [];
  Controldata controldata = Controldata();
  late CouponModel couponModel;

   List<String> grid = ["categories".tr, "products".tr, "orders".tr, "ads".tr, "coupons".tr];
    List<Object> page = [
      // const usersdash(),
      const categoriesdash(),
      Productdash(),
      const Orderdash(),
      const Ads(),
      const Coupon()
    ];
    List<IconData> icons = [
      Icons.category_outlined,
      Icons.production_quantity_limits_outlined,
      Icons.shopping_bag_outlined,
      Icons.campaign_outlined,
      Icons.discount_outlined
    ];

  // ================= Get all coupon =====================
  getAllCoupon() async {
    statusRequestGetCoupon = StatusRequest.loading;
    var response = await controldata.getData(coupon);
    statusRequestGetCoupon = handlingData(response);
    if (StatusRequest.success == statusRequestGetCoupon) {
      dataCoupon = List.generate(
          response.length, (index) => CouponModel.fromJson(response[index]));
    }
    update();
  }

  // ================== add coupon =====================

  addCoupon() async {
    if (forminsertcoupon.currentState!.validate()) {
      statusRequestAddCoupon = StatusRequest.loading;
      CouponModel couponModel = CouponModel();
      couponModel.coName = couponName.text;
      couponModel.coCount = int.parse(couponCount.text);
      couponModel.coDiscount = int.parse(couponDiscount.text);
      couponModel.coExpiredate = couponExpiredDate.text;
      var coupondata = couponModel.toJson();
      var response = await controldata.addData(
          coupon, coupondata, settingcontroller.accesstoken!);
      statusRequestAddCoupon = handlingData(response);
      if (StatusRequest.success == statusRequestAddCoupon) {
        dataCoupon.add(CouponModel.fromJson(response));
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("تم اضافه كوبون جديد ",
                style: TextStyle(color: Colors.white)));
      }
      update();
    }
  }
  // ================= remove coupon =====================

  removeCoupon(int id) async {
    statusRequestRemoveCoupon = StatusRequest.loading;
    var response = await controldata.deleteData(
        "$coupon$id/", settingcontroller.accesstoken!);
    statusRequestRemoveCoupon = handlingData(response);
    if (StatusRequest.success == statusRequestRemoveCoupon) {
      dataCoupon.removeWhere((element) => element.coId == id);
      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم حذف الكوبون ",
              style: TextStyle(color: Colors.white)));
    }
    update();
  }

  // ================= update coupon =====================

  updateCoupon(int id) async {
    if (forminsertcoupon.currentState!.validate()) {
      statusRequestUpdateCoupon = StatusRequest.loading;
      CouponModel couponModel = CouponModel();
      couponModel.coName = couponName.text;
      couponModel.coCount = int.parse(couponCount.text);
      couponModel.coDiscount = int.parse(couponDiscount.text);
      couponModel.coExpiredate = couponExpiredDate.text;
      var coupondata = couponModel.toJson();
      var response = await controldata.uppdateData(
          "$coupon$id/", coupondata, settingcontroller.accesstoken!);
      statusRequestUpdateCoupon = handlingData(response);
      if (StatusRequest.success == statusRequestUpdateCoupon) {
        for (int i = 0; i < dataCoupon.length; i++) {
          if (dataCoupon[i].coId == id) {
            dataCoupon[i] = CouponModel.fromJson(response);
          }
        }
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("تم تعديل الكوبون ",
                style: TextStyle(color: Colors.white)));
      }
      update();
    }
  }

  gotoEditeCoupon() {
    couponName.text = couponModel.coName!;
    couponCount.text = "${couponModel.coCount}";
    couponDiscount.text = "${couponModel.coDiscount}";
    couponExpiredDate.text = couponModel.coExpiredate!;
    Get.toNamed(AppRoute.editecoupon);
  }

  @override
  void onInit() {
    getAllCoupon();
    super.onInit();
  }
}
