import 'package:eccommerce_new/core/constant/linksapi.dart';
import 'package:eccommerce_new/core/my_classes/crud.dart';

class Homedata {
  Crud crud = Crud();
  getdatacat() async {
    var res = await crud.getrequst(djcatlist);
    return res.fold((l) => l, (r) => r);
  }
}
