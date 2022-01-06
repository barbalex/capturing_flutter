// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCZeOZMau08kN0OLRDU4eIOzfzmN3Biayg',
    appId: '1:915526031201:web:d4e53be444640ea70d9720',
    messagingSenderId: '915526031201',
    projectId: 'capture-2ebb5',
    authDomain: 'capture-2ebb5.firebaseapp.com',
    storageBucket: 'capture-2ebb5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7_jxK89s0tkPodeX7LQ6lTayt5T0thW0',
    appId: '1:915526031201:android:c8397bbe8dd7b7080d9720',
    messagingSenderId: '915526031201',
    projectId: 'capture-2ebb5',
    storageBucket: 'capture-2ebb5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSYAw-NPIQ5P2pUNgQVurc3kwDjkf2u3Y',
    appId: '1:915526031201:ios:4e34dca0bf7568a50d9720',
    messagingSenderId: '915526031201',
    projectId: 'capture-2ebb5',
    storageBucket: 'capture-2ebb5.appspot.com',
    iosClientId: '915526031201-imq4grscdlehmusfcdbguddiuadk4jv3.apps.googleusercontent.com',
    iosBundleId: 'app.capturing',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSYAw-NPIQ5P2pUNgQVurc3kwDjkf2u3Y',
    appId: '1:915526031201:ios:4e34dca0bf7568a50d9720',
    messagingSenderId: '915526031201',
    projectId: 'capture-2ebb5',
    storageBucket: 'capture-2ebb5.appspot.com',
    iosClientId: '915526031201-imq4grscdlehmusfcdbguddiuadk4jv3.apps.googleusercontent.com',
    iosBundleId: 'app.capturing',
  );
}