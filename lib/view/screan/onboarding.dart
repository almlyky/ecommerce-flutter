import 'package:eccommerce_new/controler/onboardingcontroler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/datasource/static/static.dart';
import '../widget/onboarding/buttons.dart';
import '../widget/onboarding/controler.dart';

class onboarding extends GetView<onboardingcontrolerimp> {
  const onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(onboardingcontrolerimp());
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
                          margin: const EdgeInsets.only(top: 20),
                          child: Text(
                            onboardinglist[i].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        onboardinglist[i].image,
                        Text(onboardinglist[i].body)
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
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      controller.nex();
                    },
                    child: Text(
                      "4".tr,
                      style: const TextStyle(fontSize: 20),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
