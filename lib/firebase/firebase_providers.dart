import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_providers.g.dart';

/// Инстансы Firebase отдаются через провайдеры, а не через глобальные
/// синглтоны (`FirebaseXxx.instance`) напрямую в коде фич. Это:
///   * упрощает тесты (override провайдера на фейк/эмулятор);
///   * даёт единую точку подключения эмуляторов (шаг 3);
///   * соответствует правилу «доступ к данным только через провайдеры».

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
FirebaseFirestore firestore(Ref ref) => FirebaseFirestore.instance;

@Riverpod(keepAlive: true)
FirebaseStorage firebaseStorage(Ref ref) => FirebaseStorage.instance;

@Riverpod(keepAlive: true)
FirebaseFunctions firebaseFunctions(Ref ref) => FirebaseFunctions.instance;
