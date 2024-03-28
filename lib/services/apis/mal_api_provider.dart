// ignore_for_file: constant_identifier_names

// Flutter Packages
import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Services
import '/services/storage/secure_storage.dart';

// https://myanimelist.net/apiconfig/references/api/v2#section/Versioning
// https://myanimelist.net/apiconfig/references/authorization
// https://myanimelist.net/apiconfig
class MALApiProvider {
  final Dio dio = Dio();

  Ref ref;
  SecureStorage secureStorage;

  MALApiProvider({required this.ref, required this.secureStorage}) {
    // Basic Config
    BaseOptions defaultOptions = BaseOptions(
      baseUrl: "https://api.myanimelist.net/v2/",
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(minutes: 2),
      sendTimeout: const Duration(minutes: 2),
      receiveDataWhenStatusError: true,
      persistentConnection: true,
      contentType: "application/json",
    );

    dio.options = defaultOptions;

    // *** Interceptors ***
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Retrieve token
          var env = DotEnv()..load();
          String accessToken = env.getOrElse("MAL_CLIENT_ID", () => "");

          // Send the token
          if (accessToken.isNotEmpty) options.headers["X-MAL-CLIENT-ID"] = accessToken;

          return handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (error, handler) => handler.next(error),
      ),
    );
  }
}

final malApiProvider = Provider<MALApiProvider>(
  (ref) => MALApiProvider(
    ref: ref,
    secureStorage: ref.watch(secureStorageProvider),
  ),
);
