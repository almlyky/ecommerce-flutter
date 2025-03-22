import 'package:carousel_slider/carousel_slider.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/localization/changelang.dart';
import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Adsview extends StatelessWidget {
  final homepagecontrolerimp controlerhome;
  const Adsview({super.key, required this.controlerhome});

  @override
  Widget build(BuildContext context) {
    return Handlingdataview(
      statusRequest: controlerhome.statusRequestOffer,
      widgets: controlerhome.dataAdds.isNotEmpty
          ? CarouselSlider.builder(
              carouselController: controlerhome.carouselController,
              itemCount: controlerhome.dataAdds.length,
              itemBuilder: (context, itemIndex, pageViewIndex) => Container(
                // width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),

                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          controlerhome.dataAdds[itemIndex].image!),
                      fit: BoxFit.fill),

                  // color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  children: [
                    // Text and Button
                    Expanded(
                      child: GetBuilder<localecontroler>(
                        builder: (controller) => 
                        Column(
                        
                          crossAxisAlignment:controller.language.languageCode=="ar"? CrossAxisAlignment.end:CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 8.0),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'shopingnow'.tr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
            )
          : SizedBox(),
    );
  }
}
