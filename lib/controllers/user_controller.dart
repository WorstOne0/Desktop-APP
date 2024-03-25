// Dart
import 'dart:async';
import 'dart:convert';
// Flutter Packages
import 'package:dollars/controllers/socket_io_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
// Models
import '/models/user/user.dart';
// Services
import '/services/storage/hive_storage.dart';
import '/services/apis/api_provider.dart';
import '/services/storage/secure_storage.dart';
// Utils
import '/utils/dio_error_formatter.dart';

@immutable
class UserState {
  const UserState({required this.user});

  final User? user;

  UserState copyWith({User? user}) {
    return UserState(user: user ?? this.user);
  }
}

class UserController extends StateNotifier<UserState> {
  UserController({
    required this.ref,
    required this.apiProvider,
    required this.secureStorage,
    required this.hiveStorage,
  }) : super(const UserState(user: null));

  Ref ref;
  // Dio
  ApiProvider apiProvider;
  // Persist Data
  SecureStorage secureStorage;
  HiveStorage hiveStorage;

  // User Authentication
  Future<bool> isLogged() async {
    return false;
  }

  Future<({bool success, String message})> login(Map<String, String> data) async {
    try {
      Response res = await apiProvider.dio.post("/login", data: data);

      // Save the token, user and password
      secureStorage.saveString("accessToken", res.data["payload"]["accessToken"]);
      secureStorage.saveString("email", data["email"] ?? "");
      secureStorage.saveString("password", data["password"] ?? "");

      // Create User
      User user = User.fromJson(res.data["payload"]["user"]);
      // User myUser = User.fromJson({
      //   "id": "0",
      //   "email": "luccagabriel12@hotmail.com",
      //   "userRole": "Super Admin",
      //   "userName": "worstone0",
      //   "screenName": "Worst One",
      //   "profilePicture": "https://avatars.githubusercontent.com/u/31835808?v=4",
      // });
      state = state.copyWith(user: user);

      // Save User to Local Storage
      secureStorage.saveString("user", jsonEncode(user.toJson()));

      // Set User on Socket IO
      ref.read(socketIOProvider.notifier).emitToBack("set_user", user.id);

      return (success: true, message: "");
    } on DioException catch (exception) {
      return (success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }

  void logout() {
    secureStorage.deleteKey("accessToken");
    secureStorage.deleteKey("user");
    secureStorage.deleteKey("username");
    secureStorage.deleteKey("password");
  }
}

final userProvider = StateNotifierProvider<UserController, UserState>((ref) {
  return UserController(
    ref: ref,
    apiProvider: ref.watch(apiProvider),
    secureStorage: ref.watch(secureStorageProvider),
    hiveStorage: ref.watch(hiveStorageProvider),
  );
});
