import 'package:flutter/material.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/views/auth/login/login_screen.dart';
import 'package:healthline/views/auth/signup/signup_screen.dart';
import 'package:healthline/views/main/main_sceen.dart';
import 'package:healthline/views/splash/onboarding.dart';

import 'package:healthline/views/splash/splash_screen.dart';

class AppRoute {
  Route? onGeneralRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case mainScreenName:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case onboardingName:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case signUpName:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case logInName:
        return MaterialPageRoute(builder: (_) => const LogInScreen());
      default:
        return null;
    }
  }
}
