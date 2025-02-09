import 'package:eccommerce_new/controler/contentapp/checkoutcontroller.dart';
import 'package:eccommerce_new/controler/contentapp/ordercontroller.dart';
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
        title: const Text("Check out"),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: const Text("Address"),
              subtitle: const Text("alodain streat"),
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
              ),
              trailing:
                  TextButton(onPressed: () {}, child: const Text("change")),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Order Note"),
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.event_note_rounded,
                  color: Colors.white,
                ),
              ),
              trailing: TextButton(onPressed: () {}, child: const Text("add")),
            ),
          ),
          Card(
            child: GetBuilder<Checkoutcontroller>(
              builder: (checkoutcontroller) => Column(
                children: [
                  const ListTile(
                    title: Text("Payment"),
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
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
                        "cash on delivery",
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
                      Text("transfer",
                          style: Theme.of(context).textTheme.displaySmall)
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              child: const Column(
                children: [
                  ListTile(
                    title: Text("payment details"),
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.payment_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              child: Column(
                children: [
                  const ListTile(
                    title: Text("Type order"),
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.payment_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GetBuilder<Checkoutcontroller>(
                    builder: (controller) => 
                     Column(
                      children: [
                        InkWell(
                          child: Container(
                            color: checkoutcontroller.typeorder == "delivery"
                                ? Colors.blue[200]
                                : null,
                            child: ListTile(
                              leading: Icon(Icons.delivery_dining_sharp),
                              title: Text("Deivery"),
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
                              title: Text("Recive"),
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
          ),
          ElevatedButton(
              onPressed: () {
                ordercontroller.addOrder();
                Get.toNamed(AppRoute.order);
              },
              child: const Text("Confirm Order"))
        ],
      ),
    );
  }
}
