import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:eccommerce_new/core/my_classes/statusrequest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:eccommerce_new/core/my_function/checkinternet.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Crud {
  Future<Either<StatusRequest, dynamic>> postrequst(
      String url, var data) async {
    try {
      // if (checkinternet()) {
      // print("data");
      // print(data);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        // print(responsebody);
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
      print(e);
      return left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> postrequstAuthentication(
      String url, User user) async {
    try {
      // if (checkinternet()) {
      var response = await http.post(Uri.parse(url), body: {
        'google_id': user.uid, // استخدم UID الخاص بـ Google كـ username
        'email': user.email
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        // print(responsebody);
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
      print(e);
      return left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> postrequstFile(
      String url, Map data, File file, String imageName) async {
    try {
      // if (checkinternet()) {
      var request = http.MultipartRequest("post", Uri.parse(url));
      var len = await file.length();

      var stream = http.ByteStream(file.openRead());
      var multypairfile = http.MultipartFile(imageName, stream, len,
          filename: basename(file.path));
      request.files.add(multypairfile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var myrequest = await request.send();
      var response = await http.Response.fromStream(myrequest);
      print(response.body);

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
      print(e);
      return left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, dynamic>> putrequstFile(
      String url, dynamic data, File file, String imageName) async {
    try {
      // if (checkinternet()) {
      var request = http.MultipartRequest("put", Uri.parse(url));
      var len = await file.length();
      var stream = http.ByteStream(file.openRead());
      var multypairfile = http.MultipartFile(imageName, stream, len,
          filename: basename(file.path));
      request.files.add(multypairfile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var myrequest = await request.send();
      var response = await http.Response.fromStream(myrequest);
      print(response.body);
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
      print(e);
      return left(StatusRequest.serverFailure);
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
      print(e);
      return left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, dynamic>> getrequstAuthentecation(
      String url, dynamic token) async {
    try {
      // setteng controller = Get.find();
      Map<String, String> header = {"Authorization": "Bearer $token"};
      // print(header);
      // if (checkinternet()) {
      var response = await http.get(Uri.parse(url), headers: header);
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

  Future<Either<StatusRequest, Map>> deleteRequest(String url) async {
    try {
      // if (checkinternet()) {
      var response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return right({"status": "deleted"});
      } else {
        return left(StatusRequest.failure);
      }
    } catch (e) {
      return left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> updateRequest(String url, Map data) async {
    try {
      // if (checkinternet()) {
      var response = await http.put(Uri.parse(url), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        return right(responsebody);
      } else {
        return left(StatusRequest.failure);
      }
    } catch (e) {
      return left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> patchRequest(String url, Map data) async {
    try {
      // if (checkinternet()) {
      var response = await http.patch(Uri.parse(url), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        return right(responsebody);
      } else {
        return left(StatusRequest.failure);
      }
    } catch (e) {
      return left(StatusRequest.serverFailure);
    }
  }
}
