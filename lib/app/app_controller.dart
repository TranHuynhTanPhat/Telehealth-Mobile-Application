// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/db/db_manager.dart';
import 'package:healthline/firebase_options.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController {
  late PackageInfo packageInfo;
  late String deviceId;
  AuthState authState = AuthState.unauthorized;

  // singleton
  static final AppController instance = AppController._internal();

  factory AppController() {
    return instance;
  }

  AppController._internal();

  init() async {
    await Future.wait([initFirebase(), setupLocator()]);
    await initAuth();
  }

  Future<void> initAuth() async {
    final _prefs = await SharedPreferences.getInstance();

    // Lấy các token được lưu tạm từ local storage
    String? accessToken = _prefs.getString('accessToken');
    String? role = _prefs.getString('role');
    if (accessToken != null) {
      await initApi(token: accessToken);
      if (role == 'user') {
        authState = AuthState.authorized_user;
      } else if (role == 'admin') {
        authState = AuthState.authorized_admin;
      }
    } else {
      await initApi();
      authState = AuthState.unauthorized;
    }
  }

  Future<void> setupLocator() async {
    AppStorage.instance.init();
    DbManager().init();
  }

  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  initApi({String? token}) async {
    packageInfo = await PackageInfo.fromPlatform();
    RestClient.instance.init(
        accessToken: token ?? "",
        platform: Platform.isAndroid ? "android" : "ios",
        appVersion: packageInfo.version,
        deviceId: await getDeviceId(),
        language: "language");
  }

  Future<String> getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceId = build.id;
        return build.id; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceId = data.identifierForVendor ?? "";
        return data.identifierForVendor ?? ""; //UUID for iOS
      }
    } on PlatformException {
      logPrint('Failed to get platform version');
    }
    return "";
  }
}

enum AuthState { unauthorized, authorized_user, authorized_admin, new_install }
