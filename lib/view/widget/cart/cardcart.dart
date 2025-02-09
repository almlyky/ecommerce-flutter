import 'package:cached_network_image/cached_network_image.dart';
import 'package:eccommerce_new/controler/auth/forgetpasscontroler.dart';
import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // spacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: CachedNetworkImage(
                // imageUrl: "https://owenhalliday.co.uk/static/ee54ba1ab58fec57cf4784cc67336993/f3b7d/intro-flutter-thumb.png",
                imageUrl: "${cartModel.prFk!.prImage}",
                imageBuilder: (context, imageProvider) =>
                    // NetworkImage(imageProvider);
                    Image(
                  image: imageProvider,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
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
                    RichText(text: TextSpan(
                      children: [
                        TextSpan(text: "$price",style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight:FontWeight.bold)),
                        // TextSpan(text: "  ريال",style: const TextStyle(color: Colors.red))

                      ]
                    )),
                    
                    // Text(
                    //   "$price",
                    //   style: const TextStyle(color: Colors.red),
                    // ),
                  
                
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    IconIncrement(
                        cartcontroller: cartcontroller, cartModel: cartModel),
                    // GetBuilder<Cartcontroller>(
                    //     builder: (control) =>
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
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
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

      // child: ListTile(
      //   // splashColor: Colors.white,
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     // mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text("${cartModel.prFk!.prName}"),
      //       Text(
      //     "$price",
      //     style: const TextStyle(color: Colors.red),
      //   ),
      //   Row(
      //     // mainAxisSize: MainAxisSize.min,
      //     children: [
      //     IconIncrement(
      //                 cartcontroller: cartcontroller, cartModel: cartModel),
      //             // GetBuilder<Cartcontroller>(
      //             //     builder: (control) =>
      //             Text("${cartModel.quantity}"),
      //             IconDecrement(
      //                 cartcontroller: cartcontroller, cartModel: cartModel),

      //   ],)
      //     ],
      //   ),
      //   // subtitle: Text(
      //   //   "$price",
      //   //   style: const TextStyle(color: Colors.red),
      //   // ),
      //   leading: CachedNetworkImage(
      //     // imageUrl: "https://owenhalliday.co.uk/static/ee54ba1ab58fec57cf4784cc67336993/f3b7d/intro-flutter-thumb.png",
      //     imageUrl: "${cartModel.prFk!.prImage}",
      //     imageBuilder: (context, imageProvider) => Container(
      //       width: 80,
      //       height: 80,
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         image: DecorationImage(
      //           fit: BoxFit.fill,
      //           image: imageProvider,
      //         ),
      //       ),
      //       // child: Image(image: NetworkImage("$image/${controller.dataCart[i]['pr_fk']["cat_image"]}"),width: 80,height: 80)),
      //     ),
      //     placeholder: (context, url) => const CircularProgressIndicator(),
      //     errorWidget: (context, url, error) => const Icon(Icons.error),
      //   ),
      //   trailing:      InkWell(
      //               child: const Icon(
      //                 Icons.delete_outlined,
      //                 color: Colors.red,
      //               ),
      //               onTap: () {
      //                 showDialog(
      //                     context: context,
      //                     builder: (context) {
      //                       return AlertDialog(
      //                         title: const Text('حذف منتج'),
      //                         content: const SingleChildScrollView(
      //                           child: ListBody(
      //                             children: <Widget>[
      //                               Text('هل انت متأكد من الحذف؟'),
      //                               // Text('Would you like to approve of this message?'),
      //                             ],
      //                           ),
      //                         ),
      //                         actions: <Widget>[
      //                           TextButton(
      //                             onPressed: () =>
      //                                 Navigator.pop(context, 'Cancel'),
      //                             child: const Text('لا'),
      //                           ),
      //                           TextButton(
      //                             onPressed: () {
      //                               cartcontroller.removecart(
      //                                 cartModel.cartId!,
      //                               );
      //                               Navigator.pop(context, 'OK');
      //                             },
      //                             child: const Text('نعم'),
      //                           ),
      //                         ],
      //                       );
      //                     });
      //               },
      //             ),
      //   // trailing: SizedBox(
      //   //   width: 150,
      //   //   child: Row(
      //   //     children: [
      //   //       Row(
      //   //         children: [
      //   //           // IconIncrement(
      //   //           //     cartcontroller: cartcontroller, cartModel: cartModel),
      //   //           // // GetBuilder<Cartcontroller>(
      //   //           // //     builder: (control) =>
      //   //           // Text("${cartModel.quantity}"),
      //   //           // IconDecrement(
      //   //           //     cartcontroller: cartcontroller, cartModel: cartModel),

      //   //           InkWell(
      //   //             child: const Icon(
      //   //               Icons.delete,
      //   //               color: Colors.red,
      //   //             ),
      //   //             onTap: () {
      //   //               showDialog(
      //   //                   context: context,
      //   //                   builder: (context) {
      //   //                     return AlertDialog(
      //   //                       title: const Text('حذف منتج'),
      //   //                       content: const SingleChildScrollView(
      //   //                         child: ListBody(
      //   //                           children: <Widget>[
      //   //                             Text('هل انت متأكد من الحذف؟'),
      //   //                             // Text('Would you like to approve of this message?'),
      //   //                           ],
      //   //                         ),
      //   //                       ),
      //   //                       actions: <Widget>[
      //   //                         TextButton(
      //   //                           onPressed: () =>
      //   //                               Navigator.pop(context, 'Cancel'),
      //   //                           child: const Text('لا'),
      //   //                         ),
      //   //                         TextButton(
      //   //                           onPressed: () {
      //   //                             cartcontroller.removecart(
      //   //                               cartModel.cartId!,
      //   //                             );
      //   //                             Navigator.pop(context, 'OK');
      //   //                           },
      //   //                           child: const Text('نعم'),
      //   //                         ),
      //   //                       ],
      //   //                     );
      //   //                   });
      //   //             },
      //   //           ),
      //   //         ],
      //   //       ),
      //   //     ],
      //   //   ),
      //   // ),
      //   contentPadding: const EdgeInsets.all(10),
      // ),
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
          cartcontroller.updatequantity("minus", cartModel.cartId!);
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
          cartcontroller.updatequantity("plus", cartModel.cartId!);
        },
        child: const Icon(Icons.add));
  }
}
