import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/model/orderitemmodel.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Orderdetailscontroller extends GetxController {
  StatusRequest? statusRequestOrderItem;
  List<OrderItemModel> dataOrderItem = [];
  Controldata controldata = Controldata();
  int? orderId;
  getOrderDetails(int orderId) async {
    dataOrderItem.clear();
    statusRequestOrderItem = StatusRequest.loading;
    var response = await controldata.getData("$OrderItem$orderId/");
    statusRequestOrderItem = handlingData(response);
    if (statusRequestOrderItem == StatusRequest.success) {
      List<OrderItemModel> orders = response.map<OrderItemModel>((order) {
        return OrderItemModel.fromJson(order);
      }).toList();
      dataOrderItem.addAll(orders);
    }
    update();
  }
  @override
  void onInit() {
    getOrderDetails(orderId!);
    super.onInit();
  }
}
