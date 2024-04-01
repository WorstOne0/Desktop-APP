enum Roles { SUPER_ADMIN, ADMIN, USER, GUEST }

class User {
  late String id;
  late String email;
  late Roles userRole;
  //
  late String userName;
  late String screenName;
  //
  String? profilePicture;

  User.fromJson(dynamic json) {
    id = json["_id"];
    email = json["email"];
    userRole = switch (json["role"]) {
      "super_admin" => Roles.SUPER_ADMIN,
      "admin" => Roles.ADMIN,
      "user" => Roles.USER,
      "guest" => Roles.GUEST,
      _ => Roles.GUEST,
    };
    //
    userName = json["userName"];
    screenName = json["screenName"];
    //
    profilePicture = json["profilePicture"];
  }

  // Convert to json
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map["_id"] = id;
    map["email"] = email;
    map["role"] = switch (userRole) {
      Roles.SUPER_ADMIN => "Super Admin",
      Roles.ADMIN => "Admin",
      Roles.USER => "User",
      Roles.GUEST => "Guest",
    };
    //
    map["userName"] = userName;
    map["screenName"] = screenName;
    //
    map["profilePicture"] = profilePicture;

    return map;
  }
}
