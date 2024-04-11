// Dart
import 'dart:async';
// Flutter Packages
import 'package:dollars/models/games/steam_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
// Controllers
import '/controllers/core/user_controller.dart';
// Models
import '/models/games/steam_account_link.dart';
// Services
import '/services/apis/api_provider.dart';
import '/services/apis/steam_api_provider.dart';
// Utils
import '/utils/dio_error_formatter.dart';

@immutable
class SteamState {
  const SteamState({required this.steamAccountLink, required this.gamesList});

  final SteamAccountLink? steamAccountLink;
  final List<SteamGame> gamesList;

  SteamState copyWith({SteamAccountLink? steamAccountLink, List<SteamGame>? gamesList}) {
    return SteamState(
      steamAccountLink: steamAccountLink ?? this.steamAccountLink,
      gamesList: gamesList ?? this.gamesList,
    );
  }

  SteamState nullableCopyWith({SteamAccountLink? Function()? steamAccountLink}) {
    return SteamState(
      steamAccountLink: steamAccountLink != null ? steamAccountLink() : this.steamAccountLink,
      gamesList: gamesList,
    );
  }
}

class SteamController extends StateNotifier<SteamState> {
  SteamController({required this.ref, required this.steamApiProvider, required this.apiProvider})
      : super(const SteamState(steamAccountLink: null, gamesList: []));

  Ref ref;

  SteamApiProvider steamApiProvider;
  ApiProvider apiProvider;

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
          "/IPlayerService/GetOwnedGames/v0001/?key=$steamApiKey&steamid=${state.steamAccountLink?.steamId}&include_appinfo=true&format=json");

      state = state.copyWith(
        gamesList: res.data["response"]["games"]
            .map((game) => SteamGame.fromJson(game))
            .whereType<SteamGame>()
            .toList(),
      );

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
