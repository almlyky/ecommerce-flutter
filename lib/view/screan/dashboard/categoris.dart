import 'package:eccommerce_new/core/my_classes/HandlingDataView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controler/homepagecontroler.dart';
import 'package:cached_network_image/cached_network_image.dart';

class categoriesdash extends StatelessWidget {
  const categoriesdash({super.key});


  @override
  Widget build(BuildContext context) {
    homepagecontrolerimp controlerhome = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("categories".tr),
        actions: [
          IconButton(onPressed: (){
                controlerhome.gotoinsertcategories();
          }, icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: GetBuilder<homepagecontrolerimp>(
                builder: (controller) => 
                  Handlingdataview(
                    statusRequest: controlerhome.statusRequestCat,
                    widgets:
                        // future: controlerhome.getcategories(),
                        ListView.builder(
                      itemCount: controlerhome.datacatModel.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                            leading: CachedNetworkImage(
                                imageUrl:
                                    "${controlerhome.datacatModel[i].catImage}",
                                imageBuilder: (context, imageprovider) =>
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: imageprovider),
                                      ),
                                      // child: Image(image: NetworkImage("$image/${snapshot.data![i]["cat_image"]}"),width: 80,height: 80)),
                                    ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, errors) =>
                                    const Icon(Icons.error, color: Colors.red)),
                            contentPadding: const EdgeInsets.all(10),
                            trailing: Column(
                              children: [
                                InkWell(
                                    child: const Icon(Icons.edit,
                                        color: Colors.greenAccent),
                                    onTap: () async {
                                      controlerhome.categoriesModel =
                                          controlerhome.datacatModel[i];
                                      controlerhome.gotoedeteCategories();
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
                                            title: const Text('حذف صنف'),
                                            content: const SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text('هل انت متأكد من الحذف؟'),
                                                  // Text('Would you like to approve of this message?'),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('لا'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, 'OK');
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
                            title:
                                Text("${controlerhome.datacatModel[i].catName}"),
                            subtitle: const Text("name"),
                          ),
                        );
                      },
                    )),
              ))
        ],
      ),
    );
  }
}
