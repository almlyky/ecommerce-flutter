import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/widget/shared/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class Addads extends StatelessWidget {
  final String action;
  const Addads({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add ads"),
      ),
      body: GetBuilder<homepagecontrolerimp>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Form(
                  key: controller.forminsertads,
                  child: Column(
                    spacing: 10,
                    children: [
                      CustomTextfild(
                          validate: (v) {
                            return validinput(
                              v!,
                              6,
                              1000,
                              "url",
                            );
                            // return validinput(v!, 5, 50, "", "");
                          },
                          hintext: "ادخل رابط الإعلان",
                          icon: Icons.link,
                          controller: controller.url),
                      InkWell(
                        onTap: () {
                          controller.choseDate(context,controller.expireddate);
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: CustomTextfild(
                              validate: (v) {
                                return validinput(
                                  v!,
                                  6,
                                  1000,
                                  "",
                                );
                                // return validinput(v!, 5, 50, "", "");
                              },
                              hintext: "اختر تأريخ انتهاء الإعلان",
                              icon: Icons.date_range_outlined,
                              controller: controller.expireddate),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          //  image: DecorationImage(
                          //     image:controller.image!=null?FileImage(controller.image!):AssetImage("assets/image/uploade.png"),
                          //     fit: BoxFit.fill)
                        ),
                        height: 140,
                        width: 200,
                        child: InkWell(
                            onTap: () {
                              controller.choseimage();
                            },
                            child: controller.image != null
                                ? Image.file(
                                    controller.image!,
                                    fit: BoxFit.fill,
                                  )
                                : Center(
                                    child: Image.asset(
                                      "assets/image/uploade.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                  )),
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       controller.choseimage();
                      //     },
                      //     child: Text("اختر الصورة")),
                      // controller.image != null
                      //     ? Image.file(
                      //         controller.image!,
                      //         height: 100,
                      //         fit: BoxFit.cover,
                      //       )
                      //     : SizedBox(),
                      ElevatedButton(
                          onPressed: () {
                            action == "add"
                                ? controller.addads()
                                : controller
                                    .updateads(controller.addsModel.id!);
                          },
                          child: Text(action == "add" ? "add".tr : "edite".tr))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
