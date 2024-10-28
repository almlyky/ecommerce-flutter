import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:eccommerce_new/data/model/CategoriesModel.dart';
import 'package:eccommerce_new/view/screan/contentapp/search.dart';
import 'package:eccommerce_new/view/widget/home/buttonsfilters_sort.dart';
import 'package:eccommerce_new/view/widget/home/cardCategories.dart';
import 'package:eccommerce_new/view/widget/home/pageviewoffer.dart';
import 'package:eccommerce_new/view/widget/home/textfieldsearch.dart';
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
  Productcontroller controllerpr = Get.put(Productcontroller());
  homepagecontrolerimp controlerhome = Get.put(homepagecontrolerimp());

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
                      controlerhome.onSearchItems();
                    },
                  ),
                  controlerhome.isSearch == false
                      ? Column(
                          children: [
                            const SizedBox(height: 16),
                            // SizedBox(height: 5),

                            //pageview
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
                                          controllerpr: controllerpr,
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
                          ],
                        )
                      : const SearchData()
                ],
              )),
    );
  }
}
