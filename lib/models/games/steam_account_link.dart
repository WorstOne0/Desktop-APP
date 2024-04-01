class SteamAccountLink {
  late String userId;
  late String steamId;

  late String username;
  late String displayName;

  SteamAccountLink.fromJson(dynamic json) {
    userId = json["userId"];
    steamId = json["steamId"];

    username = json["username"];
    displayName = json["displayName"];
  }
}
