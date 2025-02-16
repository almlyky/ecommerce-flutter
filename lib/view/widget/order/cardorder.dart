import 'package:eccommerce_new/controler/contentapp/ordercontroller.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/data/model/ordermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardOrder extends StatelessWidget {
  final OrderModel orderModel;
  final String typeAcount;
  final Ordercontroller ordercontroller;
  final showdetails;

  const CardOrder({
    super.key,
    required this.orderModel,
    required this.ordercontroller,
    this.showdetails,
    required this.typeAcount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Order Code: ',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    TextSpan(
                      text: orderModel.orderCode,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${orderModel.totalOrder}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 21, 28, 219), fontSize: 16)),
                const TextSpan(
                    text: ' R.Y',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              ])),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            orderModel.createdAt!,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ElevatedButton.icon(onPressed: (){}, label: Icon(Icons.arrow_drop_down_outlined),),
              InkWell(
                onTap: () {
                  ordercontroller.gotoOrderDetails(orderModel.id!);
                  ordercontroller.orderModel = orderModel;
                  // ordercontroller.orderId = orderModel.id;
                  // await ordercontroller.getOrderDetails(orderModel.id!);
                  // Get.toNamed(AppRoute.orderdetail);
                },
                child: showdetails == null
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 234, 233, 244),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'details',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 69, 131, 213)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        child: Text(
                          "detail".tr,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
              ),
              // orderModel.status=="pending"?
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  //
                  color: orderModel.status == "pending"
                      ? Colors.amberAccent[100]
                      : orderModel.status == "delivered"
                          ? Colors.green[100]
                          : Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  orderModel.status!,
                  style: TextStyle(
                      color: orderModel.status == "pending"
                          ? const Color.fromARGB(255, 169, 131, 17)
                          : orderModel.status == "delivered"
                              ? Colors.green
                              : Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
              if (typeAcount == "admin")
                ElevatedButton(
                    onPressed: () {
                      ordercontroller.updataOrder(orderModel.id!);
                    },
                    child: const Text("Accept Order"))
            ],
          ),
        ],
      ),
    );
  }
}
