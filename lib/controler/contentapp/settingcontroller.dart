import 'package:eccommerce_new/core/serveces/serveces.dart';
import 'package:get/get.dart';

class Settingcontroller extends GetxController {
  setteng settingcontroller = Get.find();
  int? userid;
  String? accesstoken;

  @override
  void onInit() {
    userid = settingcontroller.shared.getInt('userId');
    accesstoken = settingcontroller.shared.getString('accesstoken');
    super.onInit();
  }
}
