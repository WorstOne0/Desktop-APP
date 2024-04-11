class SteamGame {
  late int appId;
  late String name;
  late String icon;

  late int playtimeForever;
  int? playtime2weeks;
  DateTime? lastPlayed;

  SteamGame.fromJson(dynamic json) {
    appId = json["appid"];
    name = json["name"] ?? "";
    icon =
        "http://media.steampowered.com/steamcommunity/public/images/apps/$appId/${json["img_icon_url"]}.jpg";

    playtimeForever = json["playtime_forever"] ?? 0;
    playtime2weeks = json["playtime_2weeks"];
    lastPlayed = DateTime.fromMillisecondsSinceEpoch(json["rtime_last_played"] * 1000);
  }
}
