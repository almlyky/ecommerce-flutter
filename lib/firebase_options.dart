// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCg6tj_tDUFTPZ-dRmO1QZHoXHLXOaJAT0',
    appId: '1:752711510771:web:2b2a41dd7dded83abe6586',
    messagingSenderId: '752711510771',
    projectId: 'ecommerce-b3479',
    authDomain: 'ecommerce-b3479.firebaseapp.com',
    databaseURL: 'https://ecommerce-b3479-default-rtdb.firebaseio.com',
    storageBucket: 'ecommerce-b3479.firebasestorage.app',
    measurementId: 'G-E38HNM1LGG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcIN2-F8U2PCIpGKD3aHTeUzNMcQ8bKBQ',
    appId: '1:752711510771:android:889b44ae6ca5850dbe6586',
    messagingSenderId: '752711510771',
    projectId: 'ecommerce-b3479',
    databaseURL: 'https://ecommerce-b3479-default-rtdb.firebaseio.com',
    storageBucket: 'ecommerce-b3479.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCregACHBtJYT3OscHbQ8jrp46zNhIMaoI',
    appId: '1:752711510771:ios:937cf7131f3f7ba5be6586',
    messagingSenderId: '752711510771',
    projectId: 'ecommerce-b3479',
    databaseURL: 'https://ecommerce-b3479-default-rtdb.firebaseio.com',
    storageBucket: 'ecommerce-b3479.firebasestorage.app',
    androidClientId: '752711510771-5gg5a225mf2ljn3eme81eh4ibk5h74bf.apps.googleusercontent.com',
    iosClientId: '752711510771-n573ob21spki1jmn6dqecqlc8nbet9dj.apps.googleusercontent.com',
    iosBundleId: 'com.example.eccommerceNew',
  );

}