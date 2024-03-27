// Dart
import 'dart:async';
// Flutter Packages
import 'package:dollars/models/anime/anime.dart';
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
  });

  final List<Anime> animeList;
  final Anime? animeSelected;

  AnimeState copyWith({List<Anime>? animeList, Anime? animeSelected}) {
    return AnimeState(
      animeList: animeList ?? this.animeList,
      animeSelected: animeSelected ?? this.animeSelected,
    );
  }
}

class AnimeController extends StateNotifier<AnimeState> {
  AnimeController({required this.ref, required this.jikanApiProvider})
      : super(const AnimeState(animeList: [], animeSelected: null));

  Ref ref;

  JikanApiProvider jikanApiProvider;

  int maxPages = 1;

  Future<({bool success, String message})> getAnimeList({int? page}) async {
    try {
      Response res = await jikanApiProvider.dio.get("/anime?page=${page ?? 1}");

      if (res.statusCode != 200) return (success: false, message: "Erro");

      List<Anime> animeList =
          res.data["data"]?.map((anime) => Anime.fromJson(anime)).whereType<Anime>().toList();
      maxPages = res.data["pagination"]["last_visible_page"];

      state = state.copyWith(animeList: animeList);

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
  );
});
