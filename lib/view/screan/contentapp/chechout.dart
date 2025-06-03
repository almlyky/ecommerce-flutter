import 'package:eccommerce_new/controler/contentapp/mapcontroller.dart';
import 'package:eccommerce_new/controler/contentapp/ordercontroller.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chechout extends StatelessWidget {
  const Chechout({super.key});

  @override
  Widget build(BuildContext context) {
    Mapcontroller mapcontroller = Get.put(Mapcontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text("check_out".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GetBuilder<Ordercontroller>(
          init: Ordercontroller(),
          builder: (controller) => ListView(
            children: [
              Card(
                child: ListTile(
                  title: Text("address".tr),
                  subtitle: GetBuilder<Mapcontroller>(builder:(control)=> Text( "${mapcontroller.placemarks.isNotEmpty? mapcontroller.placemarks[0].street:""}")),
                  leading: const CircleAvatar(
                    backgroundColor: Appcolor.iconcolor,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                  trailing: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.mapbox);
                      },
                      child: Text("change".tr)),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("order_note".tr),
                  leading: const CircleAvatar(
                    backgroundColor: Appcolor.iconcolor,
                    child: Icon(
                      Icons.event_note_rounded,
                      color: Colors.white,
                    ),
                  ),
                  trailing: TextButton(onPressed: () {}, child: Text("add".tr)),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("payment".tr),
                      leading: CircleAvatar(
                        backgroundColor: Appcolor.iconcolor,
                        child: Icon(
                          Icons.attach_money_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    RadioListTile(
                      value: "cash",
                      groupValue: controller.selectedValueRadio,
                      onChanged: (value) {
                        controller.setselected(value!);
                      },
                      title: Text("cash".tr,
                          style: Theme.of(context).textTheme.displaySmall),
                    ),
                    RadioListTile(
                      value: "transfer",
                      groupValue: controller.selectedValueRadio,
                      onChanged: (value) {
                        controller.setselected(value!);
                      },
                      title: Text(
                        "cash_on_delivery".tr,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("payment_details".tr),
                      leading: CircleAvatar(
                        backgroundColor: Appcolor.iconcolor,
                        child: Icon(
                          Icons.payment_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("type_order".tr),
                      leading: CircleAvatar(
                        backgroundColor: Appcolor.iconcolor,
                        child: Icon(
                          Icons.payment_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        RadioListTile(
                          value: "delivery",
                          groupValue: controller.typeorder,
                          onChanged: (value) {
                            controller.changeTypeOrder(value!);
                          },
                          title: Text("delivery".tr),
                        ),
                        RadioListTile(
                          value: "recive",
                          groupValue: controller.typeorder,
                          onChanged: (value) {
                            controller.changeTypeOrder(value!);
                          },
                          title: Text("recive".tr),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.addOrder();
                    Get.toNamed(AppRoute.order);
                  },
                  child: Text("confirm_order".tr))
            ],
          ),
        ),
      ),
    );
  }
}
