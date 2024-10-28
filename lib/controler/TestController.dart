import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:get/get.dart';

import '../data/remote/testdata.dart';

class TestController extends GetxController {
  TestData testData = TestData();

  List data = [];
  late StatusRequest statusRequest;

  getdat() async {
    statusRequest = StatusRequest.loading;
    var response = await testData.getdata();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      data.addAll(response);
    }
  }

  @override
  void onInit() {
    getdat();
    super.onInit();
  }
}
