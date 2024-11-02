// import 'dart:math';
// import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/firebase_options.dart';
import 'package:eccommerce_new/routes.dart';
import 'package:eccommerce_new/test/home2.dart';
import 'package:eccommerce_new/test/homework.dart';
// import 'package:eccommerce_new/test/AuthPhone.dart';
// import 'package:eccommerce_new/test/FilesPicker.dart';
// import 'package:eccommerce_new/test/homecamera.dart';
import 'package:eccommerce_new/test/serveces.dart';
// import 'package:eccommerce_new/test/test.dart';
// import 'package:eccommerce_new/view/screan/auth/login.dart';
// import 'package:eccommerce_new/view/screan/camera.dart';
// import 'package:eccommerce_new/view/screan/contentapp/HomeScrean.dart';
// import 'package:eccommerce_new/view/screan/contentapp/detailsproduct.dart';
// import 'package:eccommerce_new/view/screan/dashboard/addcategories.dart';
// import 'package:eccommerce_new/view/screan/dashboard/addproduct.dart';
// import 'package:eccommerce_new/view/screan/dashboard/dashhome.dart';
// import 'package:eccommerce_new/view/screan/dashboard/product.dart';
// import 'package:eccommerce_new/view/screan/language.dart';
// import 'package:eccommerce_new/view/screan/onboarding.dart';
// import 'package:eccommerce_new/view/screan/testscrean.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
// import 'package:eccommerce_new/view/screan/contentapp/homepage.dart';
import 'core/localization/changelang.dart';
import 'core/localization/translation.dart';
// import 'package:firebase_core/firebase_core.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.blue));
  await initial();
  runApp(const Myhomepage());
}

Future initial() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<setteng>(() => setteng().init());
}

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});
  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  @override
  Widget build(BuildContext context) {
    localecontroler controller = Get.put(localecontroler());
    return GetMaterialApp(
      locale: controller.language,
      translations: Mytranslte(),
      debugShowCheckedModeBanner: false,
      getPages: routeapp,
      initialRoute: "/login",
      // initialRoute: "/home",
      // home: const SignUpForm(),
      theme: ThemeData(
        
      // textButtonTheme: TextButtonThemeData(
      // style: TextButton.styleFrom(
      //   backgroundColor: Colors.red, // لون النص لـ TextButton
      // ),
      // ),
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: OutlinedButton.styleFrom(
    //     backgroundColor: Colors.purple, // لون النص لـ OutlinedButton
    //   ),
    // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber[600], // لون الخلفية لـ ElevatedButton
      ),
    ),
          textTheme: const TextTheme(
        displayMedium: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 17, fontFamily: "Cairo"),
        displaySmall: TextStyle(
             fontSize: 17),
        displayLarge: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "Cairo"),
      )),
      
    );
  }
}
