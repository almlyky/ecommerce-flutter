import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/localization/changelang.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  // Productcontroller controllerproduct = Get.put(Productcontroller());
  homepagecontrolerimp controlerhome = Get.put(homepagecontrolerimp());

  @override
  void onInit() {
    super.onInit();
     // تحميل البيانات عند بدء التشغيل
  }

  Future<void> fetchData() async {
    controlerhome.getcategories(); 
  }
}
