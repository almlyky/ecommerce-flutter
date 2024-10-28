import 'package:eccommerce_new/view/screan/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/localization/changelang.dart';

class changlang extends StatelessWidget {
  const changlang({super.key});

  @override
  Widget build(BuildContext context) {
    localecontroler controller = Get.put(localecontroler());
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    controller.changelang("ar");
                    Get.to(const onboarding());
                  },
                  child: const Text("ar")),
              ElevatedButton(
                  onPressed: () {
                    controller.changelang("en");
                    Get.to(const onboarding());
                  },
                  child: const Text("en"))
            ],
          ),
        ),
      ),
    );
  }
}
