import 'bootstrap.dart';
import 'core/config/app_config.dart';
import 'firebase/firebase_options_staging.dart';

/// Entrypoint окружения **staging** (флейвор staging, реальный Firebase).
///
/// Запуск:
///   flutter run --flavor staging -t lib/main_staging.dart
Future<void> main() =>
    bootstrap(AppConfig.staging(StagingFirebaseOptions.currentPlatform));
