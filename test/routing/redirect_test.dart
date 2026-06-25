import 'package:edu_app/features/auth/data/auth_providers.dart';
import 'package:edu_app/features/auth/domain/account_status.dart';
import 'package:edu_app/features/auth/domain/app_user.dart';
import 'package:edu_app/features/auth/domain/user_role.dart';
import 'package:edu_app/routing/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockUser extends Mock implements User {}

class _TestApp extends ConsumerWidget {
  const _TestApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(routerConfig: ref.watch(goRouterProvider));
  }
}

AppUser _user(UserRole role, AccountStatus status) => AppUser(
      uid: 'u1',
      email: 'u@x.dev',
      role: role,
      status: status,
      createdAt: DateTime.utc(2026),
    );

Future<void> _pump(
  WidgetTester tester, {
  User? authUser,
  AppUser? appUser,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authStateProvider.overrideWith((ref) => Stream.value(authUser)),
        appUserProvider.overrideWith((ref) => Stream.value(appUser)),
      ],
      child: const _TestApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  late _MockUser mockUser;

  setUp(() {
    mockUser = _MockUser();
    when(() => mockUser.uid).thenReturn('u1');
  });

  testWidgets('не залогинен → экран входа', (tester) async {
    await _pump(tester, authUser: null, appUser: null);
    expect(find.text('Войти'), findsOneWidget); // кнопка на LoginScreen
  });

  testWidgets('admin → dashboard администратора', (tester) async {
    await _pump(
      tester,
      authUser: mockUser,
      appUser: _user(UserRole.admin, AccountStatus.active),
    );
    expect(find.text('Сводка по системе'), findsOneWidget);
    expect(find.text('Пользователи'), findsWidgets); // раздел в навигации
  });

  testWidgets('student → dashboard студента', (tester) async {
    await _pump(
      tester,
      authUser: mockUser,
      appUser: _user(UserRole.student, AccountStatus.active),
    );
    expect(find.text('Ближайшие дедлайны'), findsOneWidget);
  });

  testWidgets('заблокированный → экран блокировки', (tester) async {
    await _pump(
      tester,
      authUser: mockUser,
      appUser: _user(UserRole.student, AccountStatus.blocked),
    );
    expect(find.text('Аккаунт заблокирован'), findsOneWidget);
  });
}
