import 'package:eccommerce_new/controler/contentapp/checkoutcontroller.dart';
import 'package:eccommerce_new/controler/contentapp/ordercontroller.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chechout extends StatelessWidget {
  const Chechout({super.key});

  @override
  Widget build(BuildContext context) {
    Ordercontroller ordercontroller = Get.put(Ordercontroller());
    Checkoutcontroller checkoutcontroller = Get.put(Checkoutcontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text("check_out".tr),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("address".tr),
              subtitle: Text("شارع العدين"),
              leading: const CircleAvatar(
                backgroundColor: Appcolor.iconcolor,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
              ),
              trailing: TextButton(onPressed: () {}, child: Text("change".tr)),
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
            child: GetBuilder<Checkoutcontroller>(
              builder: (checkoutcontroller) => Column(
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
                  Row(
                    children: [
                      Radio(
                          value: "1",
                          groupValue: checkoutcontroller.selectedValueRadio,
                          onChanged: (value) {
                            checkoutcontroller.setselected(value!);
                          }),
                      Text(
                        "cash_on_delivery".tr,
                        style: Theme.of(context).textTheme.displaySmall,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: "2",
                          groupValue: checkoutcontroller.selectedValueRadio,
                          onChanged: (value) {
                            checkoutcontroller.setselected(value!);
                          }),
                      Text("cash".tr,
                          style: Theme.of(context).textTheme.displaySmall)
                    ],
                  ),
                ],
              ),
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
                GetBuilder<Checkoutcontroller>(
                  builder: (controller) => Column(
                    children: [
                      InkWell(
                        child: Container(
                          color: checkoutcontroller.typeorder == "delivery"
                              ? Colors.blue[200]
                              : null,
                          child: ListTile(
                            leading: Icon(Icons.delivery_dining_sharp),
                            title: Text("delivery".tr),
                          ),
                        ),
                        onTap: () {
                          checkoutcontroller.changeTypeOrder("delivery");
                        },
                      ),
                      InkWell(
                        child: Container(
                          color: checkoutcontroller.typeorder == "recive"
                              ? Colors.blue[200]
                              : null,
                          child: ListTile(
                            leading: Icon(Icons.arrow_circle_left_sharp),
                            title: Text("recive".tr),
                          ),
                        ),
                        onTap: () {
                          checkoutcontroller.changeTypeOrder("recive");
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                ordercontroller.addOrder();
                Get.toNamed(AppRoute.order);
              },
              child: Text("confirm_order".tr))
        ],
      ),
    );
  }
}
