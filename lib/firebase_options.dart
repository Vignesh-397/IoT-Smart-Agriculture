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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSQ4k940hIxkFOZX0ksLRR9IXM8nL8hR0',
    appId: '1:991107703452:android:dd7eede9070de71d568359',
    messagingSenderId: '991107703452',
    projectId: 'iot-smart-irrigation-88064',
    databaseURL: 'https://iot-smart-irrigation-88064-default-rtdb.firebaseio.com',
    storageBucket: 'iot-smart-irrigation-88064.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSQPLbiK_GAwzPdgjtqBtXMuw_9q9EiEk',
    appId: '1:991107703452:ios:aef5905997ecbbc7568359',
    messagingSenderId: '991107703452',
    projectId: 'iot-smart-irrigation-88064',
    databaseURL: 'https://iot-smart-irrigation-88064-default-rtdb.firebaseio.com',
    storageBucket: 'iot-smart-irrigation-88064.appspot.com',
    iosBundleId: 'com.example.smartIrrigationIot',
  );
}
