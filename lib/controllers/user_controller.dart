// Dart
import 'dart:async';
import 'dart:convert';
// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
// Models
import '/models/user/user.dart';
// Services
import '/services/dio_provider.dart';
import '/services/secure_storage.dart';
import '/services/hive_storage.dart';

// My Controller are a mix between the Controller and Repository from the
// Riverpod Architecture (https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/).
// It handles the management of the widget state. (Riverpod Controller's job)
// It handles the data parsing and serialilzation from api's. (Riverpod Repository's job).

@immutable
class UserState {
  const UserState({
    required this.user,
  });

  final User? user;

  UserState copyWith({User? user}) {
    return UserState(
      user: user ?? this.user,
    );
  }
}

class UserController extends StateNotifier<UserState> {
  UserController({required this.ref, required this.dioProvider, required this.hiveStorage})
      : super(const UserState(user: null));

  Ref ref;
  // Dio
  DioProvider dioProvider;
  // Persist Data
  SecureStorage storage = SecureStorage();
  HiveStorage hiveStorage;

  // User Authentication
  Future<bool> isLogged() async {
    return false;
  }

  Future<bool> login(Map<String, String> data, bool isEmail) async {
    return false;
  }

  void logout() {}
}

final userProvider = StateNotifierProvider<UserController, UserState>((ref) {
  return UserController(
    ref: ref,
    dioProvider: ref.watch(dioProvider),
    hiveStorage: ref.watch(hiveStorageProvider),
  );
});
