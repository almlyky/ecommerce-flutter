import 'package:eccommerce_new/controler/contentapp/ordercontroller.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/data/model/orderitemmodel.dart';
import 'package:eccommerce_new/view/widget/order/cardorder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/my_classes/HandlingDataView.dart';

class Orderdetails extends StatelessWidget {
  const Orderdetails({super.key});

  @override
  Widget build(BuildContext context) {
    Ordercontroller ordercontroller = Get.put(Ordercontroller());

    return Scaffold(
        appBar: AppBar(
          title: Text("order_detail".tr),
        ),
        body: GetBuilder<Ordercontroller>(
            builder: (controller) => Handlingdataview(
                statusRequest: controller.statusRequestOrderItem!,
                widgets: ListView(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardOrder(
                          typeAcount: "user",
                          showdetails: "show",
                          orderModel: controller.orderModel!,
                          ordercontroller: ordercontroller),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.dataOrderItem.length,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  ProductCard(
                                      orderItemModel:
                                          controller.dataOrderItem[i])
                                ],
                              );
                            }),
                      ),
                    ]))));
  }
}

class ProductCard extends StatelessWidget {
  final OrderItemModel orderItemModel;

  const ProductCard({super.key, required this.orderItemModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "$djServer/${orderItemModel.product!.prImage!}",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${orderItemModel.product!.prName}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "brand",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Text(
              '\$${orderItemModel.product!.prCost}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
