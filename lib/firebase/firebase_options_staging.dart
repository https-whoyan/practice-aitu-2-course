// ЗАГЛУШКА. Перед запуском staging замените выводом:
//   flutterfire configure --project=eduapp-staging \
//     --out=lib/firebase/firebase_options_staging.dart \
//     --android-package-name=com.example.eduapp.staging \
//     --ios-bundle-id=com.example.eduapp.staging
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Firebase-конфиг окружения **staging** (заполнить реальными ключами).
class StagingFirebaseOptions {
  const StagingFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'TODO-staging-api-key',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'eduapp-staging',
    authDomain: 'eduapp-staging.firebaseapp.com',
    storageBucket: 'eduapp-staging.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'TODO-staging-api-key',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'eduapp-staging',
    storageBucket: 'eduapp-staging.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'TODO-staging-api-key',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'eduapp-staging',
    storageBucket: 'eduapp-staging.appspot.com',
    iosBundleId: 'com.example.eduapp.staging',
  );
}
