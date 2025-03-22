import 'package:eccommerce_new/controler/contentapp/favoratecontroller.dart';
import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/localization/changelang.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/data/model/CategoriesModel.dart';
import 'package:eccommerce_new/view/screan/contentapp/search.dart';
import 'package:eccommerce_new/view/widget/home/adsview.dart';
import 'package:eccommerce_new/view/widget/home/cardCategories.dart';
import 'package:eccommerce_new/view/widget/home/textfieldsearch.dart';
import 'package:eccommerce_new/view/widget/product/cardproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    Productcontroller controllerproduct = Get.put(Productcontroller());
    CategoriesModel categoriesModel;
    Favoratecontroller contrllerfav = Get.put(Favoratecontroller());
    // localecontroler localcontroller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'homepage'.tr,
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: GetBuilder<homepagecontrolerimp>(
            builder: (controlerhome) => NestedScrollView(
                headerSliverBuilder: (context, sl) => [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        flexibleSpace: FlexibleSpaceBar(
                          titlePadding: EdgeInsets.zero,
                          title: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: TextFieldSearch(
                              mycontroller: controlerhome.searchtext,
                              onChanged: (val) {
                                controlerhome.checkSearch(val);
                              },
                              onPressedSearch: () {
                                FocusScope.of(context).unfocus();
                                controlerhome.onSearchItems();
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                body: ListView(
                  children: [
                    const SizedBox(height: 10),
                    controlerhome.isSearch == false
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Adsview(controlerhome: controlerhome),
                              const SizedBox(height: 10),
                              if (controlerhome.dataAdds.isNotEmpty)
                                Center(
                                  child: Obx(
                                    () => AnimatedSmoothIndicator(
                                      activeIndex:
                                          controlerhome.currentIndex.value,
                                      count: controlerhome.dataAdds.length,
                                      effect: const ExpandingDotsEffect(
                                        activeDotColor: Colors.black,
                                        dotColor: Colors.grey,
                                        dotHeight: 8,
                                        dotWidth: 8,
                                        expansionFactor: 3,
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 16),
                              SizedBox(
                                  height: 140,
                                  child: Handlingdataview(
                                      statusRequest:
                                          controlerhome.statusRequestCat,
                                      widgets: Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: controlerhome
                                                  .datacatModel.length,
                                              itemBuilder: (context, i) {
                                                categoriesModel = controlerhome
                                                    .datacatModel[i];
                                                return CardCategories(
                                                    controllerpr:
                                                        controllerproduct,
                                                    controlerhome:
                                                        controlerhome,
                                                    catmodel: categoriesModel);
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ))),
                              const SizedBox(height: 10),
                              const SizedBox(height: 10),
                              Text(
                                "foryou".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              const SizedBox(height: 10),
                              GetBuilder<homepagecontrolerimp>(
                                  builder: (controlerhome) => Handlingdataview(
                                        statusRequest: controlerhome
                                            .statusRequestAllProduct,
                                        widgets: SizedBox(
                                          height: 270,
                                          child: ListView.separated(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: controlerhome
                                                  .dataproductModels.length,
                                              separatorBuilder: (context, i) =>
                                                  const SizedBox(width: 10),
                                              itemBuilder: (context, i) {
                                                contrllerfav.isfavorate[
                                                    controlerhome
                                                        .dataproductModels[i]
                                                        .prId!] = controlerhome
                                                    .dataproductModels[i].fav!;
                                                return InkWell(
                                                  onTap: () {
                                                    controllerproduct
                                                            .productModel =
                                                        controlerhome
                                                            .dataproductModels[i];
                                                    Get.toNamed(AppRoute
                                                        .detailsProduct);
                                                  },
                                                  child: SizedBox(
                                                    // color: Colors.red,
                                                    width: 200,

                                                    child: GetBuilder<
                                                        Favoratecontroller>(
                                                      builder: (controller) =>
                                                          myProductCard(
                                                        productModel: controlerhome
                                                            .dataproductModels[i],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ))
                            ],
                          )
                        : const SearchData()
                  ],
                )),
          )),
    );
  }
}
