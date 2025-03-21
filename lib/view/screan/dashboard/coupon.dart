import 'package:eccommerce_new/controler/dashboard/dashhomecontroller.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Coupon extends StatelessWidget {
  const Coupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('coupons'.tr),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.addcoupon);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: GetBuilder<Dashhomecontroller>(
          init: Dashhomecontroller(),
          builder: (controller) {
            return Handlingdataview(
                statusRequest: controller.statusRequestGetCoupon,
                widgets: ListView.builder(
                    itemCount: controller.dataCoupon.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(controller.dataCoupon[index].coName!),
                          trailing: Column(
                            children: [
                              InkWell(
                                  child: const Icon(Icons.edit,
                                      color: Colors.greenAccent),
                                  onTap: () {
                                    controller.couponModel =
                                        controller.dataCoupon[index];
                                    controller.gotoEditeCoupon();
                                  }),
                              InkWell(
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('حذف صنف'),
                                          content: const SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text('هل انت متأكد من الحذف؟'),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('لا'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                controller.removeCoupon(
                                                    controller.dataCoupon[index]
                                                        .coId!);
                                                Navigator.pop(context, 'OK');
                                              },
                                              child: const Text('نعم'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }));
          }),
    );
  }
}
