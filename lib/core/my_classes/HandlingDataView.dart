import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Handlingdataview extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widgets;
  const Handlingdataview(
      {super.key, required this.statusRequest, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(child: Lottie.asset("assist/lottie/loading.json"))
        : statusRequest == StatusRequest.offlineFailure
            ? Center(child: Lottie.asset("assist/lottie/offline.json"))
            : statusRequest == StatusRequest.failure ||
                    statusRequest == StatusRequest.serverFailure
                ? Center(
                    child: Lottie.asset("assist/lottie/server_failure.json"))
                : widgets;
  }
}
