import 'bootstrap.dart';
import 'core/config/app_config.dart';

/// Entrypoint окружения **prod** (флейвор prod, реальный Firebase).
///
/// Запуск:
///   flutter run --flavor prod -t lib/main_prod.dart --release
Future<void> main() => bootstrap(AppConfig.prod());
