import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:eccommerce_new/view/screan/contentapp/cart.dart';
import 'package:eccommerce_new/view/screan/contentapp/favorate.dart';
import 'package:eccommerce_new/view/widget/product/cardproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controler/contentapp/favoratecontroller.dart';
import '../../../controler/homepagecontroler.dart';
import 'detailsproduct.dart';

class product extends StatelessWidget {
  // final id;
  product({super.key});

  favoratecontroller contrllerfav = Get.put(favoratecontroller());
  // localecontroler controller = Get.put(localecontroler());
  // Productcontroller controllerproduct = Get.put(Productcontroller());
  // Productcontroller controllerproduct=Get.find();
  homepagecontrolerimp controllerhome = Get.find();

  @override
  Widget build(BuildContext context) {
    // print(controllerproduct.dataProduct);
    // print("=================created product====================");
    // Productcontroller controllerproduct = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const favorate());
              },
              icon: const Icon(Icons.favorite)),
          IconButton(
              onPressed: () {
                Get.to(const cart());
              },
              icon: const Icon(Icons.shopping_cart_rounded)),
        ],
      ),
      body: ListView(children: [
        SizedBox(
            height: 600,
            child: GetBuilder<Productcontroller>(
              // init: Productcontroller(),
              builder: (controllerproduct) => Handlingdataview(
                  statusRequest: controllerproduct.statusRequestCatProduct,
                  widgets: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: controllerproduct.dataProduct.length,
                    itemBuilder: (context, i) {
                      contrllerfav.isfavorate[controllerproduct.dataProduct[i]
                          ['pr_id']] = controllerproduct.dataProduct[i]['fav'];
                      return InkWell(
                        onTap: () {
                          controllerproduct.productModel =
                              ProductModel.fromJson(
                                  controllerproduct.dataProduct[i]);
                          Get.to(()=> const ProductDetailPage());
                        },
                        child: myProductCard(
                          productModel: ProductModel.fromJson(
                              controllerproduct.dataProduct[i]),
                        ),
                      );
                    },
                  )),
            ))
      ]),
    );
  }
}
