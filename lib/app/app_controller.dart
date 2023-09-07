import 'dart:io';

import 'package:flutter/services.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController {
  late PackageInfo packageInfo;
  late String deviceId;

  
  init() async {
    await initAuth();
  }

  Future<void> initAuth() async {
    // final storage = Get.find<AppStorage>();
    // user = await storage.getUserInfo();
    // final token = await storage.getUserAccessToken();
    // if (user != null && token != null) {
    //   await initApi(token: token);

    //   if (user!.isUpdateProfile == 1) {
    //     authState.value = AuthState.authorized;
    //   } else {
    //     authState.value = AuthState.uncompleted;
    //   }
    // } else {
    await initApi();
    // authState.value = AuthState.unauthorized;
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
