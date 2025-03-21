import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/my_function/validinput.dart';
import 'package:eccommerce_new/view/widget/shared/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addads extends StatelessWidget {
  final String action;
  const Addads({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(action == "add" ? "add_ad".tr : "edit_ad".tr),
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
                          textInputType: TextInputType.url,
                          validate: (v) {
                            return validinput(
                              v!,
                              6,
                              1000,
                              "url",
                            );
                            // return validinput(v!, 5, 50, "", "");
                          },
                          hintext: "enter_url_ads".tr,
                          icon: Icons.link,
                          controller: controller.url),
                      InkWell(
                        onTap: () {
                          controller.choseDate(context, controller.expireddate);
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: CustomTextfild(
                              textInputType: TextInputType.datetime,
                              validate: (v) {
                                return validinput(
                                  v!,
                                  6,
                                  1000,
                                  "",
                                );
                                // return validinput(v!, 5, 50, "", "");
                              },
                              hintext: "enter_expiry_date_ads".tr,
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              action == "add"
                                  ? controller.addads()
                                  : controller
                                      .updateads(controller.addsModel.id!);
                            },
                            child: Text(action == "add" ? "add".tr : "edite".tr)),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
