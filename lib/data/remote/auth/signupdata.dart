import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/my_classes/crud.dart';

class Signupdata {
  Crud crud = Crud();
  signup(String username, String pass,String conPass, String email) async {
    var res = await crud.postrequst(
        djsignup, {"username": username, "password": pass,"confirmPassword":conPass, "email": email});
    return res.fold((l) => l, (r) => r);
  }
}
