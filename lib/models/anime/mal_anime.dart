// https://github.com/Chris-Kode/myanimelist-api-v2
class MALAnime {
  late int malId;

  late String coverImage;
  late String title;

  late String type;
  late String source;
  late int qtdEpisodes;
  late String status;
  late bool airing;
  String? aired;

  late double score;
  late int scoredBy;
  late int rank;
  late int popularity;
  late int members;

  late String synopsis;

  String? season;
  int? year;

  late String studioName;

  late List<String> genres;

  MALAnime.fromJson(dynamic json) {
    json = json["node"];
    malId = json["id"];

    coverImage = json["main_picture"]["large"];
    title = json["title"];

    type = json["media_type"];
    source = json["source"];
    qtdEpisodes = json["num_episodes"] ?? 0;
    status = json["status"];
    airing = json["status"] == "airing";
    aired = json["start_date"];

    score = json["mean"];
    scoredBy = json["num_scoring_users"];
    rank = json["rank"];
    popularity = json["popularity"];
    members = json["num_list_users"];

    synopsis = json["synopsis"];

    season = json["start_season"]["season"];
    year = json["start_season"]["year"];

    studioName = json["studios"][0]["name"];

    genres = json["genres"]?.map((genre) => genre["name"]).whereType<String>().toList();
  }
}

// ALL FIELDS
Map<String, dynamic> malAllFields = {
  "animeFull": [
    "id",
    "title",
    "main_picture",
    "alternative_titles",
    "start_date",
    "end_date",
    "synopsis",
    "mean",
    "rank",
    "popularity",
    "num_list_users",
    "num_scoring_users",
    "nsfw",
    "genres",
    "created_at",
    "updated_at",
    "media_type",
    "status",
    "my_list_status",
    "num_episodes",
    "start_season",
    "broadcast",
    "source",
    "average_episode_duration",
    "rating",
    "studios",
    "pictures",
    "background",
    "related_anime",
    "related_manga",
    "recommendations",
    "statistics"
  ],
  "animeInList": [
    "id",
    "title",
    "main_picture",
    "alternative_titles",
    "start_date",
    "end_date",
    "synopsis",
    "mean",
    "rank",
    "popularity",
    "num_list_users",
    "num_scoring_users",
    "nsfw",
    "genres",
    "created_at",
    "updated_at",
    "media_type",
    "status",
    "my_list_status",
    "num_episodes",
    "start_season",
    "broadcast",
    "source",
    "average_episode_duration",
    "rating",
    "studios"
  ]
};
