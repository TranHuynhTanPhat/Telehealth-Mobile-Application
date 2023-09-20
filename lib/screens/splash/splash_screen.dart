// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/res/colors.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/utils/linear_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? firstTime = prefs.getBool('first_time');

      // // prefs.setBool('first_time', true);

      if (firstTime != null && !firstTime) {
        if (AppController().authState == AuthState.authorized_user ||
            AppController().authState == AuthState.authorized_admin) {
          Navigator.pushReplacementNamed(context, mainScreenName);
        } else if (AppController().authState == AuthState.unauthorized) {
          Navigator.pushReplacementNamed(context, logInName);
        }
      } else {
        prefs.setBool('first_time', false);
        Navigator.pushReplacementNamed(context, onboardingName);
      }
      // Navigator.pushReplacementNamed(context, onboardingName);
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
            size: dimensWidth()*20,
          ),
          Container(
            padding: EdgeInsets.only(top: dimensHeight()*2),
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
