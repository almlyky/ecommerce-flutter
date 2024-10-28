import 'package:eccommerce_new/controler/onboardingcontroler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/datasource/static/static.dart';

class costomcontroler extends StatelessWidget {
  const costomcontroler({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<onboardingcontrolerimp>(
        init: onboardingcontrolerimp(),
        builder: (controller) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    onboardinglist.length,
                    (index) => AnimatedContainer(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          duration: const Duration(microseconds: 900),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 6,
                          width: controller.curentindex == index ? 20 : 6,
                        )),
              ],
            ));
  }
}
