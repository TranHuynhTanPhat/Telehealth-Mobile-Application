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
import 'package:healthline/screen/ui_patient/account_setting/account_setting_screen.dart';
import 'package:healthline/screen/ui_patient/account_setting/change_password/change_password_screen.dart';
import 'package:healthline/screen/application_setting/application_setting_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/doctor_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/detail_doctor_screen.dart';
import 'package:healthline/screen/error/error_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/update_health_stat.dart';
import 'package:healthline/screen/ui_patient/main/main_sceen_patient.dart';
import 'package:healthline/screen/ui_patient/account_setting/contact/contact_screen.dart';
import 'package:healthline/screen/splash/onboarding.dart';
import 'package:healthline/screen/ui_patient/main/home/ref_vaccination/ref_vaccination_screen.dart';
import 'package:healthline/screen/ui_doctor/main/main_screen_doctor.dart';
import 'package:healthline/screen/ui_patient/main/health_info/vaccination/add_vaccination_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/vaccination/vaccination_screen.dart';
import 'package:healthline/screen/ui_patient/account_setting/wallet/wallet_screen.dart';
import 'package:healthline/screen/update/update_screen.dart';

import '../screen/ui_doctor/main/account_setting/update_profile_screen.dart';

class AppRoute {
  final _homeCubit = HomeCubit();
  final _vaccineRecordCubit = VaccineRecordCubit();
  final _sideMenuCubit = SideMenuCubit();
  final _medicalRecordCubit = MedicalRecordCubit();
  final _contactCubit = ContactCubit();
  final _vaccinationCubit = VaccinationCubit();
  final _logInCubit = LogInCubit();
  final _signUpCubit = SignUpCubit();
  final _scheduleCubit = ScheduleCubit();
  final _doctorProfileCubit = DoctorProfileCubit();
  // final _applicationUpdateBloc = ApplicationUpdateCubit();

  void dispose() {
    _homeCubit.close();
    _vaccineRecordCubit.close();
    _sideMenuCubit.close();
    _medicalRecordCubit.close();
    _contactCubit.close();
    _vaccinationCubit.close();
    _logInCubit.close();
    _signUpCubit.close();
    _scheduleCubit.close();
    _doctorProfileCubit.close();
    // _applicationUpdateBloc.close();
  }

  Route? onGeneralRoute(RouteSettings settings) {
    switch (settings.name) {
      // case splashName:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //           value: _applicationUpdateBloc, child: const SplashScreen()));
      case mainScreenPatientName:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _sideMenuCubit,
                    ),
                    BlocProvider.value(
                      value: _vaccineRecordCubit,
                    ),
                    BlocProvider.value(
                      value: _homeCubit,
                    ),
                    BlocProvider.value(
                      value: _medicalRecordCubit,
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
      case accountSettingName:
        return MaterialPageRoute(builder: (_) => const AccountSettingScreen());
      case applicationSettingName:
        return MaterialPageRoute(
            builder: (_) => const ApplicationSettingScreen());
      case contactName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _contactCubit,
                  child: const ContactScreen(),
                ));
      case errorName:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      case updateName:
        return MaterialPageRoute(
          builder: (_) => const UpdateScreen(),
        );
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
                      value: _medicalRecordCubit,
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
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _sideMenuCubit,
                    ),
                    BlocProvider.value(
                      value: _doctorProfileCubit,
                    )
                  ],
                  child: const MainScreenDoctor(),
                ));
      case shiftDoctorName:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _scheduleCubit),
                    BlocProvider.value(value: _doctorProfileCubit),
                  ],
                  child: const ShiftScreen(),
                ));
      case updateProfileDoctorName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _doctorProfileCubit,
                  child: const UpdateProfileScreen(),
                ));
      case updateHealthStatName:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _medicalRecordCubit,
                    ),
                  ],
                  child: const HealthStatUpdateScreen(),
                ));
      default:
        return null;
    }
  }
}
