import 'dart:io';

import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/my_classes/crud.dart';

class Productdata {
  Crud crud = Crud();
  getAllproduct() async {
    var res = await crud.getrequst(productList);
    return res.fold((l) => l, (r) => r);
  }

  getproduct(int id) async {
    var res = await crud.getrequst("$productFk/$id/");
    return res.fold((l) => l, (r) => r);
  }


  removeProduct(int id)async{
    var res = await crud.deleteRequest("$productFk/$id/");
    return res.fold((l) => l, (r) => r);
  }

  insertProduct({
  required String prName,
  required String prNameEn,
  required File prImage,
  required int prCost,
  required String prDetail,
  required String prDetailEn,
  required int catFk})async{
    var res = await crud.postrequstFile(productList,{"pr_name":prName,"pr_name_en":prNameEn
    ,"pr_detail":prDetail,"pr_detail_en":prDetailEn,"pr_cost":"$prCost","cat_fk":"$catFk"},prImage);
    return res.fold((l) => l, (r) => r);
  }

  updateProduct({
  required int id,
  required String prName,
  required String prNameEn,
  required File prImage,
  required int prCost,
  required String prDetail,
  required String prDetailEn,
  required int catFk})async{
    var res = await crud.putrequstFile("$productFk/$id/",{"pr_name":prName,"pr_name_en":prNameEn
   ,"pr_detail":prDetail,"pr_detail_en":prDetailEn,"pr_cost":"$prCost","cat_fk":"$catFk"},prImage);
    return res.fold((l) => l, (r) => r);
  }

}
