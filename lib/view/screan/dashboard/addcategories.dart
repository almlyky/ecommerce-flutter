import 'dart:io';
import 'package:eccommerce_new/controler/dashboard/dashhomecontroller.dart';
import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/widget/login/costomtextfiald.dart';
import 'package:eccommerce_new/view/widget/shared/customTextfield.dart';
import 'package:get/get.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:flutter/material.dart';
import 'dashhome.dart';
import 'package:image_picker/image_picker.dart';

class addcategories extends StatelessWidget {
  final String typeevent;
  // final id;
  // final data;
  const addcategories({super.key, required this.typeevent});

  // void initState() {
  //   if (widget.typeevent == "edete") {
  //     controller.name.text = widget.data[0];
  //     controller.image = widget.data[1];
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    homepagecontrolerimp homecontroller = Get.put(homepagecontrolerimp());

    return Scaffold(
      appBar: AppBar(
        title: Text("$typeevent categories"),
      ),
      body: GetBuilder<homepagecontrolerimp>(
          // init: dashhomcontrollerimp(),
          builder: (control) {
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
                      validate: (v) {
                        return validinput(v!, 5, 50, "", "");
                      },
                      hintext: "Name Arabic",
                      icon: Icons.category,
                      controller: homecontroller.nameCat,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfild(
                      validate: (v) {
                        return validinput(v!, 5, 50, "", "");
                      },
                      hintext: "Name English",
                      icon: Icons.category,
                      controller: homecontroller.nameCatEn,
                    ),
                    // TextFormField(
                    //   controller: homecontroller.nameCatEn,
                    //   validator: (v) {
                    //     return validinput(v!, 5, 50, "", "");
                    //   },
                    //   decoration: const InputDecoration(
                    //       contentPadding: EdgeInsets.all(10),
                    //       hintText: "Name English ",
                    //       prefixIcon: Icon(Icons.category)),
                    // )
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
                  child: const Text("chose image")),
              const SizedBox(height: 20),
              typeevent == "add"
                  ? ElevatedButton(
                      onPressed: () {
                        homecontroller.addcategories();
                      },
                      child: const Text("add data"))
                  : ElevatedButton(
                      onPressed: () {
                        homecontroller.uppdatecategories(homecontroller.categoriesModel!.catId!);
                      },
                      child: const Text("edete data"))
            ],
          ),
        );
      }),
    );
  }
}
