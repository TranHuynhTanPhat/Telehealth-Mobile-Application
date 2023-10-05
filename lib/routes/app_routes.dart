import 'package:flutter/material.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/auth/license/faqs_screen.dart';
import 'package:healthline/screen/auth/license/privacy_policy_screen.dart';
import 'package:healthline/screen/auth/license/terms_and_conditions_screen.dart';
import 'package:healthline/screen/auth/login/login_screen.dart';
import 'package:healthline/screen/auth/signup/signup_screen.dart';
import 'package:healthline/screen/ui_patient/change_password/change_password_screen.dart';
import 'package:healthline/screen/ui_patient/doctor/doctor_screen.dart';
import 'package:healthline/screen/ui_patient/doctor/subscreen/detail_doctor_screen.dart';
import 'package:healthline/screen/error/error_screen.dart';
import 'package:healthline/screen/ui_patient/main/main_sceen_patient.dart';
import 'package:healthline/screen/ui_patient/contact/contact_screen.dart';
import 'package:healthline/screen/splash/onboarding.dart';
import 'package:healthline/screen/splash/splash_screen.dart';
import 'package:healthline/screen/ui_patient/ref_vaccination/ref_vaccination_screen.dart';
import 'package:healthline/screen/ui_doctor/main/main_screen_doctor.dart';
import 'package:healthline/screen/ui_patient/vaccination/add_vaccination_screen.dart';
import 'package:healthline/screen/ui_patient/vaccination/vaccination_screen.dart';
import 'package:healthline/screen/ui_patient/wallet/wallet_screen.dart';

class AppRoute {
  Route? onGeneralRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case mainScreenPatientName:
        return MaterialPageRoute(builder: (_) => const MainScreenPatient());
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
      case addVaccinationName:
        return MaterialPageRoute(builder: (_) => const AddVaccinationScreen());
      case mainScreenDoctorName:
        return MaterialPageRoute(builder: (_) => const MainScreenDoctor());
      default:
        return null;
    }
  }
}
