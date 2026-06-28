// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationsRepositoryHash() =>
    r'25747c3e655677a045fbc29e241e8359ec614bc7';

/// Репозиторий in-app уведомлений.
///
/// Copied from [notificationsRepository].
@ProviderFor(notificationsRepository)
final notificationsRepositoryProvider =
    Provider<NotificationsRepository>.internal(
      notificationsRepository,
      name: r'notificationsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationsRepositoryRef = ProviderRef<NotificationsRepository>;
String _$myNotificationsHash() => r'da616747c137f03b232fd1ab7fe83db03bdff4c3';

/// Мои уведомления (свежие сверху). Без авторизации — пустой список.
///
/// Copied from [myNotifications].
@ProviderFor(myNotifications)
final myNotificationsProvider =
    AutoDisposeStreamProvider<List<AppNotification>>.internal(
      myNotifications,
      name: r'myNotificationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myNotificationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyNotificationsRef =
    AutoDisposeStreamProviderRef<List<AppNotification>>;
String _$unreadCountHash() => r'21cdff4e325c440519994a54c0d1d3e5242ab7b5';

/// Счётчик непрочитанных (для бейджа). Без авторизации — 0.
///
/// Copied from [unreadCount].
@ProviderFor(unreadCount)
final unreadCountProvider = AutoDisposeStreamProvider<int>.internal(
  unreadCount,
  name: r'unreadCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadCountRef = AutoDisposeStreamProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
