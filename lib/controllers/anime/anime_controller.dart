// Dart
import 'dart:async';
// Flutter Packages
import 'package:dollars/services/apis/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
// Models
import '/models/anime/jikan_anime.dart';
import '/models/anime/mal_anime.dart';
// Services
import '/services/apis/mal_api_provider.dart';
import '/services/apis/jikan_api_provider.dart';
// Utils
import '/utils/dio_error_formatter.dart';

@immutable
class AnimeState {
  const AnimeState({
    required this.animeList,
    required this.animeSelected,
    required this.malAnimeList,
  });

  final List<JikanAnime> animeList;
  final JikanAnime? animeSelected;
  final List<MALAnime> malAnimeList;

  AnimeState copyWith({
    List<JikanAnime>? animeList,
    JikanAnime? animeSelected,
    List<MALAnime>? malAnimeList,
  }) {
    return AnimeState(
      animeList: animeList ?? this.animeList,
      animeSelected: animeSelected ?? this.animeSelected,
      malAnimeList: malAnimeList ?? this.malAnimeList,
    );
  }
}

class AnimeController extends StateNotifier<AnimeState> {
  AnimeController({
    required this.ref,
    required this.apiProvider,
    required this.jikanApiProvider,
    required this.malApiProvider,
  }) : super(const AnimeState(animeList: [], animeSelected: null, malAnimeList: []));

  Ref ref;

  ApiProvider apiProvider;
  JikanApiProvider jikanApiProvider;
  MALApiProvider malApiProvider;

  int maxPages = 1;
  int? animeMalId;

  void selectAnimeId(int animeId) => animeMalId = animeId;

  // *** Link / Get Account **
  Future<({String redirectUrl, bool success, String message})> linkMALAccount() async {
    try {
      Response res = await apiProvider.dio.get("/anime/link_mal_account");

      if (res.data["status"] != 200) return (redirectUrl: "", success: false, message: "Erro");

      String redirectUrl = res.data["payload"];

      return (redirectUrl: redirectUrl, success: true, message: "");
    } on DioException catch (exception) {
      return (redirectUrl: "", success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (redirectUrl: "", success: false, message: error.toString());
    }
  }

  Future<({bool success, String message})> unlinkMALAccount() async {
    try {
      // Response res = await apiProvider.dio.delete("/anime/unlink_mal_account");

      // if (res.data["status"] != 200) return (success: false, message: "Erro");

      // state = state.nullableCopyWith(steamAccountLink: () => null);

      return (success: true, message: "");
    } on DioException catch (exception) {
      return (success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }

  Future<({bool success, String message})> getMALAccount() async {
    try {
      Response res = await apiProvider.dio.get("/anime/get_mal_account");

      if (res.data["status"] != 200) return (success: false, message: "Erro");

      // state = state.copyWith(steamAccountLink: SteamAccountLink.fromJson(res.data["payload"]));

      return (success: true, message: "");
    } on DioException catch (exception) {
      return (success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }

  Future<({bool success, String message})> getAnimeList({int? page}) async {
    try {
      Response res = await jikanApiProvider.dio.get("/anime?page=${page ?? 1}");

      if (res.statusCode != 200) return (success: false, message: "Erro");

      maxPages = res.data["pagination"]["last_visible_page"];
      state = state.copyWith(
        animeList: res.data["data"]
            ?.map((anime) => JikanAnime.fromJson(anime))
            .whereType<JikanAnime>()
            .toList(),
      );

      return (success: true, message: "");
    } on DioException catch (exception) {
      return (success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }

  Future<({bool success, String message})> getUserAnimeList({int? page}) async {
    try {
      Response res = await malApiProvider.dio.get(
        "/users/Worst_One0/animelist?limit=25&fields=${malAllFields["animeFull"].join(",")}",
      );

      if (res.statusCode != 200) return (success: false, message: "Erro");

      maxPages = 1;
      state = state.copyWith(
        malAnimeList: res.data["data"]
            ?.map((anime) => MALAnime.fromJson(anime))
            .whereType<MALAnime>()
            .toList(),
      );

      return (success: true, message: "");
    } on DioException catch (exception) {
      return (success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }

  Future<({bool success, String message})> getAnimeById({int? animeId}) async {
    try {
      print(animeMalId);
      Response res = await jikanApiProvider.dio.get("/anime/${animeMalId ?? animeId}/full");

      if (res.statusCode != 200) return (success: false, message: "Erro");

      state = state.copyWith(animeSelected: JikanAnime.fromJson(res.data["data"]));

      return (success: true, message: "");
    } on DioException catch (exception) {
      return (success: false, message: dioErrorFormatter(exception));
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }
}

final animeProvider = StateNotifierProvider<AnimeController, AnimeState>((ref) {
  return AnimeController(
    ref: ref,
    apiProvider: ref.watch(apiProvider),
    jikanApiProvider: ref.watch(jikanApiProvider),
    malApiProvider: ref.watch(malApiProvider),
  );
});
