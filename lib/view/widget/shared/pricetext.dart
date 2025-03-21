import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceText extends StatelessWidget {
  final double price;

  const PriceText({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    String formattedPrice = NumberFormat("#,##0","ar").format(price);
    return
     RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "$formattedPrice",
         style: Theme.of(context).textTheme.displayMedium),
         TextSpan(text: " ريال",style: TextStyle(color: const Color.fromARGB(255, 13, 13, 13),))
         
    ]));
    //  Text(
    //   // textAlign: TextAlign.center
    //   "$formattedPrice"+" ريال", // يمكنك تعديل العملة حسب الحاجة
    //   style: Theme.of(context).textTheme.displayMedium,
    // );
  }
}
