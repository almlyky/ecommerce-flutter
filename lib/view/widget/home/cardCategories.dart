import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/localization/changelang.dart';
import 'package:eccommerce_new/data/model/CategoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardCategories extends StatelessWidget {
  const CardCategories({
    super.key,
    required this.controllerpr,
    required this.catmodel,
    required this.controlerhome,
  });
  final Productcontroller controllerpr;
  final homepagecontrolerimp controlerhome;
  // final int i;
  final CategoriesModel catmodel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              controllerpr.getproduct(catmodel.catId!);
              controlerhome.gotoproduct();
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              width: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      "${catmodel.catImage}",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // ignore: unrelated_type_equality_checks
        GetBuilder<localecontroler>(
            builder: (controller) => Text(
                controller.language.languageCode == "ar"
                    ? catmodel.catName!
                    : catmodel.catNameEn!)),
      ],
    );
  }
}
