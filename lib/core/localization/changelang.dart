import 'dart:ui';
import 'package:eccommerce_new/test/serveces.dart';
import 'package:get/get.dart';

class localecontroler extends GetxController {
  late Locale language = const Locale("ar");
  setteng service = Get.find();
  changelang(String languageCode) {
    language = Locale(languageCode);
    service.shared.setString("lang", languageCode);
    Get.updateLocale(language);
  }
  // @override
  //  void onInit() {
  //    String? sharedval=service.shared.getString("lang");
  //    if(sharedval=="ar")
  //      language=Locale("ar");
  //    else if(sharedval=="en")
  //      language=Locale("en");
  //    else
  //      language=Locale(Get.deviceLocale!.languageCode);
  //    super.onInit();
  //  }
}
