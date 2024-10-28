import 'package:eccommerce_new/view/screan/dashboard/addcategories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controler/dashboard/dashhomecontroller.dart';
import '../../../controler/homepagecontroler.dart';
import '../../../core/constant/linksapi.dart';
import 'package:cached_network_image/cached_network_image.dart';

class categoriesdash extends StatefulWidget {
  const categoriesdash({super.key});

  @override
  State<categoriesdash> createState() => _categoriesdashState();
}

class _categoriesdashState extends State<categoriesdash> {
  homepagecontrolerimp controlerhome = Get.put(homepagecontrolerimp());
  dashhomcontrollerimp controller = Get.put(dashhomcontrollerimp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                controller.gotoinsertcategories();
              },
              child: const Text("add categories")),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
                future: controlerhome.getcategories(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                            leading: CachedNetworkImage(
                                imageUrl: "${snapshot.data![i]["cat_image"]}",
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
                                      var data = await controller
                                          .datacatforedete(snapshot.data[i]);
                                      Get.to(addcategories(
                                          id: snapshot.data[i]['cat_id'],
                                          typeevent: "edete",
                                          data: data));
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
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('لا'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  print("ok");
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
                            title: Text("${snapshot.data[i]["cat_name"]}"),
                            subtitle: const Text("name"),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.red,
                    ));
                  }
                }),
          ),
        ],
      ),
    );
  }
}
