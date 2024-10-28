import 'package:eccommerce_new/controler/contentapp/productcontroller.dart';
import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/data/model/CategoriesModel.dart';
import 'package:flutter/material.dart';

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
              // Productcontroller controllerpr = Get.find();
              controllerpr.getproduct(catmodel.catId!, 1);
              //print(controllerpr.dataProduct);
              controlerhome.gotoproduct();
              // controlerhome.dataCat[i]["cat_id"]);
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
        Text(catmodel.catName!),
      ],
    );
  }
}
