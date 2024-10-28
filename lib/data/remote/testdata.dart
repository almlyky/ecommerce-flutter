import 'package:eccommerce_new/core/my_classes/crud.dart';

class TestData {
  Crud crud = Crud();
  getdata() async {
    var res = await crud.getrequst("http://10.0.2.2:8000/pages/categoties/");
    return res.fold((l) => l, (r) => r);
  }
}
