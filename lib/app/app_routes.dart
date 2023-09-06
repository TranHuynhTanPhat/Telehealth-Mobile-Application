import 'package:flutter/material.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/ui/auth/signup/signup_screen.dart';
import 'package:healthline/ui/main/main_sceen.dart';
import 'package:healthline/ui/splash/onboarding.dart';

import 'package:healthline/ui/splash/splash_screen.dart';

class AppRoute {
  Route? onGeneralRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashId:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case mainScreenId:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case onboardingId:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case signupId:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      default:
        return null;
    }
  }
}
