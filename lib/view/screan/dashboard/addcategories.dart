import 'dart:io';
import 'package:eccommerce_new/controler/dashboard/dashhomecontroller.dart';
import 'package:get/get.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:flutter/material.dart';
import 'dashhome.dart';
import 'package:image_picker/image_picker.dart';

class addcategories extends StatefulWidget {
  final typeevent;
  final id;
  final data;
  const addcategories({super.key, this.typeevent, this.id, this.data});

  @override
  State<addcategories> createState() => _addcategoriesState();
}

class _addcategoriesState extends State<addcategories> {
  dashhomcontrollerimp controller = Get.put(dashhomcontrollerimp());

  @override
  void initState() {
    if (widget.typeevent == "edete") {
      controller.name.text = widget.data[0];
      controller.image = widget.data[1];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.typeevent} categories"),
      ),
      body: GetBuilder<dashhomcontrollerimp>(
          init: dashhomcontrollerimp(),
          builder: (control) {
            return ListView(
              children: [
                const SizedBox(height: 20),
                Form(
                  key: controller.forminsert,
                  child: TextFormField(
                    controller: controller.name,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "no must name null";
                      }
                      if (v.length < 6) {
                        return "cann't be less than 6";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "name",
                        prefixIcon: Icon(Icons.category)),
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
                          controller.insertdatacategories();
                        },
                        child: const Text("add data"))
                    : ElevatedButton(
                        onPressed: () {
                          controller.edetecategories(widget.id);
                        },
                        child: const Text("edete data"))
              ],
            );
          }),
    );
  }
}
