import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/my_classes/crud.dart';

class CartData {
  Crud crud = Crud();
  getCart(int userid) async {
    var res = await crud.getrequst("$cartList/$userid/");
    return res.fold((l) => l, (r) => r);
  }

  removeCart(int productId, int userid) async {
    var res = await crud.deleteRequest("$deletecart/$productId/$userid/");
    return res.fold((l) => l, (r) => r);
  }

  addcart(int productId, int userid, int qt) async {
    var res = await crud.postrequst(insertcart,
        {"user_fk": "$userid", "pr_fk": "$productId", "quantity": "$qt"});
    return res.fold((l) => l, (r) => r);
  }

  updatequantitys(String action, int cartid) async {
    var res = await crud
        .updateRequest("$updatequantity/$cartid/", {"action": action});
    return res.fold((l) => l, (r) => r);
  }

  checkCoupon(String coName) async {
    var res = await crud.postrequst(checkcoupon,{"co_name":coName});
    return res.fold((l) => l, (r) => r);
  }
}
