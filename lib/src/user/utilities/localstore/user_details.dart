import 'package:shared_preferences/shared_preferences.dart';

class UserTokenStore {
  final String keyUserEmail = 'user_email';
  final String keyUserName = 'user_name';
  final String keyUserId = 'user_id';
  final String keyProfileId = 'profile_id';
  final String keyDeviceTokenId = 'device_token';
  final String keyCurrentUserType = 'current_user_type';

  UserTokenStore._internal();
  static final UserTokenStore _instance = UserTokenStore._internal();
  static SharedPreferences? _prefs;

  /// store user data in shared prefences. That gives you flexibilty to access the stored data scross the app.
  factory UserTokenStore() {
    return _instance;
  }

  static UserTokenStore getInstance() {
    initPref();
    return _instance;
  }

  static void initPref() {
    if (_prefs == null) {
      SharedPreferences.getInstance().then((value) => _prefs = value);
    }
  }

  /// acess stored email address of loggedIn User
  String? getCurrentUserEmail() {
    return _prefs!.getString(keyUserEmail);
  }

  /// store stored email address of loggedIn User
  void setCurrentUserEmail(String email) {
    if (email.isEmpty) {
      _prefs!.remove(keyUserEmail);
    } else {
      _prefs!.setString(keyUserEmail, email);
    }
  }

  String? getUserName() {
    return _prefs!.getString(keyUserName);
  }

  void setCurrentUserName(String userName) {
    if (userName.isEmpty) {
      _prefs!.remove(keyUserName);
    } else {
      _prefs!.setString(keyUserName, userName);
    }
  }

  String? getUserId() {
    return _prefs!.getString(keyUserId);
  }

  void setCurrentUserId(String userId) {
    if (userId.isEmpty) {
      _prefs!.remove(keyUserId);
    } else {
      _prefs!.setString(keyUserId, userId);
    }
  }

  /// storing profileid
  String? getProfileId() {
    return _prefs!.getString(keyProfileId);
  }

  void setCurrentProfileId(String profileId) {
    if (profileId.isEmpty) {
      _prefs!.remove(keyProfileId);
    } else {
      _prefs!.setString(keyProfileId, profileId);
    }
  }

  String? getCurrentUserType() {
    return _prefs!.getString(keyCurrentUserType);
  }

  void setCurrentUserType(String profileId) {
    if (profileId.isEmpty) {
      _prefs!.remove(keyCurrentUserType);
    } else {
      _prefs!.setString(keyCurrentUserType, profileId);
    }
  }

  String? getDeviceToken() {
    return _prefs!.getString(keyDeviceTokenId);
  }

  void setDeviceToken(String deviceToken) {
    if (deviceToken.isEmpty) {
      _prefs!.remove(keyDeviceTokenId);
    } else {
      _prefs!.setString(keyDeviceTokenId, deviceToken);
    }
  }
}
