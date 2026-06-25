// ЗАГЛУШКА. Перед релизом замените выводом:
//   flutterfire configure --project=eduapp-prod \
//     --out=lib/firebase/firebase_options_prod.dart \
//     --android-package-name=com.example.eduapp \
//     --ios-bundle-id=com.example.eduapp
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Firebase-конфиг окружения **prod** (заполнить реальными ключами).
class ProdFirebaseOptions {
  const ProdFirebaseOptions._();

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
    apiKey: 'TODO-prod-api-key',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'eduapp-prod',
    authDomain: 'eduapp-prod.firebaseapp.com',
    storageBucket: 'eduapp-prod.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'TODO-prod-api-key',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'eduapp-prod',
    storageBucket: 'eduapp-prod.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'TODO-prod-api-key',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'eduapp-prod',
    storageBucket: 'eduapp-prod.appspot.com',
    iosBundleId: 'com.example.eduapp',
  );
}
