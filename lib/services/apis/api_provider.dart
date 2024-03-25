// ignore_for_file: constant_identifier_names

// Dart
import 'dart:io';
// Flutter Packages
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
// Pages
import '/pages/splash_screen.dart';
// Services
import '/services/storage/secure_storage.dart';

enum APIEnviroment { PROD, DESENV, LOCAL }

String baseUrlOnEnviroment(APIEnviroment enviroment) {
  return switch (enviroment) {
    APIEnviroment.PROD => "",
    APIEnviroment.DESENV => "",
    APIEnviroment.LOCAL => "http://localhost:4000",
  };
}

// Dio's Third-Party Plugins (https://github.com/cfug/dio/issues/347)
class ApiProvider {
  final Dio dio = Dio();

  Ref ref;
  SecureStorage secureStorage;

  ApiProvider({required this.ref, required this.secureStorage}) {
    // Basic Config
    BaseOptions defaultOptions = BaseOptions(
      baseUrl: baseUrlOnEnviroment(APIEnviroment.LOCAL),
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(minutes: 2),
      sendTimeout: const Duration(minutes: 2),
      receiveDataWhenStatusError: true,
      persistentConnection: true,
      contentType: "application/json",
      headers: {"Connection": "keep-alive"},
    );

    dio.options = defaultOptions;

    // *** Interceptors ***
    // My Auth (JWT) with Secure Storage
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Retrieve token
          String? accessToken = await secureStorage.readString("accessToken");

          // Send the token
          if (accessToken != null) {
            options.headers[HttpHeaders.authorizationHeader] = "Bearer $accessToken";
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode == 401) Get.offAll(() => const SplashScreen());

          return handler.next(response);
        },
        onError: (DioException error, handler) async => handler.next(error),
      ),
    );
  }
}

final apiProvider = Provider<ApiProvider>(
  (ref) => ApiProvider(
    ref: ref,
    secureStorage: ref.watch(secureStorageProvider),
  ),
);
