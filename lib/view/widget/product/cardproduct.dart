import 'package:cached_network_image/cached_network_image.dart';
import 'package:eccommerce_new/controler/contentapp/favoratecontroller.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/linksapi.dart';

class myProductCard extends StatelessWidget {
  final ProductModel productModel;

  // final images;
  // final String name, details;
  // final int price;
  // final int pr_id;
  myProductCard({
    super.key,
    required this.productModel,
    // this.images,
    // required this.name,
    // required this.details,
    // required this.price,
    // required this.pr_id,
  });

  favoratecontroller controller = Get.find();

  @override
  // late int id,price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          Card(
            // elevation: 5,
            // shadowColor: Colors.blue[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: '${productModel.prImage}',
                  imageBuilder: (context, imageprovider) => ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12.0)),
                    child: Center(
                      child: Image(
                        image: imageprovider, // Replace with your image URL
                        // width: double.infinity,
                        height: 120,
                        // fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.prName!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      // Text(
                      //   productModel.prDetail!,
                      //   style: TextStyle(
                      //     color: Colors.grey[600],
                      //   ),
                      // ),
                      const SizedBox(height: 4.0),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16.0),
                          Icon(Icons.star, color: Colors.orange, size: 16.0),
                          Icon(Icons.star, color: Colors.orange, size: 16.0),
                          Icon(Icons.star, color: Colors.orange, size: 16.0),
                          Icon(Icons.star_border,
                              color: Colors.orange, size: 16.0),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      const Row(
                        children: [
                          // Text(
                          //   'avlilable',
                          //   style: TextStyle(color: Colors.green),
                          // ),
                          // Spacer(),
                          // Text(
                          //   '35% OFF',
                          //   style: TextStyle(
                          //     color: Colors.red,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ],
                      ),
                      // const SizedBox(height: 8.0),
                      if (productModel.prDiscount == 0)
                      
                        Text(
                          '${productModel.prCost} R.Y',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        )
                      else
                        Text(
                          '${productModel.prCostNew} R.Y',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),

                      if (productModel.prDiscount! > 0)
                        Text(
                          '${productModel.prCost} R.Y',
                          style: const TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            // top: 10,
            bottom: 15,
            left: 15,
            child: InkWell(onTap: () {
              controller.onTapFavorite(productModel);
            }, child: GetBuilder<favoratecontroller>(builder: (controller) {
              return  Icon(
                  controller.isfavorate[productModel.prId] == 0
                      ? Icons.favorite_border
                      : Icons.favorite,
                  color: const Color.fromARGB(255, 9, 9, 9),
                  // size: 25,
                
              );
            })

                // child:fav == 0
                //     ?  Icon(Icons.favorite_border,
                //             color: Colors.red[700])
                //     :Icon(Icons.favorite, color: Colors.red[700]),
                ),
          ),
          if (productModel.prDiscount! > 0)
            const Positioned(
                top: 0,
                right: 0,
                // left: ,
                child: Image(
                  height: 50,
                  width: 70,
                  image: AssetImage("assist/image/discount.png")
                  // Icons.discount_outlined,
                  // color: Colors.green,
                ))
        ],
      ),
    );
  }
}
