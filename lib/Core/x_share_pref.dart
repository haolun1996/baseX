import 'dart:ui';

///  [X] only use in BaseX
BaseXSharePref? X;

/// [BaseXSharePref] is abstract class need to override to get the key needed
abstract class BaseXSharePref {
  static const String tokenKey = 'AccessToken';
  static const String languageCodeKey = 'LanguageCode';

  set accessToken(String? value);

  String get accessToken;

  set languageCode(Locale? value);

  Locale get languageCode;

  /// override [saveKeyWithValue] with example method below
  void saveKeyWithValue(String key, value);

  // @override
  // void saveKeyWithValue(String key, value) {
  //   Logger.info('key: $key | value: $value');
  //   if (value is String) {
  //     _prefs.setString(key, value);
  //   } else if (value is bool) {
  //     _prefs.setBool(key, value);
  //   } else if (value is int) {
  //     _prefs.setInt(key, value);
  //   } else if (value is double) {
  //     _prefs.setDouble(key, value);
  //   } else if (value is List<String>) {
  //     _prefs.setStringList(key, value);
  //   }
  // }
}
