
// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

import 'package:healthline/data/storage/models/user_model.dart';
import 'package:healthline/utils/log_data.dart';

class AppStorage {
  late SharedPreferences _pref;
  static const USER = "user";
  static const REFRESH_TOKEN = "refresh_token";

  static final AppStorage instance = AppStorage._internal();

  factory AppStorage() {
    return instance;
  }

  AppStorage._internal();

  init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> saveUser({required User user}) async {
    _pref.setString(USER, user.toJson());
  }

  Future<void> saveRefreshToken({required String refresh}) async {
    _pref.setString(REFRESH_TOKEN, refresh);
  }

  Future<User?> getUser() async {
    try {
      User user = User.fromJson(_pref.getString(USER)!);
      return user;
    } catch (e) {
      logPrint(e);
      return null;
    }
  }

  Future<String?> getRefreshToken() async{
    try{
      return _pref.getString(REFRESH_TOKEN);
    }catch(e){
      logPrint(e);
      return null;
    }
  }

  clearUser() async {
    _pref.remove(USER);
  }

  clearRefreshToken() async{
    _pref.remove(REFRESH_TOKEN);
  }

//   Future<void> saveUserInfo(User user) async {
//     String json = jsonEncode(user.toJson());
//     _pref.write(USER_INFO, json);
//   }

//   Future<User?> getUserInfo() async {
//     final userJson = await _pref.read(USER_INFO);
//     return userJson != null ? User.fromJson(json.decode(userJson)) : null;
//   }

//   // Future<void> saveSystemConfig(SystemConfig config) async {
//   //   String json = jsonEncode(config.toJson());
//   //   _pref.write(SYSTEM_CONFIG_DATA, json);
//   // }

//   // Future<SystemConfig?> getSystemConfig() async {
//   //   final config = await _pref.read(SYSTEM_CONFIG_DATA);
//   //   return config != null ? SystemConfig.fromJson(json.decode(config)) : null;
//   // }

//   Future<void> saveInstall(bool isInstall) async {
//     _pref.write(APP_NEW_INSTALL, isInstall);
//   }

//   Future<bool> isInstall() async {
//     final isInstall = await _pref.read(APP_NEW_INSTALL) ?? false;
//     return isInstall;
//   }

//   Future<void> setTheme(int theme) async {
//     _pref.write(APP_THEME, theme);
//   }

//   Future<int> getTheme() async {
//     final theme = await _pref.read(APP_THEME) ?? ThemeService.LIGHT_THEME;
//     return theme;
//   }

//   Future<void> setLanguage(String language) async {
//     _pref.write(APP_LANGUAGE, language);
//   }

//   Future<String> getLanguage() async {
//     final theme = await _pref.read(APP_LANGUAGE) ?? LANGUAGES[0].key;
//     return theme;
//   }

//   Future<void> logout() async {
//     if (_pref.hasData(APP_LANGUAGE)) await _pref.remove(APP_LANGUAGE);
//     if (_pref.hasData(APP_THEME)) await _pref.remove(APP_THEME);
//     if (_pref.hasData(USER_INFO)) await _pref.remove(USER_INFO);
//     if (_pref.hasData(USER_ACCESS_TOKEN)) await _pref.remove(USER_ACCESS_TOKEN);
//   }
}
