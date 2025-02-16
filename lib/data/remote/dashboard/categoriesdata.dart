// import 'dart:io';

// import 'package:eccommerce_new/core/constant/linksapi.dart';
// import 'package:eccommerce_new/core/my_classes/crud.dart';

// class Categoriesdata {
//   Crud crud = Crud();
  

//   removeCat(int id)async{
//     var res = await crud.deleteRequest("$categoriesFk/$id/","");
//     return res.fold((l) => l, (r) => r);
//   }

//   insertcat({
//    required String catName,
//   required String catNameEn,
//   required File catImage})async{
//     var res = await crud.postrequstFile(djcatlist,{"cat_name":catName,"cat_name_en":catNameEn},catImage,"");
//     return res.fold((l) => l, (r) => r);
//   }

//   updatetcat({
//     required int id,
//    required String catName,
//   required String catNameEn,
//   required File catImage})async{
//     var res = await crud.putrequstFile("$categoriesFk/$id/",{"cat_name":catName,"cat_name_en":catNameEn},catImage,"");
//     return res.fold((l) => l, (r) => r);
//   }

// }
