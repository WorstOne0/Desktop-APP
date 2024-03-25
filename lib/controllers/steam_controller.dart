// Dart
import 'dart:async';
// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
// Services
import '/services/apis/steam_api_provider.dart';

@immutable
class SteamState {
  const SteamState({
    required this.placeHolder,
  });

  final String? placeHolder;

  SteamState copyWith({String? placeHolder}) {
    return SteamState(
      placeHolder: placeHolder ?? this.placeHolder,
    );
  }
}

class SteamController extends StateNotifier<SteamState> {
  SteamController({required this.ref, required this.steamApiProvider})
      : super(const SteamState(placeHolder: ""));

  Ref ref;

  SteamApiProvider steamApiProvider;

  String steamApi = "9085153E01199A426B06147A8092AE21";
  // String mySteamId = "76561198294054913";
  String mySteamId = "76561198279581610";
  String csAppId = "730";

  // User Authentication
  Future<bool> getSteamData() async {
    try {
      // Response res = await dioProvider.dio.get(
      //     "http://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v2/?appid=$csAppId&key=$steamApi&steamid=$mySteamId");

      Response res = await steamApiProvider.dio
          .get("/IPlayerService/GetOwnedGames/v0001/?key=$steamApi&steamid=$mySteamId&format=json");

      print(res);

      return true;
    } catch (erro) {
      return false;
    }
  }
}

final steamProvider = StateNotifierProvider<SteamController, SteamState>((ref) {
  return SteamController(
    ref: ref,
    steamApiProvider: ref.watch(steamApiProvider),
  );
});
