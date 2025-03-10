import 'package:get/get.dart';

validinput(String val, int min, int max, String type){
  if (val.isEmpty) {
    return "cannot_be_empty".tr;
  }
  if(type=="url"){
    if(!GetUtils.isURL(val)){
      return "not_a_valid_url".tr;
    }
  }

  if (type == "username" && !GetUtils.isUsername(val)) {
    return "not_a_valid_username".tr;
  }

  if (type == "email" && !GetUtils.isEmail(val)) {
    return "not_a_valid_email".tr;
  }

  if (val.length < min) {
    return "${"cannot_be_less_than".tr}$min";
  }

  if (val.length > max) {
    return "${"cannot_be_larger_than".tr}$max";
  }
  
  return null; // لا يوجد خطأ
}
