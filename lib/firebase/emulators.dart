import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../services/logger.dart';
import 'firebase_providers.dart' show kFunctionsRegion;

/// Порты эмуляторов Firebase Suite. Должны совпадать с `firebase.json` (шаг 3).
class EmulatorPorts {
  const EmulatorPorts._();

  static const int auth = 9099;
  static const int firestore = 8080;
  static const int storage = 9199;
  static const int functions = 5001;
  static const int ui = 4000;
}

/// Подключает SDK к Firebase Emulator Suite.
///
/// Вызывается из bootstrap только при `AppConfig.useEmulators == true`
/// (dev-флейвор). [host] определяется по платформе в `AppConfig`
/// (web → `localhost`, Android-эмулятор → `10.0.2.2`).
Future<void> connectToEmulators(String host) async {
  try {
    await FirebaseAuth.instance.useAuthEmulator(host, EmulatorPorts.auth);
    FirebaseFirestore.instance.useFirestoreEmulator(host, EmulatorPorts.firestore);
    await FirebaseStorage.instance
        .useStorageEmulator(host, EmulatorPorts.storage);
    FirebaseFunctions.instanceFor(region: kFunctionsRegion)
        .useFunctionsEmulator(host, EmulatorPorts.functions);
    AppLogger.i('Подключены эмуляторы Firebase на $host '
        '(auth:${EmulatorPorts.auth}, firestore:${EmulatorPorts.firestore}, '
        'storage:${EmulatorPorts.storage}, functions:${EmulatorPorts.functions})');
  } catch (e, st) {
    AppLogger.e('Не удалось подключить эмуляторы Firebase', e, st);
    rethrow;
  }
}
