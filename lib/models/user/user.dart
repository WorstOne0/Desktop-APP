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
class User {
  int? id;
  UserProfile? profile;
}
