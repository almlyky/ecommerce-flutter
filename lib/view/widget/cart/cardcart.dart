import 'package:cached_network_image/cached_network_image.dart';
import 'package:eccommerce_new/controler/auth/forgetpasscontroler.dart';
import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/data/model/cartmodel.dart';
import 'package:eccommerce_new/view/widget/onboarding/controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CardCart extends StatelessWidget {
  final CartModel cartModel;
  // final Cartcontroller cartcontroller;
  const CardCart({
    super.key,
    required this.cartModel,
    // required this.cartcontroller,
  });

  @override
  Widget build(BuildContext context) {
    Cartcontroller cartcontroller = Get.find();
    int price = cartModel.prFk!.prCost! * cartModel.quantity!;
    return Card(
      child: ListTile(
        title: Text("${cartModel.prFk!.prName}"),
        subtitle: Text(
          "${price}",
          style: const TextStyle(color: Colors.red),
        ),
        leading: CachedNetworkImage(
          // imageUrl: "https://owenhalliday.co.uk/static/ee54ba1ab58fec57cf4784cc67336993/f3b7d/intro-flutter-thumb.png",
          imageUrl: "$image/${cartModel.prFk!.prImage}",
          imageBuilder: (context, imageProvider) => Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: imageProvider,
              ),
            ),
            // child: Image(image: NetworkImage("$image/${controller.dataCart[i]['pr_fk']["cat_image"]}"),width: 80,height: 80)),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        trailing: SizedBox(
          width: 150,
          child: Row(
            children: [
              Row(
                children: [
                  IconIncrement(
                      cartcontroller: cartcontroller, cartModel: cartModel),
                  // GetBuilder<Cartcontroller>(
                  //     builder: (control) =>
                  Text("${cartModel.quantity}"),
                  IconDecrement(
                      cartcontroller: cartcontroller, cartModel: cartModel),
                ],
              ),
              InkWell(
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onTap: () {
                  cartcontroller.removecart(
                      productID: cartModel.prFk!.prId!, userid: 1);
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: const Text('حذف منتج'),
                  //         content: const SingleChildScrollView(
                  //           child: ListBody(
                  //             children: <Widget>[
                  //               Text('هل انت متأكد من الحذف؟'),
                  //               // Text('Would you like to approve of this message?'),
                  //             ],
                  //           ),
                  //         ),
                  //         actions: <Widget>[
                  //           TextButton(
                  //             onPressed: () => Navigator.pop(context, 'Cancel'),
                  //             child: const Text('لا'),
                  //           ),
                  //           TextButton(
                  //             onPressed: () {
                  //               Navigator.pop(context, 'OK');
                  //             },
                  //             child: const Text('نعم'),
                  //           ),
                  //         ],
                  //       );
                  //     });
                },
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.all(10),
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
    return IconButton(
        onPressed: () {
          cartcontroller.updatequantity("minus", cartModel.cartId!);
        },
        icon: const Icon(Icons.remove));
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
    return IconButton(
        onPressed: () {
          cartcontroller.updatequantity("plus", cartModel.cartId!);
        },
        icon: const Icon(Icons.add));
  }
}
