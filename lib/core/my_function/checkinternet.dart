import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';

// checkinternet()async{
//   try{
//     var result=await InternetAddress.lookup("google.com");
//     if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       return true;
//     }
//   }
//  on SocketException catch(_){
//     return false;
//   }
// }

checkinternet()async{
final bool isConnected = await InternetConnectionChecker.instance.hasConnection;
if(isConnected){
  return true;
}else{
  return false;
}
}