import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:eccommerce_new/core/serveces/serveces.dart';
// import 'package:eccommerce_new/core/my_function/checkinternet.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Crud {

  // Map<String, String> header = {
  //   "Authorization":
  //       "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzMxMjQ1MDc2LCJpYXQiOjE3Mjk5NDkwNzYsImp0aSI6ImFhNmFmMjdhYTg4NjQyOGRiNzAwMmY2YWJmYjE4Mjc5IiwidXNlcl9pZCI6MX0.GaMLV5-wth8CZlBM_32MBM29BNO1CLItN1kaEPYUL7g"
  // };

 Future<Either<StatusRequest, Map>> postrequstWithoutAuth(String url, Map data) async {
    try {
      
      // if (checkinternet()) {
      var response = await http.post(Uri.parse(url), body: data);
      
      // print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        return right(responsebody);
      } else {
        return left(StatusRequest.failure);
      }
    }
    // else {
    //   return left(StatusRequest.offlineFailure);
    // }
    // }
    catch (e) {
      return left(StatusRequest.serverFailure);
    }
  }


  Future<Either<StatusRequest, Map>> postrequst(String url, Map data,String token) async {
    try {
      
      // if (checkinternet()) {
      var response = await http.post(Uri.parse(url), body: data, headers: {"Authorization":"Bearer $token"});
      
      // print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        return right(responsebody);
      } else {
        return left(StatusRequest.failure);
      }
    }
    // else {
    //   return left(StatusRequest.offlineFailure);
    // }
    // }
    catch (e) {
      return left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> postrequstFile(
      String url, Map data, File file,String token) async {
    try {
      // if (checkinternet()) {
      var request = http.MultipartRequest("post", Uri.parse(url));
      request.headers.addAll({"Authorization":"Bearer $token"});
      var len = await file.length();
      // print("response ============== $len");

      var stream = http.ByteStream(file.openRead());
      var multypairfile = http.MultipartFile("pr_image", stream, len,
          filename: basename(file.path));
      request.files.add(multypairfile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var myrequest = await request.send();
      var response = await http.Response.fromStream(myrequest);
      // print("response ============== ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        // print(responsebody);
        return right(responsebody);
      } else {
        return left(StatusRequest.serverFailure);
      }
    }
    // else {
    //   return left(StatusRequest.offlineFailure);
    // }
    // }
    catch (e) {
      return left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, Map>> putrequstFile(
      String url, Map data, File file,String token) async {
    try {
      // if (checkinternet()) {

      var request = http.MultipartRequest("put", Uri.parse(url));
      request.headers.addAll({"Authorization":"Bearer $token"});
      var len = await file.length();
      var stream = http.ByteStream(file.openRead());
      var multypairfile = http.MultipartFile("pr_image", stream, len,
          filename: basename(file.path));
      request.files.add(multypairfile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var myrequest = await request.send();
      var response = await http.Response.fromStream(myrequest);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        return right(responsebody);
      } else {
        return left(StatusRequest.serverFailure);
      }
    }
    // else {
    //   return left(StatusRequest.offlineFailure);
    // }
    // }
    catch (e) {
      return left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, dynamic>> getrequst(String url) async {
    try {
      // if (checkinternet()) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        return right(responsebody);
      } else {
        return left(StatusRequest.failure);
      }
      // }
      // else {
      //   return left(StatusRequest.offlineFailure);
      // }
    } catch (e) {
      return left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> deleteRequest(String url, String token) async {
    try {
      // if (checkinternet()) {
      var response = await http.delete(Uri.parse(url),headers: {"Authorization":"Bearer $token"});
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        // var responsebody = json.decode(utf8.decode(response.bodyBytes));
        return right({"status": "deleted"});
      } else {
        return left(StatusRequest.serverFailure);
      }
      // }
      // else {
      //   return left(StatusRequest.offlineFailure);
      // }
    } catch (e) {
      return left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, Map>> updateRequest(String url, Map data, String token) async {
    try {
      // if (checkinternet()) {
      var response =
          await http.put(Uri.parse(url), body: data, headers: {"Authorization":"Bearer $token"});
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        return right(responsebody);
      } else {
        return left(StatusRequest.serverFailure);
      }
      // }
      // else {
      //   return left(StatusRequest.offlineFailure);
      // }
    } catch (e) {
      return left(StatusRequest.failure);
    }
  }
}

Future<void> addCategory({
  required String catName,
  required String catNameEn,
  required File catImage,
}) async {
  // رابط API
  final url = Uri.parse("http://your-django-server.com/api/categories/");

  // إنشاء طلب multipart
  var request = http.MultipartRequest("POST", url);

  // إضافة البيانات إلى الطلب
  request.fields['cat_name'] = catName;
  request.fields['cat_name_en'] = catNameEn;

  // إضافة الصورة كملف
  request.files.add(
    await http.MultipartFile.fromPath(
      'cat_image', // اسم الحقل كما هو معرف في الموديل
      catImage.path,
    ),
  );

  // إرسال الطلب
  var response = await request.send();

  // معالجة الاستجابة
  if (response.statusCode == 201) {
    print("تم إضافة الفئة بنجاح");
  } else {
    print("فشل في إضافة الفئة: ${response.statusCode}");
  }
}
