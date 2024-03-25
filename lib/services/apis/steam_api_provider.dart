// ignore_for_file: constant_identifier_names

// Flutter Packages
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Services
import '/services/storage/secure_storage.dart';

enum APIEnviroment { PROD }

String baseUrlOnEnviroment(APIEnviroment enviroment) {
  return switch (enviroment) {
    APIEnviroment.PROD => "http://api.steampowered.com",
  };
}

// Dio's Third-Party Plugins (https://github.com/cfug/dio/issues/347)
class SteamApiProvider {
  final Dio dio = Dio();

  Ref ref;
  SecureStorage secureStorage;

  SteamApiProvider({required this.ref, required this.secureStorage}) {
    // Basic Config
    BaseOptions defaultOptions = BaseOptions(
      baseUrl: baseUrlOnEnviroment(APIEnviroment.PROD),
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(minutes: 2),
      sendTimeout: const Duration(minutes: 2),
      receiveDataWhenStatusError: true,
      persistentConnection: true,
      contentType: "application/json",
    );

    dio.options = defaultOptions;
  }
}

final steamApiProvider = Provider<SteamApiProvider>(
  (ref) => SteamApiProvider(
    ref: ref,
    secureStorage: ref.watch(secureStorageProvider),
  ),
);
