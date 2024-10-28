import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/view/screan/dashboard/addproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../controler/contentapp/productcontroller.dart';
import '../../../controler/dashboard/dashhomecontroller.dart';
import '../../../controler/homepagecontroler.dart';
import '../../../core/constant/linksapi.dart';

class productdash extends StatefulWidget {
  const productdash({super.key});

  @override
  State<productdash> createState() => _productdashState();
}

class _productdashState extends State<productdash> {
  //  Productcontroller controllerproduct = Get.put(Productcontroller());
  dashhomcontrollerimp controller = Get.put(dashhomcontrollerimp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                controller.gotoinsertproduct();
              },
              child: const Text("add product")),
          Expanded(
              child: GetBuilder<dashhomcontrollerimp>(
            // init: dashhomcontrollerimp(),
            builder: (controller) => Handlingdataview(
                statusRequest: controller.statusRequestAllProduct,
                widgets: ListView.builder(
                  itemCount: controller.dataAllProduct.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title:
                            Text("${controller.dataAllProduct[i]["pr_name"]}"),
                        subtitle: Text(
                          "${controller.dataAllProduct[i]["pr_cost"]} \$",
                          style: const TextStyle(color: Colors.red),
                        ),
                        leading: CachedNetworkImage(
                          // imageUrl: "https://owenhalliday.co.uk/static/ee54ba1ab58fec57cf4784cc67336993/f3b7d/intro-flutter-thumb.png",
                          imageUrl:
                              "${controller.dataAllProduct[i]["pr_image"]}",
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
                            // child: Image(image: NetworkImage("$image/${controller.dataAllProduct[i]["cat_image"]}"),width: 80,height: 80)),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        trailing: Column(
                          children: [
                            InkWell(
                                child: const Icon(Icons.edit,
                                    color: Colors.greenAccent),
                                onTap: () {
                                  controller.gotoEdetePage(
                                      controller.dataAllProduct[i]['pr_id']);
                                }),
                            InkWell(
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('حذف صنف'),
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
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('لا'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              controller.removeProduct(
                                                  controller.dataAllProduct[i]
                                                      ['pr_id']);
                                              Navigator.pop(context, 'OK');
                                            },
                                            child: const Text('نعم'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          )),
          // Expanded(
          //   child: FutureBuilder(
          //       future: controlerhome.getallproduct(),
          //       builder: (context,AsyncSnapshot<dynamic> snapshot){
          //         if(snapshot.hasData){
          //           return ListView.builder(
          //             itemCount: controller.dataAllProduct.length,
          //             itemBuilder:(context,i){
          //               return Card(
          //                 child: ListTile(
          //                   title: Text("${snapshot.data[i]["pr_name"]}"),
          //                   subtitle: Text("${snapshot.data[i]["pr_cost"]} \$",style: TextStyle(color: Colors.red),),
          //                   leading:  Container(
          //                     width: 80,
          //                     height: 80,
          //                     decoration:BoxDecoration(
          //                       shape: BoxShape.circle,
          //                       image: DecorationImage(
          //                           fit: BoxFit.fill,
          //                           image: NetworkImage("$image/${controller.dataAllProduct[i]["pr_image"]}",)
          //                       ),
          //                     ),
          //                     // child: Image(image: NetworkImage("$image/${controller.dataAllProduct[i]["cat_image"]}"),width: 80,height: 80)),
          //                   ),
          //                   contentPadding: EdgeInsets.all(10),
          //                   trailing:Column(
          //                     children: [
          //                       InkWell(child:Icon( Icons.edit,color: Colors.greenAccent),onTap: ()async{
          //                         var data=await controller.dataproductforedete(i, snapshot.data[i]);
          //                         Get.to(addproduct(id: snapshot.data[i]['pr_id'],typeevent: "edete",data:data));
          //                       }),
          //                       InkWell(child: Icon(Icons.delete,color: Colors.red,),onTap: (){
          //                         showDialog(context: context,
          //                             builder: (context){
          //                               return AlertDialog(
          //                                 title: Text('حذف صنف'),
          //                                 content: const SingleChildScrollView(
          //                                   child: ListBody(
          //                                     children: <Widget>[
          //                                       Text('هل انت متأكد من الحذف؟'),
          //                                       // Text('Would you like to approve of this message?'),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 actions: <Widget>[
          //                                   TextButton(
          //                                     onPressed: () => Navigator.pop(context, 'Cancel'),
          //                                     child: const Text('لا'),
          //                                   ),
          //                                   TextButton(
          //                                     onPressed: () {
          //                                       print("ok");
          //                                       Navigator.pop(context, 'OK');
          //                                     },
          //                                     child: const Text('نعم'),
          //                                   ),
          //                                 ],
          //                               );
          //                             });
          //                       },),
          //
          //                     ],
          //                   ),
          //
          //
          //                 ),
          //               );
          //             },
          //
          //           );
          //         }else{
          //           return Center(child: CircularProgressIndicator(
          //             color: Colors.red,
          //           ));
          //         }
          //       } ),
          // ),
        ],
      ),
    );
  }
}
