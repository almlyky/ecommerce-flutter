import 'package:eccommerce_new/controler/homepagecontroler.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ads extends StatelessWidget {
  const Ads({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.addads);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          // SizedBox(height: 30),
          // ElevatedButton(
          //     onPressed: () {
          //       Get.toNamed(AppRoute.addads);
          //     },
          //     child: const Text("Add Ads")),
          Expanded(
            child: GetBuilder<homepagecontrolerimp>(
                builder: (controller) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: controller.dataAdds.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                controller.dataAdds[index].image!,
                                height: 100,
                                fit: BoxFit.cover,
                                width: 200,
                              ),
                              Column(
                                children: [
                                  InkWell(
                                      child: const Icon(Icons.edit,
                                          color: Colors.greenAccent),
                                      onTap: () async {
                                        controller.addsModel =
                                            controller.dataAdds[index];
                                        controller.gotoEditeAds();
                                        // controlerhome.categoriesModel =
                                        //     controlerhome.datacatModel[i];
                                        // controlerhome.gotoedeteCategories();
                                        // controlerhome.got
                                      }),
                                  InkWell(
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('حذف اعلان'),
                                              content:
                                                  const SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(
                                                        'هل انت متأكد من الحذف؟'),
                                                    // Text('Would you like to approve of this message?'),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('لا'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    controller.removeads(
                                                        controller
                                                            .dataAdds[index]
                                                            .id!);
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  },
                                                  child: const Text('نعم'),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
