// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_IS_ADMIN = "PREFS_KEY_IS_ADMIN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setIsAdminLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_ADMIN, true);
  }

  Future<bool> isAdminLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_ADMIN) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_ADMIN);
  }
}
