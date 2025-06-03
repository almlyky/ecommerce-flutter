import 'package:eccommerce_new/core/constant/colors.dart';
import 'package:eccommerce_new/core/constant/route.dart';
import 'package:eccommerce_new/firebase_options.dart';
import 'package:eccommerce_new/routes.dart';
import 'package:eccommerce_new/core/serveces/serveces.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'core/localization/changelang.dart';
import 'core/localization/translation.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // String accessToken = String.fromEnvironment("ACCESS_TOKEN");
  await dotenv.load(fileName: ".env");
  final accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
  MapboxOptions.setAccessToken(
    accessToken,
  );
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
      // home: Mapbox(),
      initialRoute: AppRoute.onboarding,
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
              foregroundColor: Appcolor.textbuttoncolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor:
                  Appcolor.buttoncolor, // لون الخلفية لـ ElevatedButton
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          textTheme: const TextTheme(
            displayMedium: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                fontFamily: "Cairo",
                color: Color.fromARGB(255, 93, 92, 92)),
            displaySmall: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Color.fromARGB(255, 93, 92, 92)),
            displayLarge: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "Cairo"),
          )),
    );
  }
}
