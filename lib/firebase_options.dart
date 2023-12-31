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
    apiKey: 'AIzaSyCavuHh7jNm45ce7qJ_0EivT3gW3SI_P1U',
    appId: '1:1074517815242:web:376c67474996e969baa933',
    messagingSenderId: '1074517815242',
    projectId: 'chat-62998',
    authDomain: 'chat-62998.firebaseapp.com',
    storageBucket: 'chat-62998.appspot.com',
    measurementId: 'G-FNV56JBY43',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAs8WRQjA3y4qOen10_R7msXVX8uNfZPSQ',
    appId: '1:1074517815242:android:c68c55c9263119ddbaa933',
    messagingSenderId: '1074517815242',
    projectId: 'chat-62998',
    storageBucket: 'chat-62998.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmVbg2AB6Mky7J_cVj-rDBejxsNfWfl2A',
    appId: '1:1074517815242:ios:c9b91fca6ebd8ec7baa933',
    messagingSenderId: '1074517815242',
    projectId: 'chat-62998',
    storageBucket: 'chat-62998.appspot.com',
    iosClientId: '1074517815242-400uot4nn79ad83irsjotobfr06opaea.apps.googleusercontent.com',
    iosBundleId: 'com.example.healersChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCmVbg2AB6Mky7J_cVj-rDBejxsNfWfl2A',
    appId: '1:1074517815242:ios:8057f3a297e11fcebaa933',
    messagingSenderId: '1074517815242',
    projectId: 'chat-62998',
    storageBucket: 'chat-62998.appspot.com',
    iosClientId: '1074517815242-2bho2542jb98of57skud1rf7uvaecaig.apps.googleusercontent.com',
    iosBundleId: 'com.example.healersChat.RunnerTests',
  );
}
