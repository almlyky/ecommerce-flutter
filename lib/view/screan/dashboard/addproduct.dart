import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:eccommerce_new/controler/dashboard/dashhomecontroller.dart';
import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/widget/dashboard/customdropdown.dart';
import 'package:get/get.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:flutter/material.dart';
import '../../widget/dashboard/custemtext.dart';
import 'dashhome.dart';
import 'package:image_picker/image_picker.dart';

class addproduct extends StatefulWidget {
  final String typeevent;
  final id;
  final data;
  
  const addproduct({super.key, required this.typeevent, this.id, this.data});
  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  dashhomcontrollerimp controller = Get.find();
  homepagecontrolerimp controllerhome = Get.find();

  @override
  void initState() {
    // controller.datadrop.clear();
    // controller.data();
    // if (widget.typeevent == "edete") {
    //   List<dynamic> data = widget.data;
    //   Object? v = data[3];
    //   controller.prname.text = data[0];
    //   controller.details.text = data[1];
    //   controller.price.text = data[2].toString();
    //   controller.changselected(v);
    //   // print(controller.selectedcategories);
    //   controller.image = data[4];
    // } else {
    //   controller.prname.text = "";
    //   controller.details.text = "";
    //   controller.price.text = "";
    //   controller.image = null;
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.typeevent} product"),
      ),
      body: GetBuilder<dashhomcontrollerimp>(
          init: dashhomcontrollerimp(),
          builder: (control) {
            return ListView(
              children: [
                const SizedBox(height: 20),
                Form(
                  key: controller.forminsertproduct,
                  child: Column(
                    children: [
                      custemtext(hint: "name arabic", control: controller.prname),
                      custemtext(hint: "name english", control: controller.prnameEn),

                      custemtext(hint: "details arabic", control: controller.details),
                      custemtext(hint: "details english", control: controller.detailsEn),

                      custemtext(hint: "price", control: controller.price),
                      customdropdown(
                          datadrop: controllerhome.catName,
                          onChanged: (v) {
                            controller.changselected(v);
                          },
                          value: control.selectedcategories)
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
                widget.typeevent == "add"
                    ? ElevatedButton(
                        onPressed: () {
                          controller.addProduct();
                        },
                        child: const Text("add data"))
                    : ElevatedButton(
                        onPressed: () {
                          controller.updateProduct(controller.productId);
                        },
                        child: const Text("edete data"))
              ],
            );
          }),
    );
  }
}