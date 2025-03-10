import 'package:eccommerce_new/core/constant/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Coupon extends StatelessWidget {
  const Coupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('coupon'),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.addcoupon);
              },
              icon: Icon(Icons.add))
        ],
      ),
    );
  }
}
