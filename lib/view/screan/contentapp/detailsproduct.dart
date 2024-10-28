import 'package:eccommerce_new/view/screan/contentapp/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controler/contentapp/cartcontroller.dart';
import '../../../controler/contentapp/productcontroller.dart';
import '../../../core/constant/linksapi.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Productcontroller controllerproduct = Get.find();
    Cartcontroller controllercart = Get.put(Cartcontroller());
    controllerproduct.initquantity(controllerproduct.productModel.prId!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const cart());
              },
              icon: const Icon(Icons.shopping_cart_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Center(
              child: Image(
                image: NetworkImage(
                    "$image/${controllerproduct.productModel.prImage}"),
                height: 200,
              ),
            ),
            const SizedBox(height: 16.0),
            // Size Options
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('6 UK'),
                  selected: false,
                ),
                SizedBox(width: 8.0),
                ChoiceChip(
                  label: Text('7 UK'),
                  selected: true,
                ),
                SizedBox(width: 8.0),
                ChoiceChip(
                  label: Text('8 UK'),
                  selected: false,
                ),
                // Add more sizes as needed
              ],
            ),
            const SizedBox(height: 16.0),
            // Product Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controllerproduct.productModel.prName}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          controllerproduct.updatequantity("plus");
                        },
                        icon: const Icon(Icons.add)),
                    GetBuilder<Productcontroller>(
                        builder: (control) =>
                            Text("${controllerproduct.quantity}")),
                    IconButton(
                        onPressed: () {
                          controllerproduct.updatequantity("minus");
                        },
                        icon: const Icon(Icons.remove)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8.0),
            // Rating and Reviews
            const Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star_border),
                SizedBox(width: 8.0),
                Text('56,890'),
              ],
            ),
            const SizedBox(height: 8.0),
            // Price and Discount
            Row(
              children: [
                Text(
                  '${controllerproduct.productModel.prCost}\$',
                  style: const TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8.0),
                const Text(
                  '1,500\$',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 8.0),
                const Text(
                  '50% Off',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Product Details
            Text(
              '${controllerproduct.productModel.prDetail}',
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      print(controllerproduct.productModel.prId);
                      controllercart.addcart(
                          productID: controllerproduct.productModel.prId!,
                          userid: 1,
                          quantity: 1);
                    },
                    child: const Text('add to cart'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Buy Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
