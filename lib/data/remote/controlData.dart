import 'dart:io';

import 'package:eccommerce_new/core/api/crud.dart';
import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Controldata{
  Crud crud = Crud();


  getData(String api) async {
    var response = await crud.getrequst(api);
    return response.fold((l) => l, (r) => r);
  }

  getDataAuthentecation(String api,dynamic token) async {
    var response = await crud.getrequstAuthentecation(api,token);
    return response.fold((l) => l, (r) => r);
  }

    signinWithgoogle(User user) async {
    var response = await crud.postrequstAuthentication(apiSignGoogle, user);
    return response.fold((l) => l, (r) => r);
  }

  // signinWithgoogle(User user)async{
  //    var response = await crud.postrequstAuthentication(apiSignGoogle,user);
  //   return response.fold((l) => l, (r) => r);
  // }
  
  addData(String api,var data,String token)async{
   var response = await crud.postrequst(api,data,token);
    return response.fold((l) => l, (r) => r); 
  }

  addDataWithoutToken(String api,var data)async{
   var response = await crud.postrequstWitoutToken(api,data);
    return response.fold((l) => l, (r) => r); 
  }
  
  addDatawithFile(String api,Map<String, dynamic> data,File file,String imageName,String token)async{
   var response = await crud.postrequstFile(api,data,file,imageName,token);
    return response.fold((l) => l, (r) => r);
  }

    uppdateDatawithFile(String api,Map<String, dynamic> data,File file,String imageName,String token)async{
   var response = await crud.putrequstFile(api,data,file,imageName,token);
    return response.fold((l) => l, (r) => r);
  }
uppdateData(String api,Map<String, dynamic> data,String token)async{
   var response = await crud.updateRequest(api,data,token);
    return response.fold((l) => l, (r) => r);
  }
  patchData(String api,Map<String, dynamic> data,String token)async{
   var response = await crud.patchRequest(api,data,token);
    return response.fold((l) => l, (r) => r);
  }
  deleteData(String api,String token)async{
    var response = await crud.deleteRequest(api,token);
    return response.fold((l) => l, (r) => r); 
  }
}
