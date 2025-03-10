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
  product({super.key});

  Favoratecontroller contrllerfav = Get.put(Favoratecontroller());
  homepagecontrolerimp controllerhome = Get.find();

  @override
  Widget build(BuildContext context) {
    ProductModel productModel;
    // print(controllerproduct.dataProduct);
    // print("=================created product====================");
    Productcontroller controllerproduct = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("products".tr),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const favorate());
              },
              icon: const Icon(Icons.favorite)),
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.cart);
              },
              icon: const Icon(Icons.shopping_cart_rounded)),
        ],
      ),
      body: ListView(children: [
        // Container(
        //     height: 40,
        //     child: ListView.builder(
        //         shrinkWrap: true,
        //         scrollDirection: Axis.horizontal,
        //         itemCount: controllerhome.datacatModel.length,
        //         itemBuilder: (context, index) {
        //           return InkWell(
        //             onTap: () {
        //               controllerproduct.tabController.animateTo(index);
        //             },
        //             child: Card(
        //               child:
        //                   Text("${controllerhome.datacatModel[index].catName}"),
        //             ),
        //           );
        //         })),
        SizedBox(
            height: 600,
            // child: TabBarView(
            //     physics: NeverScrollableScrollPhysics(),
            //     controller: controllerproduct.tabController,
            //     children:
            //         List.generate(controllerhome.datacatModel.length, (index) {
            //           return
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
                              childAspectRatio: 0.76
                              // childAspectRatio: ,
                              ),
                      itemCount:
                          controllerproduct.dataproductCategoristModel.length,
                      // controllerhome.dataproductModels.where((element) => element.catFk==controllerhome.datacatModel[index].catId).toList().length,
                      itemBuilder: (context, i) {
                        // if(controllerhome.dataproductModels[i].catFk==controllerhome.datacatModel[index].catId){
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
