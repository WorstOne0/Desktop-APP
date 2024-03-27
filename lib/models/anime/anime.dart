class Anime {
  late int malId;
  late String malUrl;

  late String coverImage;
  String? trailerUrl;

  late String title;
  late List<Map<String, String>> alternativeTitles;

  late String type;
  late String source;
  late int qtdEpisodes;
  late String status;
  late bool airing;
  late String aired;

  late double score;
  late int scoredBy;
  late int rank;
  late int popularity;
  late int members;

  late String synopsis;
  String? background;

  String? season;
  int? year;

  late String studioName;

  late List<String> genres;
  late List<String> themes;

  Anime.fromJson(dynamic json) {
    malId = json["mal_id"];
    malUrl = json["url"];

    coverImage = json["images"]["jpg"]["image_url"];
    trailerUrl = json["trailer"]["url"];

    title = json["title"];
    alternativeTitles = json["titles"]
            ?.map((title) => {"type": title["type"], "title": title["title"]})
            .whereType<Map<String, String>>()
            .toList() ??
        [];

    type = json["type"];
    source = json["source"];
    qtdEpisodes = json["episodes"] ?? 0;
    status = json["status"];
    airing = json["airing"];
    aired = json["aired"]["string"];

    score = json["score"];
    scoredBy = json["scored_by"];
    rank = json["rank"];
    popularity = json["popularity"];
    members = json["members"];

    synopsis = json["synopsis"];
    background = json["background"];

    season = json["season"];
    year = json["year"];

    studioName = json["studios"][0]["name"];

    genres = json["genres"]?.map((genre) => genre["name"]).whereType<String>().toList();
    themes = json["themes"]?.map((theme) => theme["name"]).whereType<String>().toList();
  }
}
