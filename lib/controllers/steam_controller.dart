// Dart
import 'dart:async';
// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
// Services
import '/services/dio_provider.dart';

// My Controller are a mix between the Controller and Repository from the
// Riverpod Architecture (https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/).
// It handles the management of the widget state. (Riverpod Controller's job)
// It handles the data parsing and serialilzation from api's. (Riverpod Repository's job).

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
  SteamController({required this.ref, required this.dioProvider})
      : super(const SteamState(placeHolder: ""));

  Ref ref;
  // Dio
  DioProvider dioProvider;

  // String steamApi = "25743B4A9C57025E5B4886FF2189431D";
  String steamApi = "9085153E01199A426B06147A8092AE21";
  // String mySteamId = "76561198294054913";
  String mySteamId = "76561198279581610";
  String csAppId = "730";

  // User Authentication
  Future<bool> getSteamData() async {
    try {
      // Response res = await dioProvider.dio.get(
      //     "http://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v2/?appid=$csAppId&key=$steamApi&steamid=$mySteamId");

      Response res = await dioProvider.dio.get(
          "http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=$steamApi&steamid=$mySteamId&format=json");

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
    dioProvider: ref.watch(dioProvider),
  );
});
