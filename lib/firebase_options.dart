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
        return macos;
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
    apiKey: 'AIzaSyBXX5jlDhSWTGf4J-xZgQx3duSr_ZRXI_E',
    appId: '1:1012806088609:web:2d750f30734acd7b9bfde0',
    messagingSenderId: '1012806088609',
    projectId: 'pvt-23',
    authDomain: 'pvt-23.firebaseapp.com',
    storageBucket: 'pvt-23.appspot.com',
    measurementId: 'G-SPCS77W682',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSVv1yxTyRzfmWk0C5UB0Vxu0Bj1YZpGU',
    appId: '1:1012806088609:android:d587ca706d7507929bfde0',
    messagingSenderId: '1012806088609',
    projectId: 'pvt-23',
    storageBucket: 'pvt-23.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvfcgUE9aSDdVFxCELpbLgWgmbBRyWsg0',
    appId: '1:1012806088609:ios:11bf2e7b428360879bfde0',
    messagingSenderId: '1012806088609',
    projectId: 'pvt-23',
    storageBucket: 'pvt-23.appspot.com',
    iosClientId: '1012806088609-r9feg4dro6pr29pl4h7fbsik6md6ajpn.apps.googleusercontent.com',
    iosBundleId: 'com.example.pvt23',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvfcgUE9aSDdVFxCELpbLgWgmbBRyWsg0',
    appId: '1:1012806088609:ios:11bf2e7b428360879bfde0',
    messagingSenderId: '1012806088609',
    projectId: 'pvt-23',
    storageBucket: 'pvt-23.appspot.com',
    iosClientId: '1012806088609-r9feg4dro6pr29pl4h7fbsik6md6ajpn.apps.googleusercontent.com',
    iosBundleId: 'com.example.pvt23',
  );
}
