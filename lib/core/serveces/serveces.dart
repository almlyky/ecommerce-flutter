import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class setteng extends GetxService {
  late SharedPreferences shared;

  Future<setteng> init() async {
    shared = await SharedPreferences.getInstance();
    return this;
  }
}
