import 'dart:async';
import 'dart:io';
// ignore: unnecessary_import
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });
  final int? id;
  final String? title;
  final String? body;
  final String? payload;

  @override
  String toString() {
    return 'ReceivedNotification(id: $id, title: $title, body: $body, payload: $payload)';
  }
}

class RemoteMessage {
  String id;
  String channelId;
  String channelName;
  String channelDescription;
  String? groupKey;
  String? icon;
  Color? color;
  Importance importance;
  Priority priority;
  String? ticker;
  ReceivedNotification notification;
  List<AndroidNotificationAction>? actions;
  bool playSound;
  AndroidNotificationChannelAction channelAction;
  NotificationVisibility? visibility;
  AndroidBitmap<Object>? largeIcon;
  Int64List? vibrationPattern;
  bool enableLights;
  Color? ledColor;
  int? ledOnMs;
  int? ledOffMs;
  int? timeoutAfter;
  Int32List? additionalFlags;
  StyleInformation? styleInformation;
  bool ongoing;
  bool autoCancel;
  bool onlyAlertOnce;
  bool channelShowBadge;
  bool showProgress;
  int maxProgress;
  int progress;
  bool indeterminate;
  bool showWhen;
  int? when;
  String? subText;
  bool usesChronometer;
  bool chronometerCountDown;
  RemoteMessage({
    required this.id,
    this.channelId = "com.example.healthline",
    this.channelName = "healthline",
    this.channelDescription = "",
    this.groupKey,
    this.icon,
    this.color,
    this.importance = Importance.max,
    this.priority = Priority.high,
    this.ticker,
    required this.notification,
    this.actions,
    this.playSound = true,
    this.channelAction = AndroidNotificationChannelAction.createIfNotExists,
    this.visibility,
    this.largeIcon,
    this.vibrationPattern,
    this.enableLights = false,
    this.ledColor,
    this.ledOnMs,
    this.ledOffMs,
    this.timeoutAfter,
    this.additionalFlags,
    this.styleInformation,
    this.ongoing = false,
    this.autoCancel = true,
    this.onlyAlertOnce = false,
    this.channelShowBadge = true,
    this.showProgress = false,
    this.maxProgress = 0,
    this.progress = 0,
    this.indeterminate = false,
    this.showWhen = true,
    this.when,
    this.subText,
    this.usesChronometer = false,
    this.chronometerCountDown = false,
  });

  @override
  String toString() {
    return 'RemoteMessage(channelId: $channelId, channelName: $channelName, channelDescription: $channelDescription, groupKey: $groupKey, icon: $icon, color: $color, importance: $importance, priority: $priority, ticker: $ticker, notification: ${notification.toString()}, actions: $actions, playSound: $playSound, channelAction: $channelAction, visibility: $visibility, largeIcon: $largeIcon, vibrationPattern: $vibrationPattern, enableLights: $enableLights, ledColor: $ledColor, ledOnMs: $ledOnMs, ledOffMs: $ledOffMs, timeoutAfter: $timeoutAfter, additionalFlags: $additionalFlags, styleInformation: $styleInformation, ongoing: $ongoing, autoCancel: $autoCancel, onlyAlertOnce: $onlyAlertOnce, channelShowBadge: $channelShowBadge, showProgress: $showProgress, maxProgress: $maxProgress, progress: $progress, indeterminate: $indeterminate, showWhen: $showWhen, when: $when, subText: $subText, usesChronometer: $usesChronometer, chronometerCountDown: $chronometerCountDown)';
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {}

class PushNotificationManager {
// singleton
  static final PushNotificationManager _instance =
      PushNotificationManager._internal();

  factory PushNotificationManager() {
    return _instance;
  }

  PushNotificationManager._internal();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final StreamController<ReceivedNotification>
      didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  // final MethodChannel platform = const MethodChannel('dexterx.dev/healthline');

  /// A notification action which triggers a url launch event
  final String urlLaunchActionId = 'id_1';

  /// A notification action which triggers a App navigation event
  final String navigationActionId = 'id_3';

  /// Defines a iOS/MacOS notification category for text input actions.
  final String darwinNotificationCategoryText = 'textCategory';

  /// Defines a iOS/MacOS notification category for plain actions.
  final String darwinNotificationCategoryPlain = 'plainCategory';

  init() async {
    await _configureLocalTimeZone();

    // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    //     await _notificationsPlugin.getNotificationAppLaunchDetails();
    // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    //   selectedNotificationPayload =
    //       notificationAppLaunchDetails!.notificationResponse?.payload;
    //   initialRoute = SecondPage.routeName;
    // }

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'healthline', // id
      'Healthline', // title
      importance: Importance.low, // importance must be at low or higher level
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final List<DarwinNotificationCategory> darwinNotificationCategories =
        <DarwinNotificationCategory>[
      DarwinNotificationCategory(
        darwinNotificationCategoryText,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.text(
            'text_1',
            'Action 1',
            buttonTitle: 'Send',
            placeholder: 'Placeholder',
          ),
        ],
      ),
      DarwinNotificationCategory(
        darwinNotificationCategoryPlain,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain('id_1', 'Action 1'),
          DarwinNotificationAction.plain(
            'id_2',
            'Action 2 (destructive)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
          DarwinNotificationAction.plain(
            navigationActionId,
            'Action 3 (foreground)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
          DarwinNotificationAction.plain(
            'id_4',
            'Action 4 (auth required)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.authenticationRequired,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      )
    ];

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      notificationCategories: darwinNotificationCategories,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    if (Platform.isIOS || Platform.isAndroid) {
      await _notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
          switch (notificationResponse.notificationResponseType) {
            case NotificationResponseType.selectedNotification:
              selectNotificationStream.add(notificationResponse.payload);
              break;
            case NotificationResponseType.selectedNotificationAction:
              if (notificationResponse.actionId == navigationActionId) {
                selectNotificationStream.add(notificationResponse.payload);
              }
              break;
          }
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );
    }
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await isAndroidPermissionGranted();
    await requestPermissions();
    // await cancelAllNotifications();
  }

  Future<NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() async {
    return await _notificationsPlugin.getNotificationAppLaunchDetails();
  }

  void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) {
    // logPrint(notificationResponse.actionId);
    // logPrint(notificationResponse.id);
    // logPrint(notificationResponse.input);
    // logPrint(notificationResponse.notificationResponseType);
    // logPrint(notificationResponse.runtimeType);
    switch (notificationResponse.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        selectNotificationStream.add(notificationResponse.payload);
        break;
      case NotificationResponseType.selectedNotificationAction:
        if (notificationResponse.actionId == navigationActionId) {
          selectNotificationStream.add(notificationResponse.payload);
        }
        break;
    }
  }

  void dispose() {
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
      // int? badgeNumber = listNotification.length;
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          message.channelId,
          message.channelName,
          channelDescription: message.channelDescription,
          groupKey: message.groupKey,
          icon: message.icon,
          largeIcon: message.largeIcon,
          color: primary,
          importance: message.importance,
          priority: message.priority,
          ticker: message.ticker,
          actions: message.actions,
          playSound: message.playSound,
          channelAction: message.channelAction,
          visibility: NotificationVisibility.public,
          timeoutAfter: message.timeoutAfter,
          additionalFlags: message.additionalFlags,
          styleInformation: message.styleInformation,
          ongoing: message.ongoing,
          autoCancel: message.autoCancel,
          onlyAlertOnce: message.onlyAlertOnce,
          channelShowBadge: message.channelShowBadge,
          showProgress: message.showProgress,
          maxProgress: message.maxProgress,
          progress: message.progress,
          indeterminate: message.indeterminate,
          showWhen: message.showWhen,
          when: message.when,
          subText: message.subText,
          usesChronometer: message.usesChronometer,
          chronometerCountDown: message.chronometerCountDown,
        ),
        iOS: const DarwinNotificationDetails(badgeNumber: 0),
      );
      await _notificationsPlugin.show(id, message.notification.title,
          message.notification.body, notificationDetails,
          payload: message.notification.payload);
      // listId.add(id);
    } catch (e) {
      logPrint(e.toString());
      debugPrint(e.toString());
    }
  }

  Future<void> showScheduleNotification(
      RemoteMessage message, DateTime time) async {
    try {
      tz.TZDateTime scheduledDate = tz.TZDateTime(
          tz.local, time.year, time.month, time.day, time.hour, time.minute);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          message.channelId,
          message.channelName,
          channelDescription: message.channelDescription,
          groupKey: message.groupKey,
          icon: message.icon,
          largeIcon: message.largeIcon,
          color: primary,
          importance: message.importance,
          priority: message.priority,
          ticker: message.ticker,
          actions: message.actions,
          playSound: message.playSound,
          channelAction: message.channelAction,
          visibility: NotificationVisibility.public,
          timeoutAfter: message.timeoutAfter,
          additionalFlags: message.additionalFlags,
          styleInformation: message.styleInformation,
          ongoing: message.ongoing,
          autoCancel: message.autoCancel,
          onlyAlertOnce: message.onlyAlertOnce,
          channelShowBadge: message.channelShowBadge,
          showProgress: message.showProgress,
          maxProgress: message.maxProgress,
          progress: message.progress,
          indeterminate: message.indeterminate,
          showWhen: message.showWhen,
          when: message.when,
          subText: message.subText,
          usesChronometer: message.usesChronometer,
          chronometerCountDown: message.chronometerCountDown,
        ),
        iOS: const DarwinNotificationDetails(presentBadge: true),
      );
      await _notificationsPlugin.zonedSchedule(id, message.notification.title,
          message.notification.body, scheduledDate, notificationDetails,
          payload: message.notification.payload,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);
      // listId.add(id);
    } catch (e) {
      logPrint(e.toString());
      debugPrint(e.toString());
    }
  }

  // Future<void> areNotifcationsEnabledOnAndroid(BuildContext context) async {
  //   final bool? areEnabled = await _notificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.areNotificationsEnabled();
  //   // ignore: use_build_context_synchronously
  //   await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: Text(areEnabled == null
  //           ? 'ERROR: received null'
  //           : (areEnabled
  //               ? 'Notifications are enabled'
  //               : 'Notifications are NOT enabled')),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future<void> showFullScreenNotification(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text('Turn off your screen'),
  //       content: const Text(
  //           'to see the full-screen intent in 5 seconds, press OK and TURN '
  //           'OFF your screen'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             tz.TZDateTime.local(
  //                 DateTime.now().year,
  //                 DateTime.now().month,
  //                 DateTime.now().day,
  //                 DateTime.now().hour,
  //                 DateTime.now().minute);
  //             await _notificationsPlugin.zonedSchedule(
  //                 0,
  //                 'scheduled title',
  //                 'scheduled body',
  //                 tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //                 const NotificationDetails(
  //                     android: AndroidNotificationDetails(
  //                         'full screen channel id', 'full screen channel name',
  //                         channelDescription: 'full screen channel description',
  //                         priority: Priority.high,
  //                         importance: Importance.high,
  //                         fullScreenIntent: true)),
  //                 androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //                 uiLocalNotificationDateInterpretation:
  //                     UILocalNotificationDateInterpretation.absoluteTime);

  //             // ignore: use_build_context_synchronously
  //             Navigator.pop(context);
  //           },
  //           child: const Text('OK'),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Future<void> cancelNotification(id) async {
    await _notificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  Future<bool> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      return granted;
    }
    return false;
  }

  Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final bool? grantedNotificationPermission = await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      return grantedNotificationPermission ?? false;
    }
    return false;
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    didReceiveLocalNotificationStream.add(
      ReceivedNotification(
        title: title,
        body: body,
        payload: payload,
      ),
    );
  }
}
