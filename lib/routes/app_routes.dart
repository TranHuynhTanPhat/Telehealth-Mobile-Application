import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/auth/license/faqs_screen.dart';
import 'package:healthline/screen/auth/license/privacy_policy_screen.dart';
import 'package:healthline/screen/auth/license/terms_and_conditions_screen.dart';
import 'package:healthline/screen/auth/login/login_screen.dart';
import 'package:healthline/screen/auth/signup/signup_screen.dart';
import 'package:healthline/screen/ui_doctor/main/schedule/shift_screen.dart';
import 'package:healthline/screen/ui_doctor/main/setting/update_biography_screen.dart';
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
  final _homeCubit = HomeCubit();
  final _subUserCubit = SubUserCubit();
  final _vaccineRecordCubit = VaccineRecordCubit();
  final _sideMenuCubit = SideMenuCubit();
  final _healhStatCubit = HealthStatCubit();
  final _contactCubit = ContactCubit();
  final _vaccinationCubit = VaccinationCubit();
  final _logInCubit = LogInCubit();
  final _signUpCubit = SignUpCubit();
  final _scheduleCubit = ScheduleCubit();

  void dispose() {
    _homeCubit.close();
    _subUserCubit.close();
    _vaccineRecordCubit.close();
    _sideMenuCubit.close();
    _healhStatCubit.close();
    _contactCubit.close();
    _vaccinationCubit.close();
    _logInCubit.close();
    _signUpCubit.close();
    _scheduleCubit.close();
  }

  Route? onGeneralRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case mainScreenPatientName:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _sideMenuCubit,
                    ),
                    BlocProvider.value(
                      value: _subUserCubit,
                    ),
                    BlocProvider.value(
                      value: _vaccineRecordCubit,
                    ),
                    BlocProvider.value(
                      value: _homeCubit,
                    ),
                    BlocProvider.value(
                      value: _healhStatCubit,
                    ),
                  ],
                  child: const MainScreenPatient(),
                ));
      case onboardingName:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case signUpName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _signUpCubit,
                  child: const SignUpScreen(),
                ));
      case logInName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _logInCubit,
                  child: const LogInScreen(),
                ));
      case walletName:
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case contactName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _contactCubit,
                  child: const ContactScreen(),
                ));
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
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => _vaccinationCubit,
                  child: const RefVaccinationScreen(),
                ));
      case vaccinationName:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _vaccineRecordCubit,
                    ),
                    BlocProvider.value(
                      value: _subUserCubit,
                    ),
                  ],
                  child: const VaccinationScreen(),
                ));
      case addVaccinationName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _vaccineRecordCubit,
                  child: const AddVaccinationScreen(),
                ));
      case mainScreenDoctorName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _sideMenuCubit,
                  child: const MainScreenDoctor(),
                ));
      case shiftDoctorName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _scheduleCubit,
                  child: const ShiftScreen(),
                ));
      case updateBiographyDoctorName:
        return MaterialPageRoute(builder: (_) => const UpdateBiographyScreen());
      default:
        return null;
    }
  }
}
