import 'package:flutter/material.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/screens/auth/license/faqs_screen.dart';
import 'package:healthline/screens/auth/license/privacy_policy_screen.dart';
import 'package:healthline/screens/auth/license/terms_and_conditions_screen.dart';
import 'package:healthline/screens/auth/login/login_screen.dart';
import 'package:healthline/screens/auth/signup/signup_screen.dart';
import 'package:healthline/screens/change_password/change_password_screen.dart';
import 'package:healthline/screens/doctor/doctor_screen.dart';
import 'package:healthline/screens/doctor/subscreen/detail_doctor_screen.dart';
import 'package:healthline/screens/error/error_screen.dart';
import 'package:healthline/screens/main/main_sceen.dart';
import 'package:healthline/screens/contact/contact_screen.dart';
import 'package:healthline/screens/splash/onboarding.dart';
import 'package:healthline/screens/splash/splash_screen.dart';
import 'package:healthline/screens/ref_vaccination/ref_vaccination_screen.dart';
import 'package:healthline/screens/vaccination/vaccination_screen.dart';
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
      case contactName:
        return MaterialPageRoute(builder: (_) => const ContactScreen());
      case errorName:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      case termsAndConditionsName:
        return MaterialPageRoute(
            builder: (_) => const TermsAndConditionsScreen());
      case faqsName:
        return MaterialPageRoute(builder: (_) => const FAQsScreen());
      case privacyPolicyName:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case doctorName:
        return MaterialPageRoute(builder: (_) => const DoctorScreen());
      case detailDoctorName:
        return MaterialPageRoute(builder: (_) => const DetailDoctorScreen());
      case changePasswordName:
        return MaterialPageRoute(builder: (_) => const ChangePassword());
      case refVaccinationName:
        return MaterialPageRoute(builder: (_) => const RefVaccinationScreen());
      case vaccinationName:
        return MaterialPageRoute(builder: (_) => const VaccinationScreen());
      default:
        return null;
    }
  }
}
