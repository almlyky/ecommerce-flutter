import 'package:carousel_slider/carousel_slider.dart';
import 'package:eccommerce_new/controler/contentapp/favoratecontroller.dart';
import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/controler/dashboard/dashhomecontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/data/model/CategoriesModel.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:eccommerce_new/view/screan/contentapp/search.dart';
import 'package:eccommerce_new/view/widget/home/buttonsfilters_sort.dart';
import 'package:eccommerce_new/view/widget/home/cardCategories.dart';
import 'package:eccommerce_new/view/widget/home/pageviewoffer.dart';
import 'package:eccommerce_new/view/widget/home/textfieldsearch.dart';
import 'package:eccommerce_new/view/widget/product/cardproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/localization/changelang.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    //  localecontroler controller = Get.put(localecontroler());
    Productcontroller controllerproduct = Get.put(Productcontroller());
    CategoriesModel categoriesModel;

    // homepagecontrolerimp controlerhome = Get.find();

    // dashhomcontrollerimp controllerdashhome = Get.put(dashhomcontrollerimp());
    favoratecontroller contrllerfav = Get.put(favoratecontroller());
    final screanheight = MediaQuery.of(context).size.height;
    final bodyheight = screanheight - MediaQuery.of(context).padding.top;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: GetBuilder<homepagecontrolerimp>(
          builder: (controlerhome) => NestedScrollView(
              // floatHeaderSlivers: true,
              headerSliverBuilder: (context, sl) => [
                    SliverAppBar(
                      // pinned: true,
                      // expandedHeight: 70,
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.zero,
                        title: Container(
                          margin: EdgeInsets.only(top: 10),
                          // height: 50,
                          child: 
                          TextFieldSearch(
                            mycontroller: controlerhome.searchtext,
                            onChanged: (val) {
                              controlerhome.checkSearch(val);
                            },
                            onPressedSearch: () {
                              FocusScope.of(context).unfocus();
                              controlerhome.onSearchItems();
                            },
                          ),
                        
                            // height: 60,

                            ),
                      ),
                    )
                  ],
              body: ListView(
                children: [
                  // const SizedBox(height: 20),
                  // TextFieldSearch(
                  //   mycontroller: controlerhome.searchtext,
                  //   onChanged: (val) {
                  //     controlerhome.checkSearch(val);
                  //   },
                  //   onPressedSearch: () {
                  //     FocusScope.of(context).unfocus();
                  //     controlerhome.onSearchItems();
                  //   },
                  // ),
                  const SizedBox(height: 10),
                  CarouselSlider.builder(
                    carouselController: controlerhome.carouselController,
                    itemCount: controlerhome.dataAdds.length,
                    itemBuilder: (context, itemIndex, pageViewIndex) => Container(
                      // width: double.infinity,
                      // margin: EdgeInsets.symmetric(horizontal: 0),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(16.0),
                      // ),
                      // elevation: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16.0),
                        // width: 300,
                        // height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(controlerhome
                                  .dataAdds[itemIndex].image!),
                              fit: BoxFit.fill),

                          // color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Row(
                          children: [
                            // Text and Button
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Container(color: Colors.white,child: Image(image: AssetImage("assist/image/offer.png"),fit: BoxFit.fill,width: 100,height: 100,)),
                                  // Text(
                                  //   '${controlerhome.dataOffer[itemIndex].discountPercentage}% OFF',
                                  //   style: const TextStyle(
                                  //     fontSize: 30,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Color.fromARGB(255, 250, 250, 250),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 8.0),
                                  // Text(
                                  //   'offer expire on \n${homeconroller.dataOffer[i].endDate}',
                                  //   style: const TextStyle(
                                  //     fontSize: 16,
                                  //     color: Color.fromARGB(255, 255, 0, 0),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 16.0),
                                  ElevatedButton(
                                    // icon: const Icon(
                                    //     Icons.shopping_basket_outlined),
                                    onPressed: () {},
                                    child: const Text(
                                      'تسوق الأن',
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Image.asset(
                            //   "assist/image/offer4.png",
                            //   width: 150,
                            //   height: 200,
                            //   fit: BoxFit.contain,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      height: 220,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        controlerhome.currentIndex.value = index;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Obx(
                      () => AnimatedSmoothIndicator(
                        activeIndex: controlerhome.currentIndex.value,
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
                  controlerhome.isSearch == false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            // const ButonsFilterAndsort(),
                            SizedBox(
                                height: 140,
                                child: Handlingdataview(
                                    statusRequest:
                                        controlerhome.statusRequestCat,
                                    widgets: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            controller:
                                                controlerhome.scrollController,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controlerhome
                                                .datacatModel.length,
                                            itemBuilder: (context, i) {
                                              categoriesModel =
                                                  controlerhome.datacatModel[i];
                                              return CardCategories(
                                                  controllerpr:
                                                      controllerproduct,
                                                  controlerhome: controlerhome,
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

                            //pageview offers
                            // PageViewOffer(
                            //     bodyheight: bodyheight,
                            //     homeconroller: controlerhome),
                            const SizedBox(height: 10),
                            const Text(
                              "لك انت",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            const SizedBox(height: 10),
                            // Container(
                            //   height: 200,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: 20,
                            //     itemBuilder: (context, i) {
                            //       return Container(color: Colors.red,height: 150,width: 30,);
                            //     },
                            //   ),
                            // )
                            GetBuilder<homepagecontrolerimp>(
                                builder: (controlerhome) => Handlingdataview(
                                      statusRequest:
                                          controlerhome.statusRequestAllProduct,
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
                                                  Get.toNamed(
                                                      AppRoute.detailsProduct);
                                                },
                                                child: SizedBox(
                                                  // color: Colors.red,
                                                  width: 200,

                                                  child: GetBuilder<
                                                      favoratecontroller>(
                                                    builder: (controller) =>
                                                        myProductCard(
                                                      productModel: controlerhome
                                                          .dataproductModels[i],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }

                                            // myProductCard(
                                            //          productModel:
                                            //              ProductModel.fromJson(controlerhome.dataAllProduct[0]),
                                            //        )
                                            ),
                                      ),
                                    ))

                            // GetBuilder<dashhomcontrollerimp>(
                            //   builder: (controllerdash)=>
                            //    Container(
                            //       height: 200,
                            //       child:
                            //   Handlingdataview(
                            //   statusRequest: controllerdashhome.statusRequestAllProduct,
                            //   widgets:
                            //     ListView.builder(
                            //         scrollDirection: Axis.horizontal,
                            //         itemCount:
                            //             controllerdashhome.dataAllProduct.length,
                            //         itemBuilder: (context, i) {
                            //           return myProductCard(
                            //             productModel:
                            //                 ProductModel.fromJson(controllerdashhome.dataAllProduct[i]),
                            //           );
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        )
                      : const SearchData()
                ],
              )),
        ));
  }
}
