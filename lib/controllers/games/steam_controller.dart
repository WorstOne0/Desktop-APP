// Dart
import 'dart:async';
// Flutter Packages
import 'package:dollars/controllers/core/user_controller.dart';
import 'package:dollars/models/games/steam_account_link.dart';
import 'package:dollars/services/apis/api_provider.dart';
import 'package:dollars/utils/dio_error_formatter.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
// Services
import '/services/apis/steam_api_provider.dart';

@immutable
class SteamState {
  const SteamState({required this.steamAccountLink});

  final SteamAccountLink? steamAccountLink;

  SteamState copyWith({SteamAccountLink? steamAccountLink}) {
    return SteamState(
      steamAccountLink: steamAccountLink ?? this.steamAccountLink,
    );
  }

  SteamState nullableCopyWith({SteamAccountLink? Function()? steamAccountLink}) {
    return SteamState(
      steamAccountLink: steamAccountLink != null ? steamAccountLink() : this.steamAccountLink,
    );
  }
}

class SteamController extends StateNotifier<SteamState> {
  SteamController({required this.ref, required this.steamApiProvider, required this.apiProvider})
      : super(const SteamState(steamAccountLink: null));

  Ref ref;

  SteamApiProvider steamApiProvider;
  ApiProvider apiProvider;

  String csAppId = "730";

  Future<({String redirectUrl, bool success, String message})> linkSteamAccount() async {
    try {
      var user = ref.read(userProvider).user!;

      Response res = await apiProvider.dio.get("/steam/link_steam_account");

      if (res.data["status"] != 200) return (redirectUrl: "", success: false, message: "Erro");

      String redirectUrl = "${res.data["payload"]}&userEmail=${user.email}";

      return (redirectUrl: redirectUrl, success: true, message: "");
    } on DioException catch (exception) {
      return (redirectUrl: "", success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (redirectUrl: "", success: false, message: error.toString());
    }
  }

  Future<({bool success, String message})> unlinkSteamAccount() async {
    try {
      Response res = await apiProvider.dio.delete("/steam/unlink_steam_account");

      if (res.data["status"] != 200) return (success: false, message: "Erro");

      state = state.nullableCopyWith(steamAccountLink: () => null);

      return (success: true, message: "");
    } on DioException catch (exception) {
      return (success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }

  Future<({bool success, String message})> getSteamAccount() async {
    try {
      Response res = await apiProvider.dio.get("/steam/get_steam_account");

      if (res.data["status"] != 200) return (success: false, message: "Erro");

      print(res.data["payload"]);
      state = state.copyWith(steamAccountLink: SteamAccountLink.fromJson(res.data["payload"]));

      return (success: true, message: "");
    } on DioException catch (exception) {
      return (success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }

  Future<({bool success, String message})> getSteamData({int? page}) async {
    var env = DotEnv()..load();
    String steamApiKey = env.getOrElse("STEAM_API_KEY", () => "");

    try {
      Response res = await steamApiProvider.dio.get(
          "/IPlayerService/GetOwnedGames/v0001/?key=$steamApiKey&steamid=${state.steamAccountLink?.steamId}&format=json");

      print(res);

      return (success: true, message: "");
    } on DioException catch (exception) {
      return (success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }
}

final steamProvider = StateNotifierProvider<SteamController, SteamState>((ref) {
  return SteamController(
    ref: ref,
    steamApiProvider: ref.watch(steamApiProvider),
    apiProvider: ref.watch(apiProvider),
  );
});
