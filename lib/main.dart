import 'bootstrap.dart';
import 'core/config/app_config.dart';
import 'firebase/firebase_options_dev.dart';

/// Entrypoint окружения **dev** (флейвор dev, против Firebase Emulator Suite).
///
/// Запуск:
///   flutter run -t lib/main.dart                 # web
///   flutter run --flavor dev -t lib/main.dart    # Android
Future<void> main() =>
    bootstrap(AppConfig.dev(DevFirebaseOptions.currentPlatform));
