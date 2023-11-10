// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/data_constants.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/linear_progress_indicator.dart';
import 'package:healthline/utils/local_notification_service.dart';
import 'package:healthline/utils/log_data.dart';

import '../../bloc/cubits/cubits_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (!mounted) return;
    context.read<ApplicationUpdateCubit>().requestCurrentPatchNumber();
    context.read<ApplicationUpdateCubit>().checkForUpdate();
    // LocalNotificationService()
    //     .configureDidReceiveLocalNotificationSubject(context);
    // LocalNotificationService().configureSelectNotificationSubject(context);

    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? firstTime = AppStorage().getBool(key: DataConstants.FIRST_TIME);

      // // prefs.setBool('first_time', true);
      try {
        final NotificationAppLaunchDetails? notificationAppLaunchDetails =
            await LocalNotificationService().getNotificationAppLaunchDetails();
        final didNotificationLaunchApp =
            notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

        if (didNotificationLaunchApp) {
          Navigator.pushReplacementNamed(context,
              notificationAppLaunchDetails!.notificationResponse!.payload!);
          LocalNotificationService().cancelNotification(
              notificationAppLaunchDetails.notificationResponse?.id);
        } else {
          if (firstTime != null && !firstTime) {
            if (AppController.instance.authState == AuthState.Unauthorized) {
              Navigator.pushReplacementNamed(context, logInName);
            } else if (AppController.instance.authState ==
                    AuthState.AllAuthorized ||
                AppController.instance.authState ==
                    AuthState.DoctorAuthorized) {
              Navigator.pushReplacementNamed(context, mainScreenDoctorName);
            } else {
              Navigator.pushReplacementNamed(context, mainScreenPatientName);
            }
          } else {
            AppStorage().setBool(key: DataConstants.FIRST_TIME, value: false);
            Navigator.pushReplacementNamed(context, onboardingName);
          }
        }
      } catch (e) {
        logPrint(e);
      }

      // Navigator.pushReplacementNamed(context, mainScreenPatientName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.hospital,
            color: secondary,
            size: dimensWidth() * 20,
          ),
          Container(
            padding: EdgeInsets.only(top: dimensHeight() * 2),
            width: dimensWidth() * 100,
            alignment: Alignment.center,
            child: Text(
              'HealthLine',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: white),
            ),
          ),
          // ProgressIndicator()
          const LinearProgressIndicatorLoading(
            seconds: 2,
          )
        ],
      ),
    );
  }
}
