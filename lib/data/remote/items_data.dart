import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/my_classes/crud.dart';

class ItemsData {
  Crud crud = Crud();

  getdataproduct(int catid, int userid) async {
    var res = await crud.getrequst("$djproduct/$catid/$userid/");
    return res.fold((l) => l, (r) => r);
  }

  searchdata(int userid, String search) async {
    var res = await crud.getrequst("$searchproduct/$userid/?keyword=$search");
    return res.fold((l) => l, (r) => r);
  }

  // getdataAllproduct() async {
  //   var res = await crud.getrequst(productList);
  //   return res.fold((l) => l, (r) => r);
  // }
}
