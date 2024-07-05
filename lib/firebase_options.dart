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
    apiKey: 'AIzaSyBLhNRQUp3_tbVfmeYLVu-mGxGgHQjytgc',
    appId: '1:499141809306:web:fcd7c07fe25c31dc847b23',
    messagingSenderId: '499141809306',
    projectId: 'led-notificaciones',
    authDomain: 'led-notificaciones.firebaseapp.com',
    storageBucket: 'led-notificaciones.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyH_qOkp4g2XSD24JHWjeRLSBlKh80iy4',
    appId: '1:499141809306:android:fcbf78818793e4ab847b23',
    messagingSenderId: '499141809306',
    projectId: 'led-notificaciones',
    storageBucket: 'led-notificaciones.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEaE1-Va_UwGITKh-lkAtT5Rl4w8lZthk',
    appId: '1:499141809306:ios:82b9ed9b8ef51c22847b23',
    messagingSenderId: '499141809306',
    projectId: 'led-notificaciones',
    storageBucket: 'led-notificaciones.appspot.com',
    iosBundleId: 'com.example.ledNotificacionesSmartphone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEaE1-Va_UwGITKh-lkAtT5Rl4w8lZthk',
    appId: '1:499141809306:ios:82b9ed9b8ef51c22847b23',
    messagingSenderId: '499141809306',
    projectId: 'led-notificaciones',
    storageBucket: 'led-notificaciones.appspot.com',
    iosBundleId: 'com.example.ledNotificacionesSmartphone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBLhNRQUp3_tbVfmeYLVu-mGxGgHQjytgc',
    appId: '1:499141809306:web:c0799ec91216ca4d847b23',
    messagingSenderId: '499141809306',
    projectId: 'led-notificaciones',
    authDomain: 'led-notificaciones.firebaseapp.com',
    storageBucket: 'led-notificaciones.appspot.com',
  );

}