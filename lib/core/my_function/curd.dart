import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
class curd{
  Map<String,String> header={"Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI5MTA4NTc0LCJpYXQiOjE3Mjc4MTI1NzQsImp0aSI6ImJkYjU1NThjMzQ1ODQ2NWI4Y2NmYjNlNjA3NTEzNWQyIiwidXNlcl9pZCI6MX0.xb9kWoKGWbpBBLGmoMEf6DRAMf9wbiO8CymzBhBK9yk"

  };
  getrequest(String url) async{
 
    try{
    var response=await http.get(Uri.parse(url),headers:header);
    // print(response.body);
      if(response.statusCode==200) {
        var responsebody = json.decode(utf8.decode(response.bodyBytes));
        return responsebody;
      }
      else {
        print("error ${response.statusCode}");
      }
      }
    catch(e){
      print("error catch $e");
    }
}
//function post
   postrequest(String url,var data) async{
    try{
      var response=await http.post(Uri.parse(url),body: data,headers: header);
      if(response.statusCode==200) {
        print('Data added successfully');
      }
      else {
        print("error ${response.statusCode}");
      }
    }
    catch(e){
      print("error catch $e");
    }
  }
  Fielpostrequest(String url,Map data,File file) async{
    try{
      var request=http.MultipartRequest("post",Uri.parse(url));
      var len=await file.length();
      var stream=http.ByteStream(file.openRead());
      var multypairfile=http.MultipartFile("image",stream,len,filename:basename(file.path));
      request.files.add(multypairfile);
      data.forEach((key,value){
        request.fields[key]=value;
      });
      var myrequest=await request.send();
      var response=await http.Response.fromStream(myrequest);
      if(response.statusCode==200) {
        var responsebody =await jsonDecode(response.body);
        return responsebody;
      }
      else {
        print("error ${response.statusCode}");
      }
    }
    catch(e){
      print("error catch $e");
    }
  }

 updateData(String url,Map data) async {
  final response = await http.put(
    Uri.parse(url),
    headers: header,
    body: data,
  );

  if (response.statusCode == 200) {
    print('Data updated successfully');
  } else {
    print('Error: ${response.statusCode}');
  }
}

 deleteData(String url) async {
  final response = await http.delete(Uri.parse(url),headers: header);
  if (response.statusCode == 200) {
    print('Data deleted successfully');
  } else {
    print('Error: ${response.statusCode}');
  }
}

}
