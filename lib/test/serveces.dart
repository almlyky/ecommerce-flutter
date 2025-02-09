import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class setteng extends GetxService {
  late SharedPreferences shared;
  Box? myBox;
  RxInt count = 0.obs;

  Future<Box> openbox(String boxname) async {
    if (!Hive.isBoxOpen(boxname)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    return await Hive.openBox(boxname);
  }

  Future<setteng> init() async {
    shared = await SharedPreferences.getInstance();
    return this;
  }

  void increment() {
    count.value++;
    shared.setInt("counter", count.value);
  }
}
