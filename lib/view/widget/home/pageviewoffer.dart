
import 'package:flutter/material.dart';

class PageViewOffer extends StatelessWidget {
  const PageViewOffer({
    super.key,
    required this.bodyheight,
  });

  final double bodyheight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bodyheight / 3.5,
      child: PageView.builder(
          // pageSnapping: false,
          //dragStartBehavior: DragStartBehavior.start,
          itemCount: 10,
          itemBuilder: (context, i) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  children: [
                    // Text and Button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '50-40% OFF',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Now in (product)\nAll colours',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          OutlinedButton.icon(
                            icon: const Icon(
                                Icons.shopping_basket_outlined),
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white),
                            ),
                            label: const Text(
                              'Shop Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Image
                    Image.asset(
                      "assist/image/offer4.png",
                      width: 150,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

