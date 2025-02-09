import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:flutter/material.dart';

class ButonsFilterAndsort extends StatelessWidget {
  const ButonsFilterAndsort({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'All Featured',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Appcolor.primarytext),
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.sort),
              label: const Text('Sort'),
              style: OutlinedButton.styleFrom(
                // backgroundColor: Colors.white,
                // foregroundColor: Colors.black,
                // shape: RoundedRectangleBorder(
                //   // borderRadius: BorderRadius.circular(20),
                // ),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.filter_alt_outlined),
              label: const Text('Filter'),
              style: OutlinedButton.styleFrom(
                // padding: EdgeInsets.symmetric(vertical: 3)
                // shape: RoundedRectangleBorder(
                //   // borderRadius: BorderRadius.circular(20),
                // ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}