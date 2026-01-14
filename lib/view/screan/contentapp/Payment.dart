import 'package:eccommerce_new/controler/contentapp/paymentcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(title: const Text("Stripe Payment with GetX")),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator();
          }
          return ElevatedButton(
            onPressed: () async {
              await controller.makePayment(4000); // 20$
            },
            child: const Text("ادفع الآن"),
          );
        }),
      ),
    );
  }
}
