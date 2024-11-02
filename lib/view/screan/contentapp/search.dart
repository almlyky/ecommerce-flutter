import 'package:eccommerce_new/controler/contentapp/favoratecontroller.dart';
import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:eccommerce_new/view/screan/contentapp/detailsproduct.dart';
import 'package:eccommerce_new/view/widget/product/cardproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchData extends StatelessWidget {
  const SearchData({super.key});

  @override
  Widget build(BuildContext context) {
    favoratecontroller contrllerfav = Get.find();
    // homepagecontrolerimp controllerhome = Get.find();
    Productcontroller controllerproduct = Get.find();

    return ListView(shrinkWrap: true, children: [
      SizedBox(
          height: 600,
          child: GetBuilder<homepagecontrolerimp>(
            // init: Productcontroller(),
            builder: (controllerhome) => Handlingdataview(
                statusRequest: controllerhome.statusRequestSearch,
                widgets: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: controllerhome.dataProductSearch.length,
                  itemBuilder: (context, i) {
                    contrllerfav.isfavorate[controllerhome.dataProductSearch[i]
                        ['pr_id']] = controllerhome.dataProductSearch[i]['fav'];
                    return InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controllerproduct.productModel = ProductModel.fromJson(
                            controllerhome.dataProductSearch[i]);
                        Get.to(() => const ProductDetailPage());
                      },
                      child: myProductCard(
                        productModel: ProductModel.fromJson(
                            controllerhome.dataProductSearch[i]),
                      ),
                    );
                  },
                )),
          ))
    ]);
  }
}
