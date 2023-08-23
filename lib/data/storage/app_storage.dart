// // ignore_for_file: constant_identifier_names

// import 'dart:convert';

// import 'package:flutter_chat_sdk/data/api/models/responses/user.dart';
// import 'package:flutter_chat_sdk/res/language/localization_service.dart';
// import 'package:flutter_chat_sdk/res/theme/theme_service.dart';
// import 'package:get_storage/get_storage.dart';

// class AppStorage {
//   late GetStorage box;
//   static const STORAGE_NAME = "cnq_coffee_storage";
//   static const USER_ACCESS_TOKEN = "user_access_token";
//   static const USER_INFO = "cnq_user_info";
//   static const SYSTEM_CONFIG_DATA = "cnq_system_config";
//   static const APP_NEW_INSTALL = "app_new_install";
//   static const APP_THEME = "app_theme";
//   static const APP_LANGUAGE = "app_language";
//   static const DEVICE_TOKEN = "device_token";

//   init() async {
//     await GetStorage.init(STORAGE_NAME);
//     box = GetStorage(STORAGE_NAME);
//   }

//   Future<void> saveDeviceToken(String deviceToken) async {
//     box.write(DEVICE_TOKEN, deviceToken);
//   }

//   Future<String?> getDeviceToken() async {
//     final token = await box.read(DEVICE_TOKEN);
//     return token;
//   }

//   Future<void> saveUserAccessToken(String accessToken) async {
//     box.write(USER_ACCESS_TOKEN, accessToken);
//   }

//   Future<String?> getUserAccessToken() async {
//     final token = await box.read(USER_ACCESS_TOKEN);
//     return token;
//   }

//   Future<void> saveUserInfo(User user) async {
//     String json = jsonEncode(user.toJson());
//     box.write(USER_INFO, json);
//   }

//   Future<User?> getUserInfo() async {
//     final userJson = await box.read(USER_INFO);
//     return userJson != null ? User.fromJson(json.decode(userJson)) : null;
//   }

//   // Future<void> saveSystemConfig(SystemConfig config) async {
//   //   String json = jsonEncode(config.toJson());
//   //   box.write(SYSTEM_CONFIG_DATA, json);
//   // }

//   // Future<SystemConfig?> getSystemConfig() async {
//   //   final config = await box.read(SYSTEM_CONFIG_DATA);
//   //   return config != null ? SystemConfig.fromJson(json.decode(config)) : null;
//   // }

//   Future<void> saveInstall(bool isInstall) async {
//     box.write(APP_NEW_INSTALL, isInstall);
//   }

//   Future<bool> isInstall() async {
//     final isInstall = await box.read(APP_NEW_INSTALL) ?? false;
//     return isInstall;
//   }

//   Future<void> setTheme(int theme) async {
//     box.write(APP_THEME, theme);
//   }

//   Future<int> getTheme() async {
//     final theme = await box.read(APP_THEME) ?? ThemeService.LIGHT_THEME;
//     return theme;
//   }

//   Future<void> setLanguage(String language) async {
//     box.write(APP_LANGUAGE, language);
//   }

//   Future<String> getLanguage() async {
//     final theme = await box.read(APP_LANGUAGE) ?? LANGUAGES[0].key;
//     return theme;
//   }

//   Future<void> logout() async {
//     if (box.hasData(APP_LANGUAGE)) await box.remove(APP_LANGUAGE);
//     if (box.hasData(APP_THEME)) await box.remove(APP_THEME);
//     if (box.hasData(USER_INFO)) await box.remove(USER_INFO);
//     if (box.hasData(USER_ACCESS_TOKEN)) await box.remove(USER_ACCESS_TOKEN);
//   }
// }
