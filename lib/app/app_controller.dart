// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers
import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/db/db_manager.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';

class AppController {
  late PackageInfo packageInfo;
  late String deviceId;
  AuthState authState = AuthState.Unauthorized;

  // singleton
  static final AppController instance = AppController._internal();

  factory AppController() {
    return instance;
  }

  AppController._internal();

  init() async {
    await Future.wait([setupSystem(), setupLocator()]);
    await initAuth();
    setupCloudinary();
  }

  Future<void> setupSystem() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: transparent));

    final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );
    HydratedBloc.storage = storage;
  }

  void setupCloudinary() {
    CloudinaryContext.cloudinary =
        Cloudinary.fromStringUrl(dotenv.get('CLOUDINARY_URL'));
    CloudinaryContext.cloudinary.config.urlConfig.secure = true;
  }

  Future<void> initAuth() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lấy các token được lưu tạm từ local storage
    try {
      // LoginResponse user = LoginResponse.fromJson(prefs.getString("user")!);
      LoginResponse? user = await AppStorage().getUser();
      String? accessToken = user?.jwtToken;
      if (accessToken != null) {
        await initApi(token: accessToken);
        authState = AuthState.Authorized;
      } else {
        await initApi();
        authState = AuthState.Unauthorized;
      }
    } catch (e) {
      await initApi();
      authState = AuthState.Unauthorized;
    }
  }

  Future<void> setupLocator() async {
    AppStorage().init();
    DbManager().init();
  }

  initApi({String? token}) async {
    packageInfo = await PackageInfo.fromPlatform();
    await RestClient.instance.init(
        
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
