// Placeholder Firebase options for Piku & Friends.
//
// Structure mirrors bao_and_friends/lib/firebase_options.dart. Values below are
// NOT real credentials. Firebase.initializeApp will fail until this file is
// replaced, and main.dart already skips force-update when init throws.
//
// Console steps (do this before shipping):
// 1. Create a Firebase project (suggested id: piku-and-friends).
// 2. Register an Android app with applicationId
//    com.lazy_bear_club.pikurabbit.
// 3. Register an iOS app with bundle id com.lazybearclub.pikurabbit
//    if you want iOS Remote Config later (Dart options currently throw on iOS,
//    matching Bao).
// 4. Download google-services.json and GoogleService-Info.plist, or run:
//      dart pub global activate flutterfire_cli
//      flutterfire configure \
//        --project=<firebase-project-id> \
//        --android-package-name=com.lazy_bear_club.pikurabbit \
//        --ios-bundle-id=com.lazybearclub.pikurabbit
// 5. In Remote Config, add the same keys Bao uses:
//      force_update (bool), minimum_android_version (string),
//      latest_android_version (string).
//
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'PIKU_FIREBASE_API_KEY_PLACEHOLDER',
    appId: '1:000000000000:android:pikurabbitplaceholder',
    messagingSenderId: '000000000000',
    projectId: 'piku-and-friends',
    storageBucket: 'piku-and-friends.firebasestorage.app',
  );
}
