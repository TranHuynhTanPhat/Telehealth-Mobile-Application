import 'package:flutter/material.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/screens/auth/login/login_screen.dart';
import 'package:healthline/screens/auth/signup/signup_screen.dart';
import 'package:healthline/screens/error/error_screen.dart';
import 'package:healthline/screens/main/main_sceen.dart';
import 'package:healthline/screens/splash/onboarding.dart';

import 'package:healthline/screens/splash/splash_screen.dart';
import 'package:healthline/screens/wallet/wallet_screen.dart';

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
      case walletName:
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case errorName:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      default:
        return null;
    }
  }
}
