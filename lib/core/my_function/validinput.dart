import 'package:get/get.dart';

validinput(String val, int min, int max, String type, String error) {
  if (val.isEmpty) {
    return "cann't be empty";
  }
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "not valid username";
    }
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "not valid email";
    } else if ((error == "sign")) {
      return "the email is exist alredy";
    } else if (error == "login") {
      return "the acounts is not found";
    }
  }
  if (val.length < min) {
    return "cann't be less than $min";
  }
  if (val.length > max) {
    return "can't be larger than $max";
  }
}
