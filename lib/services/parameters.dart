// ignore_for_file: constant_identifier_names
class Parameters {
  // Https Request
  static const Duration CONNECT_TIMEOUT = Duration(seconds: 40);
  static const Duration RECEIVE_TIMEOUT = Duration(minutes: 2);
  static const Duration SEND_TIMEOUT = Duration(minutes: 2);

  // Social Media
  static const String URL_SITE_WIKI = "https://www.wikidados.com.br";
  static const String URL_FACEBOOK_WIKI = "https://www.facebook.com/Wikidados";
  static const String URL_APP_FACEBOOK_IOS_WIKI = "fb://profile/628852190534368";
  static const String URL_APP_FACEBOOK_ANDROID_WIKI = "fb://page/628852190534368";
  static const String URL_INSTAGRAM_WIKI = "https://www.instagram.com/wikidados";
  static const String URL_APP_INSTAGRAM_WIKI = "instagram://user?username=wikidados";

  // Local Storage
  static const String PREFS_USER = "user";
  static const String PREFS_PASSWORD = "password";
}
