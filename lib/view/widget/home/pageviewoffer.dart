import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/data/model/offermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PageViewOffer extends StatelessWidget {
  const PageViewOffer({
    super.key,
    required this.bodyheight,
    required this.homeconroller,
  });

  final homepagecontrolerimp homeconroller;
  final double bodyheight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bodyheight / 3.5,
      child: PageView.builder(
          // pageSnapping: false,
          //dragStartBehavior: DragStartBehavior.start,
          itemCount: homeconroller.dataAdds.length,
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
                  image: DecorationImage(
                      image: NetworkImage(
                          homeconroller.dataAdds[i].image!),
                      fit: BoxFit.fill),

                  // color: Colors.lightBlueAccent,
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
                          // // Container(color: Colors.white,child: Image(image: AssetImage("assist/image/offer.png"),fit: BoxFit.fill,width: 100,height: 100,)),
                          // Text(
                          //   '${homeconroller.dataAdds[i].}% OFF',
                          //   style: const TextStyle(
                              
                          //     fontSize: 30,
                          //     fontWeight: FontWeight.bold,
                          //     color: Color.fromARGB(255, 250, 250, 250),
                          //   ),
                          // ),
                          const SizedBox(height: 8.0),
                          // Text(
                          //   'offer expire on \n${homeconroller.dataOffer[i].endDate}',
                          //   style: const TextStyle(
                          //     fontSize: 16,
                          //     color: Color.fromARGB(255, 255, 0, 0),
                          //   ),
                          // ),
                          const SizedBox(height: 16.0),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.shopping_basket_outlined),
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              // side: const BorderSide(color: Colors.white),
                            ),
                            label: const Text(
                              'Shop Now',
                              // style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                    // Image.asset(
                    //   "assist/image/offer4.png",
                    //   width: 150,
                    //   height: 200,
                    //   fit: BoxFit.contain,
                    // ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
