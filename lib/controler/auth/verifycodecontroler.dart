import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:get/get.dart';


class Verifycodecontroler extends GetxController {
  StatusRequest? statusRequest;
  Controldata controldata = Controldata();
  String? otp;
  String? errorText;
  String errorotp = "";

  chechoTp(String action) async {
    statusRequest = StatusRequest.loading;
    var response =
        await controldata.addDataWithoutToken(chechotp, {"otp": otp});
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (action == "signup") {
        Get.offNamed(AppRoute.login);
      } else if (action == "reset_password") {
        Get.toNamed(AppRoute.resetpassword,arguments: {"otp":otp});
      }
    } else {
      errorotp = "error_otp".tr;
    }
    update();
  }
}
