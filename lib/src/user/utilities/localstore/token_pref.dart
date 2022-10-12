import 'package:shared_preferences/shared_preferences.dart';

class TokenStore {
  final String keyAuthToken = 'auth_token';

//Singleton
  TokenStore._internal();
  static final TokenStore _instance = TokenStore._internal();
  static SharedPreferences? _prefs;

  factory TokenStore() {
    return _instance;
  }

  static TokenStore getInstance() {
    initPref();
    return _instance;
  }

  static void initPref() {
    if (_prefs == null) {
      SharedPreferences.getInstance().then((value) => _prefs = value);
    }
  }

  String? getAuthToken() {
    return _prefs!.getString(keyAuthToken);
  }

  void setAuthToken(String auth) {
    if (auth.isEmpty) {
      _prefs!.remove(keyAuthToken);
    } else {
      _prefs!.setString(keyAuthToken, auth);
    }
  }
}
