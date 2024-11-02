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

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  localecontroler controller = Get.put(localecontroler());
  Productcontroller controllerproduct = Get.put(Productcontroller());
  homepagecontrolerimp controlerhome = Get.find();
  // dashhomcontrollerimp controllerdashhome = Get.put(dashhomcontrollerimp());
  favoratecontroller contrllerfav = Get.put(favoratecontroller());


  @override
  Widget build(BuildContext context) {
    final screanheight = MediaQuery.of(context).size.height;
    final bodyheight = screanheight - MediaQuery.of(context).padding.top;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GetBuilder<homepagecontrolerimp>(
          builder: (controlerhome) => ListView(
                children: [
                  const SizedBox(height: 20),
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
                  controlerhome.isSearch == false
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const ButonsFilterAndsort(),
                            SizedBox(
                                height: 100,
                                child: Handlingdataview(
                                    statusRequest:
                                    controlerhome.statusRequestCat,
                                    widgets: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controlerhome.dataCat.length,
                                      itemBuilder: (context, i) {
                                        return CardCategories(
                                          controllerpr: controllerproduct,
                                          controlerhome: controlerhome,
                                          catmodel: CategoriesModel.fromJson(
                                              controlerhome.dataCat[i]),
                                        );
                                      },
                                    ))),

                            const SizedBox(height: 10),
                            //pageview offers
                            PageViewOffer(bodyheight: bodyheight),
                            const SizedBox(height: 10),
                            const Text(
                              "Four you",
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
                              builder: (controlerhome)=>
                              Handlingdataview(statusRequest: controlerhome.statusRequestAllProduct,
                               widgets: Container(
                                height: 330,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controlerhome.dataAllProduct.length,
                                  separatorBuilder: (context,i)=> SizedBox(width: 10),
                                  itemBuilder: (context,i)=>
                                      InkWell(
                                        onTap: (){
                                          controllerproduct.productModel =
                                              ProductModel.fromJson(
                                                  controlerhome.dataAllProduct[i]);
                                          Get.toNamed(AppRoute.detailsProduct);
                                        },
                                        child: Container(
                                          // color: Colors.red,
                                          width: 200,

                                          child: myProductCard(
                                                     productModel:
                                                         ProductModel.fromJson(controlerhome.dataAllProduct[i]),
                                                   ),
                                        ),
                                      )
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
    );
  }
}
