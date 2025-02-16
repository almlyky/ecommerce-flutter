// import 'dart:math';
// import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/firebase_options.dart';
import 'package:eccommerce_new/routes.dart';
import 'package:eccommerce_new/test/home2.dart';
import 'package:eccommerce_new/test/homework.dart';
// import 'package:eccommerce_new/test/AuthPhone.dart';
// import 'package:eccommerce_new/test/FilesPicker.dart';
// import 'package:eccommerce_new/test/homecamera.dart';
import 'package:eccommerce_new/core/serveces/serveces.dart';
import 'package:eccommerce_new/view/screan/contentapp/map.dart';
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

// class PlatformHelper {
//   static const MethodChannel _channel = MethodChannel('com.example.channel');

//   static Future<String?> getNativeMessage() async {
//     try {
//       final String? result = await _channel.invoke Method('getMessage');
//       return result;
//     } on PlatformException catch (e) {
//       return "Failed: ${e.message}";
//     }
//   }
// }

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
      // home: MyMapPage(),
      initialRoute: "/login",
      theme: ThemeData(
        fontFamily: "Cairo",
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Appcolor.iconcolor),
            color: Appcolor.backgroundAppbar,
            titleTextStyle: TextStyle(
              fontFamily: "Cairo",
              color: Appcolor.primarytext, // تغيير لون النص
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
              foregroundColor:Appcolor.textbuttoncolor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor:Appcolor.buttoncolor, // لون الخلفية لـ ElevatedButton
            ),
            // ),
            // textButtonTheme: TextButtonThemeData(
            //   style: ButtonStyle(
            //     foregroundColor: Coloors
            //   ))
          ),
            outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              // padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
              // foregroundColor:Appcolor.textbuttoncolor,
              // iconColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
              // backgroundColor:
                  // Appcolor.primary, // لون الخلفية لـ ElevatedButton
            ),),
          textTheme: const TextTheme(
            displayMedium: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, fontFamily: "Cairo",color: Color.fromARGB(255, 93, 92, 92)),
            displaySmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 17,color: Color.fromARGB(255, 93, 92, 92)),
            displayLarge: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "Cairo"),
          )
          ),
    );
  }
}
