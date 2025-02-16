import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/data/model/addsmodel.dart';
import 'package:eccommerce_new/view/screan/contentapp/setting.dart';
import 'package:eccommerce_new/view/screan/dashboard/addcategories.dart';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz_unsafe.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/my_function/curd.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/data/model/CategoriesModel.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:eccommerce_new/data/model/offermodel.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:eccommerce_new/data/remote/dashboard/productdata.dart';
import 'package:eccommerce_new/data/remote/homedata.dart';
import 'package:eccommerce_new/data/remote/items_data.dart';
import 'package:eccommerce_new/view/screan/contentapp/cart.dart';
import 'package:eccommerce_new/view/screan/contentapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../core/my_classes/statusrequest.dart';
import '../core/my_function/handledata.dart';

class homepagecontrolerimp extends GetxController {
  curd c = curd();
  int selectedIndex = 0;
  // Homedata homedata = Homedata();
  // ItemsData itemsData = ItemsData();
  bool isSearch = false;

  // List dataCat = [];
  List catName = [];
  List<AddsModel> dataAdds = [];
  // List dataProduct = [];
  // List dataProductSearch = [];

  late StatusRequest statusRequestCat;
  late StatusRequest statusRequestOffer = StatusRequest.loading;

  // late StatusRequest statusRequestCatProduct;
  late StatusRequest statusRequestSearch;
  late StatusRequest statusRequestAllProduct;
  List dataAllProduct = [];
  List<ProductModel> dataproductModels = [];
  List<CategoriesModel> datacatModel = [];
  List<ProductModel> dataproductSearchModel = [];

  // Productdata productdata = Productdata();
  Controldata controldata = Controldata();
  final ScrollController scrollController = ScrollController();
  RxDouble innerOffset = 0.0.obs;
  RxDouble totalhigtscroll = 1.0.obs;
  final CarouselSliderController carouselController =
      CarouselSliderController();
  RxInt currentIndex = 0.obs;
  Settingcontroller settingcontroller = Get.put(Settingcontroller());

  // late StatusRequest statusRequestAllProduct;

  getallproduct() async {
    dataproductModels.clear();
    statusRequestAllProduct = StatusRequest.loading;
    var response = await controldata.getData("$allproduct/${settingcontroller.userid}/");
    // productdata.getAllproduct(1);
    statusRequestAllProduct = handlingData(response);
    if (StatusRequest.success == statusRequestAllProduct) {
      List<ProductModel> products = response.map<ProductModel>((item) {
        return ProductModel.fromJson(item);
      }).toList();
      dataproductModels.addAll(products);
      // dataAllProduct.addAll(response);
    }
    update();
  }

  // getOffers() async {
  //   statusRequestOffer = StatusRequest.loading;
  //   var response = await controldata.getData(offer);
  //   statusRequestOffer = handlingData(response);
  //   if (StatusRequest.success == statusRequestOffer) {
  //     List<OfferModel> offer = response.map<OfferModel>((offer) {
  //       return OfferModel.fromJson(offer);
  //     }).toList();
  //     dataOffer.addAll(offer);
  //   }
  //   update();
  // }
  getAdds() async {
    statusRequestOffer = StatusRequest.loading;
    var response = await controldata.getData(apiGetAdds);
    statusRequestOffer = handlingData(response);
    if (StatusRequest.success == statusRequestOffer) {
      List<AddsModel> addmodel = response.map<AddsModel>((adds) {
        return AddsModel.fromJson(adds);
      }).toList();
      dataAdds.addAll(addmodel);
    }
    update();
  }

  getcategories() async {
    statusRequestCat = StatusRequest.loading;
    var response = await controldata.getData(djcatlist);
    // homedata.getdatacat();
    statusRequestCat = handlingData(response);
    if (StatusRequest.success == statusRequestCat) {
      List<CategoriesModel> categories = response.map<CategoriesModel>((item) {
        return CategoriesModel.fromJson(item);
      }).toList();
      datacatModel.addAll(categories);
      // dataCat.addAll(response);
    }
    for (var items in datacatModel) {
      catName.add(items.catName);
    }
    update();
  }

  getSearchproduct(String search) async {
    // dataProductSearch = [];
    statusRequestSearch = StatusRequest.loading;
    var response = await controldata
        .getData("$searchproduct/${settingcontroller.userid}/?keyword=$search");
    statusRequestSearch = handlingData(response);
    if (StatusRequest.success == statusRequestSearch) {
      List<ProductModel> products = response.map<ProductModel>((item) {
        return ProductModel.fromJson(item);
      }).toList();
      dataproductSearchModel.addAll(products);
    }
    update();
  }

  getDate() async {
    getcategories();
    await getallproduct();
    await getAdds();
  }

  @override
  void onInit() {
    getDate();
    scrollController.addListener(() {
      innerOffset.value = scrollController.offset;
      totalhigtscroll.value = scrollController.position.maxScrollExtent;
    });

    super.onInit();
  }

  TextEditingController searchtext = TextEditingController();
  checkSearch(val) {
    if (val == "") {
      isSearch = false;
    }
    update();
  }

  onSearchItems() {
    isSearch = true;
    getSearchproduct(searchtext.text);
    update();
  }

  // getcategories() async{
  //   var respons=await c.getrequest(djcatlist);
  //   return respons;
  // }
  //
  // getallproduct()async{
  //   var response=await c.postrequest(linkproduct2, {});
  //   return response;
  // }
  // getproduct(int id)async{
  //   // String id2=id.toString();
  //   var response=await c.getrequest("$djproduct/$id/");
  //   return response;
  // }
  gotoproduct() {
    Get.toNamed(AppRoute.product);
  }

  List<Widget> widgetOptions = <Widget>[
    const home(),
    const cart(),
    const Setting()
  ];
  onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

// ================================= controller dashboard ==================================

  GlobalKey<FormState> forminsertCategories = GlobalKey<FormState>();
  GlobalKey<FormState> forminsertproduct = GlobalKey<FormState>();

  TextEditingController nameCat = TextEditingController();
  TextEditingController nameCatEn = TextEditingController();

  ProductModel? productModel;
  CategoriesModel? categoriesModel;
  File? image;

  TextEditingController prname = TextEditingController();
  TextEditingController prnameEn = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController detailsEn = TextEditingController();
  TextEditingController price = TextEditingController();

  var selectedcategories;
  // curd c = curd();

  //==========================================================
  //list content name categories for Dropbutton
  // List<String> datadrop = [];
  // List dataAllProduct = [];
  // List dataproduct = [];

  late StatusRequest statusRequestUpdateProduct;
  late StatusRequest statusRequestOneProduct;
  late StatusRequest statusRequestaddProduct;
  late StatusRequest statusRequestRemoveProduct;

  // Productdata productdata = Productdata();
  late int productId;

//===================== go to edet page ===============
  gotoEdeteProduct() async {
    prname.text = productModel!.prName!;
    prnameEn.text = productModel!.prNameEn!;
    details.text = productModel!.prDetail!;
    detailsEn.text = productModel!.prDetailEn!;
    price.text = "${productModel!.prCost}";
    String catname = "";
    for (int i = 0; i < datacatModel.length; i++) {
      if (productModel!.catFk == datacatModel[i].catId) {
        catname = datacatModel[i].catName!;
      }
    }
    selectedcategories = catname;

    Uri uri = Uri.parse(productModel!.prImage!);
    String fileName = uri.pathSegments.last;
    var img = await http.get(uri);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final file = File('$tempPath/$fileName');
    await file.writeAsBytes(img.bodyBytes);

    image = file;
    Get.toNamed(AppRoute.edeteproduct);
  }

//============== add product ==================
  addProduct() async {
    statusRequestaddProduct = StatusRequest.loading;
    int catid = await getcatid(selectedcategories);
    ProductModel productModel = ProductModel();
    productModel.prName = prname.text;
    productModel.prNameEn = prnameEn.text;
    productModel.prDetail = details.text;
    productModel.prDetailEn = detailsEn.text;
    productModel.prCost = int.parse(price.text);
    productModel.catFk = catid;
    var data = productModel.toJson();

    var response = await controldata.addDatawithFile(
        productList, data, image!, "pr_image", settingcontroller.accesstoken!);
    statusRequestaddProduct = handlingData(response);
    if (StatusRequest.success == statusRequestaddProduct) {
      ProductModel productModel = ProductModel.fromJson(response);
      dataproductModels.add(productModel);
      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم اضافه منتج جديد ",
              style: TextStyle(color: Colors.white)));
    }
    update();
  }

  // ================= remove product ========================
  removeProduct(int id) async {
    statusRequestRemoveProduct = StatusRequest.loading;
    var response = await controldata.deleteData(
        "$productFk/$id/", settingcontroller.accesstoken!);
    statusRequestRemoveProduct = handlingData(response);
    if (StatusRequest.success == statusRequestRemoveProduct) {
      // dataAllProduct.addAll(response);
      dataproductModels.removeWhere((element) => element.prId == id);
      Get.rawSnackbar(
          title: "اشعار",
          messageText:
              const Text("تم حذف منتج", style: TextStyle(color: Colors.white)));
    }
    update();
  }

  // =============== update product =========================
  updateProduct(int id) async {
    statusRequestUpdateProduct = StatusRequest.loading;
    int catid = await getcatid(selectedcategories);
    ProductModel productModel = ProductModel();
    productModel.prName = prname.text;
    productModel.prNameEn = prnameEn.text;
    productModel.prDetail = details.text;
    productModel.prDetailEn = detailsEn.text;
    productModel.prCost = int.parse(price.text);
    productModel.catFk = catid;
    var data = productModel.toJson();

    var response = await controldata.uppdateDatawithFile("$productFk/$id/",
        data, image!, "pr_image", settingcontroller.accesstoken!);
    statusRequestUpdateProduct = handlingData(response);
    if (StatusRequest.success == statusRequestUpdateProduct) {
      ProductModel productModel = ProductModel.fromJson(response);
      // dataproductModels.add(productModel);
      for (int i = 0; i < dataproductModels.length; i++) {
        if (productModel.prId == dataproductModels[i].prId) {
          dataproductModels[i] = productModel;
        }
      }

      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم تعديل منتج",
              style: TextStyle(color: Colors.white)));
    }
    update();
  }

// ============= add categories =======================

  addcategories() async {
    statusRequestCat = StatusRequest.loading;
    CategoriesModel categoriesModelinsert = CategoriesModel();
    categoriesModelinsert.catName = nameCat.text;
    categoriesModelinsert.catNameEn = nameCatEn.text;
    var data = categoriesModelinsert.toJson();

    var response = await controldata.addDatawithFile(
        djcatlist, data, image!, "cat_image", settingcontroller.accesstoken!);
    // homedata.getdatacat();
    statusRequestCat = handlingData(response);
    if (StatusRequest.success == statusRequestCat) {
      CategoriesModel categoriesModel = CategoriesModel.fromJson(response);
      datacatModel.add(categoriesModel);
      catName.add(categoriesModel.catName);
      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم اضافه صنف جديد ",
              style: TextStyle(color: Colors.white)));
    }
    // dataCat.addAll(response);
    update();
  }
// ============= update categories =======================

  uppdatecategories(int id) async {
    statusRequestCat = StatusRequest.loading;
    CategoriesModel categoriesModelinsert = CategoriesModel();
    categoriesModelinsert.catName = nameCat.text;
    categoriesModelinsert.catNameEn = nameCatEn.text;
    var data = categoriesModelinsert.toJson();
    // print(data);

    var response = await controldata.uppdateDatawithFile("$djcatlist$id/", data,
        image!, "cat_image", settingcontroller.accesstoken!);
    // homedata.getdatacat();
    print(response);
    statusRequestCat = handlingData(response);
    if (StatusRequest.success == statusRequestCat) {
      CategoriesModel categoriesModel = CategoriesModel.fromJson(response);
      // datacatModel.add(categoriesModel);
      for (int i = 0; i < datacatModel.length; i++) {
        if (categoriesModel.catId == datacatModel[i].catId) {
          datacatModel[i] = categoriesModel;
          catName[i] = categoriesModel.catName;
        }
      }
      // catName.add(categoriesModel.catName);
      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم تعديل الصنف  ",
              style: TextStyle(color: Colors.white)));
    }
    // dataCat.addAll(response);
    update();
  }

  //==========================================================
  gotoinsertcategories() {
    Get.toNamed(AppRoute.insertcategories);
  }

  gotoinsertproduct() {
    Get.toNamed(AppRoute.insertproduct);
  }

  gotoedeteCategories() async {
    nameCat.text = categoriesModel!.catName!;
    nameCatEn.text = categoriesModel!.catNameEn!;

    Uri uri = Uri.parse(categoriesModel!.catImage!);
    String fileName = uri.pathSegments.last;
    var img = await http.get(uri);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final file = File('$tempPath/$fileName');
    await file.writeAsBytes(img.bodyBytes);
    image = file;
    Get.toNamed(AppRoute.edetecategories);
  }

  //==========================================================
  //transformation catname to cat id
  getcatid(String name) async {
    // List cat = controlerhome.datacatModel;
    for (int i = 0; i < datacatModel.length; i++) {
      if (datacatModel[i].catName == name) {
        return datacatModel[i].catId;
      }
    }
  }

//==========================================================
  //changed select dropdownbutton
  changselected(var v) {
    selectedcategories = v;
    update();
  }

  //==========================================================
  //function change image from gallery
  Future<void> choseimage() async {
    final ImagePicker picker = ImagePicker();
    final pickerfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerfile != null) {
      image = File(pickerfile.path);
      update();
    } else {
      print("not file ");
    }
  }

  // ========================================================
  //

  //==========================================================
  //function inserting categories data
  // insertdatacategories() async {
  //   var formstat = forminsert.currentState;
  //   if (formstat!.validate()) {
  //     var response = await c.Fielpostrequest(
  //         linkinsertdata2, {"name": name.text, 'table': 'categories'}, image!);
  //     if (response["status"] == "success") {
  //       Get.snackbar("edet data", "successful insert categories",
  //           snackPosition: SnackPosition.BOTTOM);
  //     } else {
  //       Get.snackbar("edet data", "failer insert categories",
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   }
  // }

//==========================================================
//  function inserting product data
  // insertdataproduct() async {
  //   var formstat = forminsertproduct.currentState;
  //   var id = await getcatid(selectedcategories);
  //   if (formstat!.validate()) {
  //     // print(id.runtimeType);
  //     int pr = int.parse(price.text);
  //     var response = await c.Fielpostrequest(
  //         linkinsertdata2,
  //         {
  //           "name": prname.text,
  //           "details": details.text,
  //           "price": '$pr',
  //           "categories": '$id',
  //           'table': 'product'
  //         },
  //         image!);
  //     if (response["status"] == "success") {
  //       Get.snackbar("edet data", "successful insert product",
  //           snackPosition: SnackPosition.BOTTOM);
  //     } else {
  //       Get.snackbar("edet data", "failer insert product",
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   }
  // }

//==========================================================
  //  function send categories data fro show in editing page
  // datacatforedete(var snapshot) async {
  //   List<dynamic> data = [];
  //   var im = await http.get(Uri.parse('{snapshot["cat_image"]}'));
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   final file = File('$tempPath/${snapshot["cat_image"]}');
  //   await file.writeAsBytes(im.bodyBytes);
  //   data.add(snapshot["cat_name"]);
  //   data.add(file);
  //   return data;
  // }

//==========================================================
//  function send product data fro show in editing page
  // dataproductforedete(int i, var snapshot) async {
  //   List<dynamic> cat = await controlerhome.getcategories();
  //   String catname = "";
  //   for (int i = 0; i < cat.length; i++) {
  //     if (snapshot["cat_fk"] == cat[i]['cat_id']) catname = cat[i]["cat_name"];
  //   }
  //   List<dynamic> data = [];
  //   var im = await http.get(Uri.parse(
  //       'http://10.0.2.2/ecomerceApp/categories/${snapshot["pr_image"]}'));
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;
  //   final file = File('$tempPath/${snapshot["pr_image"]}');
  //   await file.writeAsBytes(im.bodyBytes);
  //   data.add(snapshot["pr_name"]);
  //   data.add(snapshot["pr_detail"]);
  //   data.add(snapshot["pr_cost"]);
  //   data.add(catname);
  //   data.add(file);
  //   return data;
  // }

//==========================================================
//  function edete prodduct
  // edetedataproduct(int id) async {
  //   var formstat = forminsertproduct.currentState;
  //   var catid = await getcatid(selectedcategories);
  //   if (formstat!.validate()) {
  //     // print(id.runtimeType);
  //     int pr = int.parse(price.text);
  //     var response = await c.Fielpostrequest(
  //         linkedetedata2,
  //         {
  //           "name": prname.text,
  //           "details": details.text,
  //           "price": '$pr',
  //           "categories": '$catid',
  //           'id': '$id',
  //           'table': 'product'
  //         },
  //         image!);
  //     if (response["status"] == "success") {
  //       Get.snackbar("edet data", "successful edete product",
  //           snackPosition: SnackPosition.BOTTOM);
  //     } else {
  //       Get.snackbar("edet data", "failer edete produt",
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   }
  // }

//==========================================================
//  function edete categories
  // edetecategories(int id) async {
  //   var formstat = forminsert.currentState;
  //   if (formstat!.validate()) {
  //     var response = await c.Fielpostrequest(linkedetedata2,
  //         {"name": name.text, 'table': 'categories', 'id': '$id'}, image!);
  //     if (response["status"] == "success") {
  //       Get.snackbar("edet data", "successful edete categories",
  //           snackPosition: SnackPosition.BOTTOM);
  //     } else {
  //       Get.snackbar("edet data", "failer edete categories",
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   }
  // }
}
