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
        title: Text(typeevent == "add" ? "add_product".tr : "edit_product".tr),
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
                      textInputType: TextInputType.text ,
                        controller: controller.prname,
                        hintext: "enter_name_arabic".tr,
                        icon: Icons.cancel_outlined,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfild(
                      textInputType: TextInputType.text ,
                        controller: controller.prnameEn,
                        hintext: "enter_name_english".tr,
                        icon: Icons.cancel_outlined,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfild(
                      textInputType: TextInputType.text ,
                        controller: controller.details,
                        hintext: "enter_details_arabic".tr,
                        icon: Icons.cancel_outlined,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfild(
                      textInputType: TextInputType.text ,
                        controller: controller.detailsEn,
                        hintext: "enter_details_english".tr,
                        icon: Icons.details,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfild(
                      textInputType: TextInputType.number,
                        controller: controller.price,
                        hintext: "enter_price".tr,
                        icon: Icons.price_change,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfild(
                      textInputType: TextInputType.number,
                        controller: controller.prdiscount,
                        hintext: "enter_discount".tr,
                        icon: Icons.discount_rounded,
                        validate: (v) {
                          return validinput(v!, 6, 100, "");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
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
                  child: Text("chose_image".tr)),
              const SizedBox(height: 20),
             ElevatedButton(
                      onPressed: () {
                          typeevent == "add"?
                        controller.addProduct():
                        controller.updateProduct(controller.productModel!.prId!);
                      },
                      child:  Text( typeevent == "add"?"add".tr:"edite".tr))
                 
            ],
          ),
        );
      }),
    );
  }
}
