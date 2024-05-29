// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:workmanager/workmanager.dart';

import 'package:healthline/app/push_notification_manager.dart';
import 'package:healthline/data/api/meilisearch_manager.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/models/responses/socket_notification.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/data/api/socket_manager.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/data_constants.dart';
import 'package:healthline/data/storage/provider/consultation_notification_provider.dart';
import 'package:healthline/firebase_options.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/time_util.dart';

@pragma('vm:entry-point')
// Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      initializeService();
    } catch (e) {
      logPrint("ERROR $e");
    }
    return Future.value(true);
  });
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  // DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  connectNotification();
}

connectNotification() {
  final _socketManager = SocketManager(port: PortSocket.notifications);
  _socketManager.stopEvent(event: "notification");
  _socketManager.addListener(
      event: 'notification',
      listener: (data) async {
        PushNotificationManager().init;
        try {
          SocketNotification socketNotification =
              SocketNotification.fromMap(data);
          List<int> time = socketNotification.content?.first.expectedTime
                  ?.split('-')
                  .map((e) => int.parse(e))
                  .toList() ??
              [
                int.parse(socketNotification.content!.first.expectedTime ?? "0")
              ];
          String timeStr =
              '${convertIntToTime(time.first)} - ${convertIntToTime(time.last + 1)}';
          if (socketNotification.type ==
              TypeNotificationSocket.consultationConfirmed) {
            await PushNotificationManager().showNotification(
              RemoteMessage(
                channelId: 'healthline',
                channelName: 'healthline',
                channelDescription: 'healthline',
                notification: ReceivedNotification(
                  title: socketNotification.from?.fullName,
                  body: "Đã xác nhận cuộc hẹn lúc $timeStr",
                ),
                id: Random.secure().nextInt(100).toString(),
              ),
            );
          }
          else if (socketNotification.type ==
              TypeNotificationSocket.consultationCanceled) {
            
          }
          else if (socketNotification.type ==
              TypeNotificationSocket.consultationDenied) {
            
          }
          else if (socketNotification.type ==
              TypeNotificationSocket.consultationRequest) {
            
          }
        } catch (e) {
          await PushNotificationManager().showNotification(
            RemoteMessage(
              channelId: 'healthline',
              channelName: 'healthline',
              channelDescription: 'healthline',
              notification: ReceivedNotification(
                title: "Healthline",
                body: "Đã xác nhận cuộc hẹn",
              ),
              id: Random.secure().nextInt(100).toString(),
            ),
          );
        }
      });
}

/// Initialize and configure necessary libraries
class AppController {
  late PackageInfo packageInfo;
  late String deviceId;
  AuthState authState = AuthState.Unauthorized;

  // Create an instance of ShorebirdCodePush. Because this example only contains
  // a single widget, we create it here, but you will likely only need to create
  // a single instance of ShorebirdCodePush in your app.
  final shorebirdCodePush = ShorebirdCodePush();

  // singleton
  static final AppController _instance = AppController._internal();

  factory AppController() {
    return _instance;
  }

  AppController._internal();

  /// Initialize AppController
  init() async {
    await Future.wait([setupSystem(), setupFirebase()]);
    await initAuth();
    await PushNotificationManager().init();
    await ConsultationNotificationProvider().init();

    MeiliSearchManager().init();
    // authState != AuthState.Unauthorized ? SocketManager.instance.init() : null;

    Workmanager().cancelAll;
    // await initWorkManager();
    // Workmanager().cancelAll();
    setupCloudinary();
  }

  initWorkManager() async {
    await Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false,
      // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
    );
    await Workmanager()
        .registerOneOffTask(DateTime.now().toString(), "simpleTask",
            initialDelay: const Duration(seconds: 15),
            constraints: Constraints(
              networkType: NetworkType.connected,
            ));
  }

  /// Set up system
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
    await AppStorage().init();
    // await DbManager().init();
  }

  /// Set up Cloudinary
  void setupCloudinary() {
    CloudinaryContext.cloudinary =
        Cloudinary.fromStringUrl(dotenv.get('CLOUDINARY_URL'));
    CloudinaryContext.cloudinary.config.urlConfig.secure = true;
  }

  Future<void> setupFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  /// Check Authorization
  Future<void> initAuth() async {
    if (AppStorage().getBool(key: DataConstants.REMEMBER) == true) {
      // Lấy các token được lưu tạm từ local storage
      LoginResponse? patient;
      LoginResponse? doctor;
      try {
        patient = LoginResponse.fromJson(
            AppStorage().getString(key: DataConstants.PATIENT)!);
      } catch (e) {
        // await initRestClient();
        logPrint(e);
      }
      try {
        doctor = LoginResponse.fromJson(
            AppStorage().getString(key: DataConstants.DOCTOR)!);
      } catch (e) {
        // await initRestClient();
        logPrint(e);
      }
      String? accessTokenPatient = patient?.jwtToken;
      String? accessTokenDoctor = doctor?.jwtToken;
      // if (accessTokenDoctor != null &&
      //     accessTokenPatient != null &&
      //     accessTokenDoctor.isNotEmpty &&
      //     accessTokenPatient.isNotEmpty) {
      //   // await initRestClient();
      //   authState = AuthState.AllAuthorized;
      // } else
      if (accessTokenPatient != null && accessTokenPatient.isNotEmpty) {
        // await initRestClient();
        authState = AuthState.PatientAuthorized;
      } else if (accessTokenDoctor != null && accessTokenDoctor.isNotEmpty) {
        // await initRestClient();
        authState = AuthState.DoctorAuthorized;
      } else {
        // await initRestClient();
        authState = AuthState.Unauthorized;
      }
    } else {
      AppStorage().clear();
      // await initRestClient();
      authState = AuthState.Unauthorized;
    }
    await initRestClient();
  }

  /// Initialize RestClient
  initRestClient() async {
    packageInfo = await PackageInfo.fromPlatform();
    await RestClient.instance.init(
        platform: Platform.isAndroid ? "android" : "ios",
        appVersion: packageInfo.version,
        deviceId: await getDeviceId(),
        language: "language");
  }

  /// Get Device Id
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

  void close() {
    // SocketManager.instance.close();
  }
}
