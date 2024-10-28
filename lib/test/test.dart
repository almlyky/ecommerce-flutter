// import 'dart:convert';
// import 'package:eccommerce_new/controler/testpagecontroler.dart';
// import 'package:eccommerce_new/core/constant/colors.dart';
// import 'package:eccommerce_new/view/widget/cardproduct.dart';
// import 'package:flutter/gestures.dart';
import 'package:eccommerce_new/controler/TestController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constant/linksapi.dart';
import '../../../core/localization/changelang.dart';
// import '../../../core/my_function/curd.dart';
import 'package:flutter/services.dart';

import '../core/my_classes/statusrequest.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _testState();
}

class _testState extends State<Test> {
  TestController controlertest = Get.put(TestController());
  late var datacat, dataproduct;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screanheight = MediaQuery.of(context).size.height;
    final bodyheight = screanheight - MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: AppBar(
          title: const Text("test"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
                  hintText: 'Search any Product..',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              // SizedBox(height: 5),
              //pageview

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Featured',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.sort),
                        label: const Text('Sort'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_alt_outlined),
                        label: const Text('Filter'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 100,
                child: GetBuilder<TestController>(builder: (controlertest) {
                  if (controlertest.statusRequest == StatusRequest.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controlertest.statusRequest ==
                      StatusRequest.serverFailure) {
                    return const Center(
                      child: Text("server failure"),
                    );
                  } else
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controlertest.data.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  // controlertest.gotoproduct(snapshot.data![i]["cat_id"]);
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
                                          "$image/${controlertest.data[i]["cat_image"]}",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(controlertest.data[i]["cat_name"]),
                          ],
                        );
                      },
                    );
                }
                    // else {
                    //   return const Center(
                    //     child: Text("No data available."),
                    //   );
                    // }
                    // ,}
                    ),
              ),

              //catiogreis
              // Container(
              //     height: 100,
              //     child: FutureBuilder(
              //       future: controlertest.getcategories(),
              //       builder: (context, AsyncSnapshot<dynamic> snapshot) {
              //         if (snapshot.hasData) {
              //           return ListView.builder(
              //               scrollDirection: Axis.horizontal,
              //               itemCount: snapshot.data!.length,
              //               itemBuilder: (context, i) {
              //                 return Column(
              //                   children: [
              //                     Expanded(
              //                       flex: 1,
              //                       child: InkWell(
              //                         onTap: () {
              //                           controlertest.gotoproduct(
              //                               snapshot.data![i]["cat_id"]);
              //                         },
              //                         child: Container(
              //                           margin: EdgeInsets.all(10),
              //                           width: 70,
              //                           decoration: const BoxDecoration(
              //                             shape: BoxShape.circle,
              //                             color: Colors.black12,
              //                             //borderRadius: BorderRadius.all(Radius.circular(25))
              //                           ),
              //                           child: Container(
              //                             height: 50,
              //                             width: 50,
              //                             decoration: BoxDecoration(
              //                               shape: BoxShape.circle,
              //                               image: DecorationImage(
              //                                   fit: BoxFit.fill,
              //                                   image: NetworkImage(
              //                                     "$image/${snapshot.data![i]["cat_image"]}",
              //                                   )),
              //                               //borderRadius: BorderRadius.all(Radius.circular(20))
              //                             ),
              //                             // child: Center(
              //                             //   child: Image.network(
              //                             //     "https://ecommerceapp773880.000webhostapp.com/categories/${snapshot.data![i]["cat_image"]}",width: 50,height: 50,
              //                             //     fit: BoxFit.fill,
              //                             //   ),
              //                             // ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                     Text(snapshot.data![i]["cat_name"])
              //                   ],
              //                 );
              //               });
              //         } else
              //           return Center(
              //               child: CircularProgressIndicator(
              //             color: Colors.red,
              //           ));
              //       },
              //     )),

              const SizedBox(height: 10),
              //pageview offers
              SizedBox(
                height: bodyheight / 3.5,
                child: PageView.builder(
                    // pageSnapping: false,
                    //dragStartBehavior: DragStartBehavior.start,
                    itemCount: 10,
                    itemBuilder: (context, i) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 4,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: 300,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            children: [
                              // Text and Button
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '50-40% OFF',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    const Text(
                                      'Now in (product)\nAll colours',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    OutlinedButton.icon(
                                      icon: const Icon(
                                          Icons.shopping_basket_outlined),
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      label: const Text(
                                        'Shop Now',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Image
                              Image.asset(
                                "assist/image/offer4.png",
                                width: 150,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),

              const SizedBox(height: 10),
              const Text(
                "Four you",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              // Container(
              //   height: 290,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 4,
              //       itemBuilder: (contex,i)=>Container(height: 400,width: 200,
              //           child: myProductCard(image: "car3.jpg", name: "TOYOTA", details: "details products", price: 20000, pr_id: 1, fav: 0))
              //   ),
              // )
            ],
          ),
        ));
  }
}
