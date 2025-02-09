import 'package:get/get.dart';

class Checkoutcontroller extends GetxController {
  String? selectedValueRadio;
  setselected(String value) {
    selectedValueRadio = value;
    update();
  }
  String typeorder = "delivery";
  changeTypeOrder(String type) {
    if (typeorder == "delivery") {
      typeorder = "recive";
    } else {
      typeorder = "delivery";
    }
    update();
  }
  @override
  void onInit() {
    // selectedValueRadio = "";
    // TODO: implement onInit
    super.onInit();
  }
}
