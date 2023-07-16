import 'package:collection/collection.dart';
// Model
import 'user_profile.dart';

// My Models are a mix between the Service and Model from the
// Riverpod Architecture (https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)

// "Note: other common architectures based on MVC or MVVM keep this application-specific logic
// in the model class itself.
// However, this can lead to models that contain too much code and are difficult to maintain.
// By creating repositories and services as needed, we get a much better separation of concerns."

// UserProfile Model

// ["Super Admin", "Admin", "Moderator", "User", "Guest"]
enum Roles { SUPER_ADMIN, ADMIN, MODERATOR, USER, GUEST }

class User {
  late String id;
  late String email;
  late Roles userRole;
  //
  late String userName;
  late String screenName;
  //
  String? profilePicture;

  //
  UserProfile? profile;

  User.fromJson(dynamic json) {
    id = json["id"];
    email = json["email"];
    userRole = switch (json["role"]) {
      "Super Admin" => Roles.SUPER_ADMIN,
      "Admin" => Roles.ADMIN,
      "Moderator" => Roles.MODERATOR,
      "User" => Roles.USER,
      "Guest" => Roles.GUEST,
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

    map["id"] = id;
    map["email"] = email;
    map["role"] = switch (userRole) {
      Roles.SUPER_ADMIN => "Super Admin",
      Roles.ADMIN => "Admin",
      Roles.MODERATOR => "Moderator",
      Roles.USER => "User",
      Roles.GUEST => "Guest",
    };
    userRole;
    //
    map["userName"] = userName;
    map["screenName"] = screenName;
    //
    map["profilePicture"] = profilePicture;

    return map;
  }
}
