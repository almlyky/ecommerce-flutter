import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:eccommerce_new/controler/contentapp/settingcontroller.dart';
import 'package:eccommerce_new/data/model/addsmodel.dart';
import 'package:eccommerce_new/view/screan/contentapp/favorate.dart';
import 'package:eccommerce_new/view/screan/contentapp/setting.dart';
import 'package:http/http.dart' as http;

import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/data/model/CategoriesModel.dart';
import 'package:eccommerce_new/data/model/ProductModel.dart';
import 'package:eccommerce_new/data/remote/controlData.dart';
import 'package:eccommerce_new/view/screan/contentapp/cart.dart';
import 'package:eccommerce_new/view/screan/contentapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../core/my_classes/statusrequest.dart';
import '../core/my_function/handledata.dart';

class homepagecontrolerimp extends GetxController {
  int selectedIndex = 0;
  bool isSearch = false;

  List catName = [];
  List<AddsModel> dataAdds = [];

  late StatusRequest statusRequestCat;
  late StatusRequest statusRequestOffer = StatusRequest.loading;

  late StatusRequest statusRequestSearch;
  late StatusRequest statusRequestAllProduct;
  List dataAllProduct = [];
  List<ProductModel> dataproductModels = [];
  List<CategoriesModel> datacatModel = [];
  List<ProductModel> dataproductSearchModel = [];

  Controldata controldata = Controldata();
  final ScrollController scrollController = ScrollController();
  RxDouble innerOffset = 0.0.obs;
  RxDouble totalhigtscroll = 1.0.obs;
  final CarouselSliderController carouselController =
      CarouselSliderController();
  RxInt currentIndex = 0.obs;
  Settingcontroller settingcontroller = Get.put(Settingcontroller());

  getallproduct() async {
    dataproductModels.clear();
    statusRequestAllProduct = StatusRequest.loading;
    var response =
        await controldata.getData("$allproduct/${settingcontroller.userid}/");
    // productdata.getAllproduct(1);
    statusRequestAllProduct = handlingData(response);
    if (StatusRequest.success == statusRequestAllProduct) {
      List<ProductModel> products = response.map<ProductModel>((item) {
        return ProductModel.fromJson(item);
      }).toList();
      dataproductModels.addAll(products);
    }
    update();
  }

  getAdds() async {
    statusRequestOffer = StatusRequest.loading;
    var response = await controldata.getData(apiAdsView);
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

  gotoproduct() {
    Get.toNamed(AppRoute.product);
  }

  List<Widget> widgetOptions = <Widget>[
    const home(),
    const cart(),
    const favorate(),
    const Setting()
  ];
  onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

// ================================= controller dashboard ==================================

  GlobalKey<FormState> forminsertCategories = GlobalKey<FormState>();
  GlobalKey<FormState> forminsertproduct = GlobalKey<FormState>();
  GlobalKey<FormState> forminsertads = GlobalKey<FormState>();
  GlobalKey<FormState> forminsertcoupon = GlobalKey<FormState>();


  TextEditingController nameCat = TextEditingController();
  TextEditingController nameCatEn = TextEditingController();

  TextEditingController url = TextEditingController();
  TextEditingController expireddate = TextEditingController();

  TextEditingController couponName = TextEditingController();
  TextEditingController couponCount = TextEditingController();
  TextEditingController couponDiscount = TextEditingController();
  TextEditingController couponExpiredDate = TextEditingController();


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

  late StatusRequest statusRequestaddAds;
  late StatusRequest statusRequestremoveAds;
  late StatusRequest statusRequestUpdateAds;

  late AddsModel addsModel;

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

  // ============== add ads =======================

  addads() async {
    if (forminsertads.currentState!.validate()) {
      statusRequestaddAds = StatusRequest.loading;
      var response = await controldata.addDatawithFile(
          apiAdsView,
          {"url": url.text, "expired_adds": expireddate.text},
          image!,
          "image",
          settingcontroller.accesstoken!);
      statusRequestaddAds = handlingData(response);
      if (StatusRequest.success == statusRequestaddAds) {
        dataAdds.add(AddsModel.fromJson(response));
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("تم اضافه اعلان جديد ",
                style: TextStyle(color: Colors.white)));
      }
      update();
    }
  }

  // ================= remove ads =======================

  removeads(int id) async {
    statusRequestremoveAds = StatusRequest.loading;
    var response = await controldata.deleteData(
        "$apiAdsView$id/", settingcontroller.accesstoken!);
    statusRequestremoveAds = handlingData(response);
    if (StatusRequest.success == statusRequestremoveAds) {
      dataAdds.removeWhere((element) => element.id == id);
      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم حذف الاعلان ",
              style: TextStyle(color: Colors.white)));
    }
    update();
  }

  // ================= update ads =======================

  updateads(int id) async {
    if (forminsertads.currentState!.validate()) {
      statusRequestUpdateAds = StatusRequest.loading;
      var response = await controldata.uppdateDatawithFile(
          "$apiAdsView$id/",
          {"url": url.text, "expired_adds": expireddate.text},
          image!,
          "image",
          settingcontroller.accesstoken!);
      statusRequestUpdateAds = handlingData(response);
      if (StatusRequest.success == statusRequestUpdateAds) {
        for (int i = 0; i < dataAdds.length; i++) {
          if (dataAdds[i].id == id) {
            dataAdds[i] = AddsModel.fromJson(response);
          }
        }
        Get.rawSnackbar(
            title: "اشعار",
            messageText: const Text("تم تعديل الاعلان ",
                style: TextStyle(color: Colors.white)));
      }
      update();
    }
  }

  // ================= chose date =======================

  choseDate(BuildContext context,TextEditingController controller) async {
    DateTime? dateTimepicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2100));
    if (dateTimepicker != null) {
      controller.text = "${dateTimepicker.toLocal()}".split(' ')[0];
    }
  }

  //==========================================================
  gotoinsertcategories() {
    Get.toNamed(AppRoute.insertcategories);
  }

  gotoinsertproduct() {
    Get.toNamed(AppRoute.insertproduct);
  }

  gotoEditeAds() async {
    url.text = addsModel.url!;
    expireddate.text = addsModel.expiredAdds!;
    print(addsModel.image);
    image = await saveimagetofile(addsModel.image!);
    Get.toNamed(AppRoute.editeads);
  }

  gotoedeteCategories() async {
    nameCat.text = categoriesModel!.catName!;
    nameCatEn.text = categoriesModel!.catNameEn!;
    image = await saveimagetofile(categoriesModel!.catImage!);
    Get.toNamed(AppRoute.edetecategories);
  }
  // ==================== save image from network to file ========================

  saveimagetofile(String imageurl) async {
    Uri uri = Uri.parse(imageurl);
    String fileName = uri.pathSegments.last;
    var img = await http.get(uri);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final file = File('$tempPath/$fileName');
    await file.writeAsBytes(img.bodyBytes);
    return file;
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
}
