import 'dart:io';
import 'package:eccommerce_new/core/my_classes/crud.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/my_function/handledata.dart';
import 'package:eccommerce_new/data/remote/dashboard/categoriesdata.dart';
import 'package:eccommerce_new/data/remote/dashboard/productdata.dart';
import 'package:eccommerce_new/view/screan/dashboard/addcategories.dart';
import 'package:eccommerce_new/view/screan/dashboard/categoris.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eccommerce_new/core/my_function/curd.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/constant/linksapi.dart';
import '../../core/constant/route.dart';
import '../homepagecontroler.dart';
import 'package:path/path.dart';
import 'dart:convert';
// import 'dart:io';

class dashhomcontrollerimp extends GetxController {
  File? image;

  homepagecontrolerimp controlerhome = Get.find();
  GlobalKey<FormState> forminsert = GlobalKey<FormState>();
  GlobalKey<FormState> forminsertproduct = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();

  

  TextEditingController prname = TextEditingController();
  TextEditingController prnameEn = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController detailsEn = TextEditingController();
  TextEditingController price = TextEditingController();

  var selectedcategories;
  curd c = curd();

  //==========================================================
  //list content name categories for Dropbutton
  // List<String> datadrop = [];
  List dataAllProduct = [];
  List dataproduct = [];

  late StatusRequest statusRequestAllProduct;
  late StatusRequest statusRequestUpdateProduct;
  late StatusRequest statusRequestOneProduct;
  late StatusRequest statusRequestaddProduct;
  late StatusRequest statusRequestRemoveProduct;

  Productdata productdata = Productdata();
  Categoriesdata categoriesdata =Categoriesdata();
  late int productId;

  // data() async {
  //   List<dynamic> cat = await controlerhome.getcategories();
  //   for (int i = 0; i < cat.length; i++) {
  //     datadrop.add(cat[i]["cat_name"]);
  //     // selectedcategories=datadrop[0];
  //   }
  //   update();
  // }
//==================== get all product ==============
  getallproduct() async {
    statusRequestAllProduct = StatusRequest.loading;
    var response = await productdata.getAllproduct(1);
    statusRequestAllProduct = handlingData(response);
    if (StatusRequest.success == statusRequestAllProduct) {
      dataAllProduct.addAll(response);
    }
    update();
  }
//================= get one product for updated data =============

  getProduct(int id) async {
    dataproduct.clear();
    statusRequestOneProduct = StatusRequest.loading;
    var response = await productdata.getproduct(id);
    statusRequestOneProduct = handlingData(response);
    // print(response);

    if (StatusRequest.success == statusRequestOneProduct) {
      // dataproduct.addAll(response);
      // print(response);
      dataproduct.add(response);

      String catname = "";
      for (int i = 0; i < controlerhome.dataCat.length; i++) {
        if (response["cat_fk"] == controlerhome.dataCat[i]['cat_id']) {
          catname = controlerhome.dataCat[i]["cat_name"];
        }
      }
      productId = response['pr_id'];
      prname.text = response["pr_name"];
      prnameEn.text = response['pr_name_en'];
      details.text = response['pr_detail'];
      detailsEn.text = response['pr_detail_en'];
      price.text = "${response['pr_cost']}";
      selectedcategories = catname;
      Uri uri = Uri.parse(response['pr_image']);
      String fileName = uri.pathSegments.last;
      var img = await http.get(uri);
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      final file = File('$tempPath/$fileName');
      await file.writeAsBytes(img.bodyBytes);

      image = file;

      // .text = response[3];
    }
    update();
  }

//===================== go to edet page ===============
  gotoEdetePage(int id) async {
    await getProduct(id);
    Get.toNamed(AppRoute.edeteproduct);
  }

//============== add product ==================
  addProduct() async {
    statusRequestaddProduct = StatusRequest.loading;
    int catid = await getcatid(selectedcategories);
    var response = await productdata.insertProduct(
        prName: prname.text,
        prNameEn: prnameEn.text,
        prImage: image!,
        prCost: int.parse(price.text),
        prDetail: details.text,
        prDetailEn: detailsEn.text,
        catFk: catid);
    statusRequestaddProduct = handlingData(response);
    if (StatusRequest.success == statusRequestaddProduct) {
      // dataAllProduct.addAll(response);
      dataAllProduct.add(response);
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
    var response = await productdata.removeProduct(id);
    statusRequestRemoveProduct = handlingData(response);
    if (StatusRequest.success == statusRequestRemoveProduct) {
      // dataAllProduct.addAll(response);
      dataAllProduct.removeWhere((element) => element['pr_id'] == id);
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
    var response = await productdata.updateProduct(
        id: id,
        prName: prname.text,
        prNameEn: prnameEn.text,
        prImage: image!,
        prCost: int.parse(price.text),
        prDetail: details.text,
        prDetailEn: detailsEn.text,
        catFk: catid);
    statusRequestUpdateProduct = handlingData(response);
    if (StatusRequest.success == statusRequestUpdateProduct) {
      for (int i = 0; i < dataAllProduct.length; i++) {
        if (response["pr_id"] == dataAllProduct[i]['pr_id']) {
          dataAllProduct[i] = response;
        }
      }

      Get.rawSnackbar(
          title: "اشعار",
          messageText: const Text("تم تعديل منتج",
              style: TextStyle(color: Colors.white)));
      update();
    }
  }
// ============= add categories =======================
addCategories()async{
  // var response =await categoriesdata.insertcat(catName: catName, catNameEn: catNameEn, catImage: catImage)
}
  @override
  void onInit() {
    getallproduct();
    //selectedcategories = controlerhome.catName[0];
    super.onInit();
  }

  // @override
  // void onReady() {
  //   // TODO: implement onReady

  //   super.onReady();
  // }
  //==========================================================
  gotoinsertcategories() {
    Get.toNamed(AppRoute.insertcategories);
  }

  gotoinsertproduct() {
    Get.toNamed(AppRoute.insertproduct);
  }

  //==========================================================
  //transformation catname to cat id
  getcatid(String name) async {
    List cat = controlerhome.dataCat;
    for (int i = 0; i < cat.length; i++) {
      if (cat[i]["cat_name"] == name) {
        return cat[i]["cat_id"];
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

  //==========================================================
  //function inserting categories data
  insertdatacategories() async {
    var formstat = forminsert.currentState;
    if (formstat!.validate()) {
      var response = await c.Fielpostrequest(
          linkinsertdata2, {"name": name.text, 'table': 'categories'}, image!);
      if (response["status"] == "success") {
        Get.snackbar("edet data", "successful insert categories",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("edet data", "failer insert categories",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

//==========================================================
//  function inserting product data
  insertdataproduct() async {
    var formstat = forminsertproduct.currentState;
    var id = await getcatid(selectedcategories);
    if (formstat!.validate()) {
      // print(id.runtimeType);
      int pr = int.parse(price.text);
      var response = await c.Fielpostrequest(
          linkinsertdata2,
          {
            "name": prname.text,
            "details": details.text,
            "price": '$pr',
            "categories": '$id',
            'table': 'product'
          },
          image!);
      if (response["status"] == "success") {
        Get.snackbar("edet data", "successful insert product",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("edet data", "failer insert product",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

//==========================================================
  //  function send categories data fro show in editing page
  datacatforedete(var snapshot) async {
    List<dynamic> data = [];
    var im = await http.get(Uri.parse('{snapshot["cat_image"]}'));
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final file = File('$tempPath/${snapshot["cat_image"]}');
    await file.writeAsBytes(im.bodyBytes);
    data.add(snapshot["cat_name"]);
    data.add(file);
    return data;
  }

//==========================================================
//  function send product data fro show in editing page
  dataproductforedete(int i, var snapshot) async {
    List<dynamic> cat = await controlerhome.getcategories();
    String catname = "";
    for (int i = 0; i < cat.length; i++) {
      if (snapshot["cat_fk"] == cat[i]['cat_id']) catname = cat[i]["cat_name"];
    }
    List<dynamic> data = [];
    var im = await http.get(Uri.parse(
        'http://10.0.2.2/ecomerceApp/categories/${snapshot["pr_image"]}'));
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final file = File('$tempPath/${snapshot["pr_image"]}');
    await file.writeAsBytes(im.bodyBytes);
    data.add(snapshot["pr_name"]);
    data.add(snapshot["pr_detail"]);
    data.add(snapshot["pr_cost"]);
    data.add(catname);
    data.add(file);
    return data;
  }

//==========================================================
//  function edete prodduct
  edetedataproduct(int id) async {
    var formstat = forminsertproduct.currentState;
    var catid = await getcatid(selectedcategories);
    if (formstat!.validate()) {
      // print(id.runtimeType);
      int pr = int.parse(price.text);
      var response = await c.Fielpostrequest(
          linkedetedata2,
          {
            "name": prname.text,
            "details": details.text,
            "price": '$pr',
            "categories": '$catid',
            'id': '$id',
            'table': 'product'
          },
          image!);
      if (response["status"] == "success") {
        Get.snackbar("edet data", "successful edete product",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("edet data", "failer edete produt",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

//==========================================================
//  function edete categories
  edetecategories(int id) async {
    var formstat = forminsert.currentState;
    if (formstat!.validate()) {
      var response = await c.Fielpostrequest(linkedetedata2,
          {"name": name.text, 'table': 'categories', 'id': '$id'}, image!);
      if (response["status"] == "success") {
        Get.snackbar("edet data", "successful edete categories",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("edet data", "failer edete categories",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
//==========================================================
}
