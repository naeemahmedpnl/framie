// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBTogGgWY58iojyr29CzQ6vMyhCGG72A0Y',
    appId: '1:4587000094:web:c2e55ef0f5a23b388fb90f',
    messagingSenderId: '4587000094',
    projectId: 'framieapp-c79fe',
    authDomain: 'framieapp-c79fe.firebaseapp.com',
    storageBucket: 'framieapp-c79fe.firebasestorage.app',
    measurementId: 'G-SQ2TS2C56F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB90GphsQpYbZs9Hmc1_nm643rQ2SZ6_OA',
    appId: '1:4587000094:android:5a1c5367ba7800838fb90f',
    messagingSenderId: '4587000094',
    projectId: 'framieapp-c79fe',
    storageBucket: 'framieapp-c79fe.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuPTUePL6_uyzp2Yrtj2aBFaxzL8c2kZE',
    appId: '1:4587000094:ios:103a631888eb299f8fb90f',
    messagingSenderId: '4587000094',
    projectId: 'framieapp-c79fe',
    storageBucket: 'framieapp-c79fe.firebasestorage.app',
    iosBundleId: 'com.venturevilla.beauty',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuPTUePL6_uyzp2Yrtj2aBFaxzL8c2kZE',
    appId: '1:4587000094:ios:103a631888eb299f8fb90f',
    messagingSenderId: '4587000094',
    projectId: 'framieapp-c79fe',
    storageBucket: 'framieapp-c79fe.firebasestorage.app',
    iosBundleId: 'com.venturevilla.beauty',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBTogGgWY58iojyr29CzQ6vMyhCGG72A0Y',
    appId: '1:4587000094:web:dcbe8c52cf0ebca68fb90f',
    messagingSenderId: '4587000094',
    projectId: 'framieapp-c79fe',
    authDomain: 'framieapp-c79fe.firebaseapp.com',
    storageBucket: 'framieapp-c79fe.firebasestorage.app',
    measurementId: 'G-6ED0D812TL',
  );

}