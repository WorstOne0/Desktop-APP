// Dart
import 'dart:io';
// Flutter Packages
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Services
import 'parameters.dart';
import 'secure_storage.dart';

// ignore_for_file: constant_identifier_names
enum APIEnviroment { PROD, DESENV }

class DioProvider {
  final Dio _dio = Dio();

  // Persist Data
  final SecureStorage _storage = SecureStorage();

  Dio get dio => _dio;

  DioProvider() {
    BaseOptions defaultOptions = BaseOptions(
      baseUrl: "http://localhost:4000",
      connectTimeout: Parameters.CONNECT_TIMEOUT,
      receiveTimeout: Parameters.RECEIVE_TIMEOUT,
      sendTimeout: Parameters.SEND_TIMEOUT,
      receiveDataWhenStatusError: true,
    );

    _dio.options = defaultOptions;

    // Interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.path != "/login" &&
              !options.headers.containsKey(HttpHeaders.authorizationHeader)) {
            // Retrieve token
            String? authorizationToken = await _storage.readString("accessToken");

            // Send the token
            if (authorizationToken != null) {
              options.headers[HttpHeaders.authorizationHeader] = "Bearer $authorizationToken";
            }
          }

          return handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException error, handler) async => handler.next(error),
      ),
    );
  }
}

final dioProvider = Provider<DioProvider>((ref) => DioProvider());
