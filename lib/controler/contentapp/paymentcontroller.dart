import 'dart:convert';
import 'dart:io';
// import 'package:eccommerce_new/core/constant/linksapi.dart';
// import 'package:eccommerce_new/core/constant/linksapi.dart' as LinksApi;
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

Controldata controldata = Controldata();
late StatusRequest statusRequest;

class PaymentController extends GetxController {
  var isLoading = false.obs;

  String? customerId;
  String? ephemeralKey;
  String? setupIntentClientSecret;


  Future<Map<String, dynamic>> _initStripe(int amount) async {
  final res = await http.post(
    Uri.parse(createPaymentIntent),
    body: {"amount": amount.toString()},
  );

  return jsonDecode(res.body);
}


  Future<void> makePayment(int amount) async {
  try {
    isLoading.value = true;

    final data = await _initStripe(amount);

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: data["client_secret"],
        customerId: data["customer_id"],
        customerEphemeralKeySecret: data["ephemeral_key"],
        merchantDisplayName: "My Django Shop",
      ),
    );

    await Stripe.instance.presentPaymentSheet();

    Get.snackbar("نجاح", "✅ تم الدفع بنجاح");
  } catch (e) {
    Get.snackbar("خطأ", e.toString());
  } finally {
    isLoading.value = false;
  }
}

}
