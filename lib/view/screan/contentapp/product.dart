import 'package:eccommerce_new/controler/contentapp/cartcontroller.dart';
import 'package:eccommerce_new/controler/contentapp/favoratecontroller.dart';
import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:eccommerce_new/view/screan/contentapp/favorate.dart';
import 'package:eccommerce_new/view/widget/product/cardproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controler/homepagecontroler.dart';
import 'detailsproduct.dart';

class product extends StatelessWidget {
  // final id;
  const product({super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel productModel;
    // print(controllerproduct.dataProduct);
    // print("=================created product====================");
    Favoratecontroller contrllerfav = Get.put(Favoratecontroller());
    homepagecontrolerimp controllerhome = Get.find();
    Productcontroller controllerproduct = Get.find();
    Cartcontroller cartcontroller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("products".tr),
        actions: [
          Obx(
            () => Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Get.to(() => const favorate());
                    },
                    icon: const Icon(Icons.favorite)),
                if (contrllerfav.favoriteCount.value > 0)
                  Positioned(
                    right: 3,
                    top: 3,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        contrllerfav.favoriteCount.value.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
          ),
          Obx(
            () => Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.cart);
                      // Get.to(const cart());
                    },
                    icon: const Icon(Icons.shopping_cart_rounded)),
                if (cartcontroller.cartcount.value > 0)
                  Positioned(
                    right: 3,
                    top: 3,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        cartcontroller.cartcount.value.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
      body: ListView(children: [
        SizedBox(
            height: 600,
            child: SizedBox(
                child: GetBuilder<Productcontroller>(
              // init: Productcontroller(),
              builder: (controllerproduct) => Handlingdataview(
                  statusRequest: controllerproduct.statusRequestCatProduct,
                  widgets: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              childAspectRatio: 0.76),
                      itemCount:
                          controllerproduct.dataproductCategoristModel.length,
                      itemBuilder: (context, i) {
                        productModel =
                            controllerproduct.dataproductCategoristModel[i];
                        contrllerfav.isfavorate[productModel.prId!] =
                            productModel.fav!;
                        return InkWell(
                          onTap: () {
                            controllerproduct.productModel =
                                controllerproduct.dataproductCategoristModel[i];
                            Get.to(() => const ProductDetailPage());
                          },
                          child: myProductCard(
                            productModel: productModel,
                          ),
                        );

                        //   else{
                        //   return ();
                        // }
                      })),
            ))
            // }
            // )
            // ),
            )
      ]),
    );
  }
}
