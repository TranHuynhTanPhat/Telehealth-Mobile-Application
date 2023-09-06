import 'package:flutter/material.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/ui/auth/login/login_screen.dart';
import 'package:healthline/ui/auth/signup/signup_screen.dart';
import 'package:healthline/ui/main/main_sceen.dart';
import 'package:healthline/ui/splash/onboarding.dart';

import 'package:healthline/ui/splash/splash_screen.dart';

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
