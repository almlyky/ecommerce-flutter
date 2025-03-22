// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:eccommerce_new/core/constant/linksapi.dart';
// import 'package:eccommerce_new/core/localization/changelang.dart';
// import 'package:eccommerce_new/data/model/orderitemmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Cardorderdetails extends StatelessWidget {
//   final OrderItemModel orderItemModel;
//   const Cardorderdetails({super.key, required this.orderItemModel});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: ListTile(
//             title: GetBuilder<localecontroler>(
//               builder: (controller) => 
//                Text(controller.language.languageCode=="ar"? orderItemModel.product!.prName!:orderItemModel.product!.prNameEn!)),
//             subtitle: Text("${orderItemModel.quantity} \$",
//                 style: const TextStyle(color: Colors.red)),
//             leading: SizedBox(
//               height: 80,
//               width: 80,
//               child: CachedNetworkImage(
//                   // imageUrl: "https://owenhalliday.co.uk/static/ee54ba1ab58fec57cf4784cc67336993/f3b7d/intro-flutter-thumb.png",
//                   imageUrl: "$djServer/${orderItemModel.product!.prImage}",
//                   imageBuilder: (context, imageProvider) => Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             fit: BoxFit.fill,
//                             image: imageProvider,
//                           ),
//                         ),
//                       )),
//             )));
//   }
// }
