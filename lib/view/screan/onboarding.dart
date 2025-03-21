import 'package:eccommerce_new/controler/onboardingcontroler.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/serveces/serveces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/datasource/static/static.dart';
import '../widget/onboarding/controler.dart';

class onboarding extends GetView<onboardingcontrolerimp> {
  const onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(onboardingcontrolerimp());
    setteng controllersetting = Get.find();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SafeArea(
              child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.onpagechanged(index);
                  },
                  itemCount: onboardinglist.length,
                  itemBuilder: (context, i) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: Text(
                            onboardinglist[i].title.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        onboardinglist[i].image,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            onboardinglist[i].body.tr,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const costomcontroler(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GetBuilder<onboardingcontrolerimp>(
                    builder: (controller) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              controllersetting.shared
                                  .setBool("onboarding", false);
                              Get.offAllNamed(AppRoute.login);
                            },
                            child: Text(
                              "skip".tr,
                              style: const TextStyle(fontSize: 16),
                            )),
                        controller.curentindex == 3
                            ? TextButton(
                                onPressed: () {
                                  controllersetting.shared
                                      .setBool("onboarding", false);
                                  Get.offAllNamed(AppRoute.login);
                                },
                                child: Text("start".tr))
                            : TextButton(
                                onPressed: () {
                                  controller.nex();
                                },
                                child: Text(
                                  "next".tr,
                                  style: const TextStyle(fontSize: 16),
                                )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
