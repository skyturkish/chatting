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
    apiKey: 'AIzaSyDgN5HxwD4hhTbrR5RwkJrbPJlmpXdLjnA',
    appId: '1:333758703047:web:41595b3ee7db207c28a5e2',
    messagingSenderId: '333758703047',
    projectId: 'firebase-group-sky-notes',
    authDomain: 'fir-group-sky-notes.firebaseapp.com',
    storageBucket: 'firebase-group-sky-notes.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRdBS4ROb4u4Ql3MGnDoYTbuWcDUrGiJA',
    appId: '1:333758703047:android:7146bab7c0e143f228a5e2',
    messagingSenderId: '333758703047',
    projectId: 'firebase-group-sky-notes',
    storageBucket: 'firebase-group-sky-notes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwHYkYYZ-av-g7Qu8FA5VVcX0-eriy85c',
    appId: '1:333758703047:ios:589adc0e6865008128a5e2',
    messagingSenderId: '333758703047',
    projectId: 'firebase-group-sky-notes',
    storageBucket: 'firebase-group-sky-notes.appspot.com',
    iosClientId: '333758703047-nme1gs9hut634nq0p3iqe12o2at0kgc5.apps.googleusercontent.com',
    iosBundleId: 'sky.sky.groupnotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwHYkYYZ-av-g7Qu8FA5VVcX0-eriy85c',
    appId: '1:333758703047:ios:589adc0e6865008128a5e2',
    messagingSenderId: '333758703047',
    projectId: 'firebase-group-sky-notes',
    storageBucket: 'firebase-group-sky-notes.appspot.com',
    iosClientId: '333758703047-nme1gs9hut634nq0p3iqe12o2at0kgc5.apps.googleusercontent.com',
    iosBundleId: 'sky.sky.groupnotes',
  );
}
