import 'package:flutter/material.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/res/colors.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/utils/linear_progress_indicator.dart';

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
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(context, onboardingId);
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
          Container(
            width: dimensWidth()*100,
            alignment: Alignment.center,
            child: Text(
              'HealthLine',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: white),
            ),
          ),
          // ProgressIndicator()
          const LinearProgressIndicatorLoading(seconds: 2,)
        ],
      ),
    );
  }
}
