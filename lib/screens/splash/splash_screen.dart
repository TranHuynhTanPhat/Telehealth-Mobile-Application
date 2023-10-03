// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/linear_progress_indicator.dart';
import 'package:healthline/utils/translate.dart';

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
        if (AppController().authState == AuthState.Unauthorized) {
          Navigator.pushReplacementNamed(context, logInName);
        }
        // else if (AppController().authState == AuthState.Authorized) {
        //   Navigator.pushReplacementNamed(context, mainScreenName);
        // }
      } else {
        prefs.setBool('first_time', false);
        Navigator.pushReplacementNamed(context, onboardingName);
      }
      // Navigator.pushReplacementNamed(context, mainScreenName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HealthInfoCubit(),
      child: BlocListener<HealthInfoCubit, HealthInfoState>(
        listener: (context, state) {
          if (state is HealthInfoLoaded) {
            Navigator.pushReplacementNamed(context, mainScreenName);
          } else if (state is HealthInfoError) {
            Navigator.pushReplacementNamed(context, logInName);
            EasyLoading.showToast(translate(context, 'cant_load_data'));
          }
        },
        child: Builder(builder: (context) {
          context.read<HealthInfoCubit>().fetchMedicalRecord();
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
        }),
      ),
    );
  }
}
