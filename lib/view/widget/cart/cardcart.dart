import 'package:cached_network_image/cached_network_image.dart';
import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/data/model/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardCart extends StatelessWidget {
  final CartModel cartModel;
  const CardCart({
    super.key,
    required this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    Cartcontroller cartcontroller = Get.find();
    int price = cartModel.prFk!.prCost! * cartModel.quantity!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: CachedNetworkImage(
                imageUrl: "${cartModel.prFk!.prImage}",
                imageBuilder: (context, imageProvider) =>
                    // NetworkImage(imageProvider);
                    Image(
                  image: imageProvider,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${cartModel.prFk!.prName}",
                  style: const TextStyle(fontSize: 16),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "$price",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ])),
                Row(
                  children: [
                    IconIncrement(
                        cartcontroller: cartcontroller, cartModel: cartModel),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${cartModel.quantity}"),
                    ),
                    IconDecrement(
                        cartcontroller: cartcontroller, cartModel: cartModel),
                  ],
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                child: const Icon(
                  Icons.delete,
                  color: Appcolor.iconcolor,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('حذف منتج'),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('هل انت متأكد من الحذف؟'),
                                // Text('Would you like to approve of this message?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('لا'),
                            ),
                            TextButton(
                              onPressed: () {
                                cartcontroller.removecart(
                                  cartModel.cartId!,
                                );
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('نعم'),
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconDecrement extends StatelessWidget {
  const IconDecrement({
    super.key,
    required this.cartcontroller,
    required this.cartModel,
  });

  final Cartcontroller cartcontroller;
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          cartcontroller.updatequantitys("minus", cartModel.cartId!);
        },
        child: const Icon(Icons.remove));
  }
}

class IconIncrement extends StatelessWidget {
  const IconIncrement({
    super.key,
    required this.cartcontroller,
    required this.cartModel,
  });

  final Cartcontroller cartcontroller;
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          cartcontroller.updatequantitys("plus", cartModel.cartId!);
        },
        child: const Icon(Icons.add));
  }
}
