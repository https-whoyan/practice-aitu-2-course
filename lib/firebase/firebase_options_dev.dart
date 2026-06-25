// ВНИМАНИЕ: это НЕ сгенерированный flutterfire-файл, а заглушка для разработки.
//
// Сессия 1 ведётся целиком против Firebase Emulator Suite, поэтому реальный
// облачный проект не нужен. `projectId` с префиксом `demo-` — специальный режим
// Firebase SDK: клиент НИКОГДА не ходит в облако, только в эмулятор.
//
// Перед подключением реального dev-проекта замените этот файл выводом команды:
//   flutterfire configure --project=eduapp-dev \
//     --out=lib/firebase/firebase_options_dev.dart \
//     --android-package-name=com.example.eduapp.dev \
//     --ios-bundle-id=com.example.eduapp.dev
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Firebase-конфиг окружения **dev** (демо-проект для эмуляторов).
class DevFirebaseOptions {
  const DevFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        // На остальных платформах разработка не ведётся в Сессии 1.
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'demo-eduapp-dev',
    authDomain: 'demo-eduapp-dev.firebaseapp.com',
    storageBucket: 'demo-eduapp-dev.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'demo-eduapp-dev',
    storageBucket: 'demo-eduapp-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'demo-eduapp-dev',
    storageBucket: 'demo-eduapp-dev.appspot.com',
    iosBundleId: 'com.example.eduapp.dev',
  );
}
