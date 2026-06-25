import 'package:flutter/material.dart';

import 'feedback_views.dart';

/// Экран-заставка на время загрузки авторизации/профиля (чтобы не моргать
/// редиректами, шаг 8).
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AppLoader(message: 'Загрузка…'));
  }
}
