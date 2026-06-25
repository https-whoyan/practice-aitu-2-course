import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'firebase/emulators.dart';
import 'services/logger.dart';

/// Единая точка старта приложения для всех флейворов.
///
/// Каждый entrypoint (`main.dart` / `main_staging.dart` / `main_prod.dart`)
/// собирает свой [AppConfig] и передаёт сюда.
Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Единая точка для необработанных ошибок (позже — Crashlytics).
  FlutterError.onError = (details) {
    AppLogger.e('FlutterError', details.exception, details.stack);
    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.e('PlatformDispatcher', error, stack);
    return true;
  };

  AppLogger.i('bootstrap: $config');
  await Firebase.initializeApp(options: config.firebaseOptions);

  // В dev-флейворе вся работа идёт против Firebase Emulator Suite (шаг 3).
  if (config.useEmulators) {
    await connectToEmulators(config.emulatorHost);
  }

  runApp(
    ProviderScope(
      child: EduApp(config: config),
    ),
  );
}
