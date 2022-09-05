import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesManager {
  static const _KEY_USER_ID = 'USER_NAME';
  static const _KEY_USER_PASS = 'USER_PASS';
  static late SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserAndPassword(String user, String pass) async {
    await _preferences.setString(_KEY_USER_ID, user);
    await _preferences.setString(_KEY_USER_PASS, pass);
  }

  static Future<bool> hasUserAndPasswordsaved() async {
    Iterable<String> iterable = [_KEY_USER_ID, _KEY_USER_PASS];
    return _preferences.getKeys().containsAll(iterable);
  }

  static void clearUserDataFromSavedLogin() {
    _preferences.clear();
  }

  static void printKeys() {
    for (String k in _preferences.getKeys()) {
      print("this key $k was ${_preferences.get(k)}");
    }
  }

  static String? getUserLogin() {
    return _preferences.getString(_KEY_USER_ID);
  }

  static String? getUserPass() {
    return _preferences.getString(_KEY_USER_PASS);
  }
}
