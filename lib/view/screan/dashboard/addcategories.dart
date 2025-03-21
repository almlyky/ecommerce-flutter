import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/widget/shared/customTextfield.dart';
import 'package:get/get.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:flutter/material.dart';

class addcategories extends StatelessWidget {
  final String typeevent;
  const addcategories({super.key, required this.typeevent});
  @override
  Widget build(BuildContext context) {
    homepagecontrolerimp homecontroller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(typeevent == "add" ? "add_category".tr : "edit_category".tr),
      ),
      body: GetBuilder<homepagecontrolerimp>(builder: (control) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Form(
                key: homecontroller.forminsertCategories,
                child: Column(
                  children: [
                    CustomTextfild(
                      textInputType: TextInputType.text,
                      validate: (v) {
                        return validinput(
                          v!,
                          6,
                          100,
                          "",
                        );

                        // return validinput(v!, 5, 50, "", "");
                      },
                      hintext: "enter_name_arabic".tr,
                      icon: Icons.category,
                      controller: homecontroller.nameCat,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfild(
                      textInputType: TextInputType.text,
                      validate: (v) {
                     return validinput(v!, 6, 100, "");
                      },
                      hintext: "enter_name_english".tr,
                      icon: Icons.category,
                      controller: homecontroller.nameCatEn,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              homecontroller.image != null
                  ? Image(
                      image: FileImage(homecontroller.image!),
                      height: 200,
                      fit: BoxFit.fill,
                    )
                  : Container(),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: homecontroller.choseimage,
                  child: Text("chose_image".tr)),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    typeevent == "add"
                        ? homecontroller.addcategories()
                        : homecontroller.uppdatecategories(
                            homecontroller.categoriesModel!.catId!);
                  },
                  child: Text(typeevent == "add" ? "add".tr : "edite".tr)),
            ],
          ),
        );
      }),
    );
  }
}
