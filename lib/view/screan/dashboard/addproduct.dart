import 'package:eccommerce_new/view/widget/shared/customTextfield.dart';
import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/widget/dashboard/customdropdown.dart';
import 'package:get/get.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:flutter/material.dart';

class addproduct extends StatelessWidget {
  final String typeevent;
  final id;
  final data;

  const addproduct({super.key, required this.typeevent, this.id, this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$typeevent product"),
      ),
      body: GetBuilder<homepagecontrolerimp>(
          // init: dashhomcontrollerimp(),
          builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Form(
                key: controller.forminsertproduct,
                child: Column(
                  children: [
                    CustomTextfild(
                        controller: controller.prname,
                        hintext: "name arabic",
                        icon: Icons.cancel_outlined,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfild(
                        controller: controller.prname,
                        hintext: "name english",
                        icon: Icons.cancel_outlined,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfild(
                        controller: controller.details,
                        hintext: "details arabic",
                        icon: Icons.cancel_outlined,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfild(
                        controller: controller.detailsEn,
                        hintext: "details english",
                        icon: Icons.details,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfild(
                        controller: controller.price,
                        hintext: "pricte",
                        icon: Icons.price_change,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    customdropdown(
                        datadrop: controller.catName,
                        onChanged: (v) {
                          controller.changselected(v);
                        },
                        value: controller.selectedcategories)
                  ],
                ),
              ),
              const SizedBox(height: 20),
              controller.image != null
                  ? Image(
                      image: FileImage(controller.image!),
                      height: 200,
                      fit: BoxFit.fill,
                    )
                  : Container(),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: controller.choseimage,
                  child: const Text("chose image")),
              const SizedBox(height: 20),
              typeevent == "add"
                  ? ElevatedButton(
                      onPressed: () {
                        controller.addProduct();
                      },
                      child: const Text("add data"))
                  : ElevatedButton(
                      onPressed: () {
                        controller
                            .updateProduct(controller.productModel!.prId!);
                      },
                      child: const Text("edete data"))
            ],
          ),
        );
      }),
    );
  }
}
