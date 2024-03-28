// Dart
import 'dart:async';
// Flutter Packages
import 'package:dollars/models/anime/jikan_anime.dart';
import 'package:dollars/models/anime/mal_anime.dart';
import 'package:dollars/services/apis/mal_api_provider.dart';
import 'package:dollars/utils/dio_error_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
// Services
import 'package:dollars/services/apis/jikan_api_provider.dart';

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
  AnimeController({required this.ref, required this.jikanApiProvider, required this.malApiProvider})
      : super(const AnimeState(animeList: [], animeSelected: null, malAnimeList: []));

  Ref ref;

  JikanApiProvider jikanApiProvider;
  MALApiProvider malApiProvider;

  int maxPages = 1;

  Future<({bool success, String message})> getAnimeList({int? page}) async {
    try {
      Response res = await jikanApiProvider.dio.get("/anime?page=${page ?? 1}");
      Response res2 = await malApiProvider.dio.get(
        "/users/Worst_One0/animelist?limit=25&fields=${malAllFields["animeFull"].join(",")}",
      );

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
}

final animeProvider = StateNotifierProvider<AnimeController, AnimeState>((ref) {
  return AnimeController(
    ref: ref,
    jikanApiProvider: ref.watch(jikanApiProvider),
    malApiProvider: ref.watch(malApiProvider),
  );
});
