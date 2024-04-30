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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAtHwOYSrKwBHuqkiHAZ1rkKlELRfgCkkE',
    appId: '1:901951790568:web:f1615e6ce07a71d3f4d85d',
    messagingSenderId: '901951790568',
    projectId: 'flutter-firebase-demo-ff842',
    authDomain: 'flutter-firebase-demo-ff842.firebaseapp.com',
    databaseURL: 'https://flutter-firebase-demo-ff842-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-firebase-demo-ff842.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJYGaplVDtJle_0qeT-VT6mKKWhMSsrFw',
    appId: '1:901951790568:android:37faa4def0e2d2b8f4d85d',
    messagingSenderId: '901951790568',
    projectId: 'flutter-firebase-demo-ff842',
    databaseURL: 'https://flutter-firebase-demo-ff842-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-firebase-demo-ff842.appspot.com',
  );
}