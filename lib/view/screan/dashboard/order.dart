import 'package:eccommerce_new/controler/contentapp/ordercontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/view/widget/order/cardorder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Orderdash extends StatelessWidget {
  const Orderdash({super.key});

  @override
  Widget build(BuildContext context) {
    Ordercontroller ordercontroller = Get.put(Ordercontroller());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: GetBuilder<Ordercontroller>(
        builder: (controller) => ListView.builder(
            itemCount: ordercontroller.dataOrderModel.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CardOrder(
                      typeAcount: "admin",
                      ordercontroller: ordercontroller,
                      orderModel: ordercontroller.dataOrderModel[index],
                    ),
                  ),
                )
            // child: ListTile(
            //   title: Text("${ordercontroller.dataOrderModel[index].address}"),
            //   subtitle:Text("${ordercontroller.dataOrderModel[index].orderCode}") ,
            ),
      ),
    );
  }
}
