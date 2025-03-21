import 'package:cached_network_image/cached_network_image.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controler/homepagecontroler.dart';

class Productdash extends StatelessWidget {
  const Productdash({super.key});

  @override
  Widget build(BuildContext context) {
    homepagecontrolerimp homecontroller = Get.find();
    ProductModel? productModel;

    return Scaffold(
      appBar: AppBar(
        title: Text("products".tr),
        actions: [
          IconButton(
              onPressed: () {
                homecontroller.gotoinsertproduct();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: GetBuilder<homepagecontrolerimp>(
            // init: dashhomcontrollerimp(),
            builder: (controller) => Handlingdataview(
                statusRequest: controller.statusRequestAllProduct,
                widgets: ListView.builder(
                  itemCount: controller.dataproductModels.length,
                  itemBuilder: (context, i) {
                    productModel = controller.dataproductModels[i];
                    return Card(
                      child: ListTile(
                        title: Text(productModel!.prName!),
                        subtitle: Text(
                          "${productModel!.prCost} \$",
                          style: const TextStyle(color: Colors.red),
                        ),
                        leading: CachedNetworkImage(
                          // imageUrl: "https://owenhalliday.co.uk/static/ee54ba1ab58fec57cf4784cc67336993/f3b7d/intro-flutter-thumb.png",
                          imageUrl: "${productModel!.prImage}",
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
                                  controller.productModel =
                                      controller.dataproductModels[i];
                                  controller.gotoEdeteProduct();
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
                                                  productModel!.prId!);
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
        ],
      ),
    );
  }
}
