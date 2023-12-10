import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/app_controller.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/license/faqs_screen.dart';
import 'package:healthline/screen/license/privacy_policy_screen.dart';
import 'package:healthline/screen/license/terms_and_conditions_screen.dart';
import 'package:healthline/screen/auth/login/login_screen.dart';
import 'package:healthline/screen/auth/signup/signup_screen.dart';
import 'package:healthline/screen/error/error_screen.dart';
import 'package:healthline/screen/forum/forum_screen.dart';
import 'package:healthline/screen/news/news_screen.dart';
import 'package:healthline/screen/splash/onboarding.dart';
import 'package:healthline/screen/ui_doctor/account_setting/update_profile_screen.dart';
import 'package:healthline/screen/ui_doctor/main_screen_doctor.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/shift_screen.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/update_default_schedule.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/update_schedule_by_day_screen.dart';
import 'package:healthline/screen/ui_patient/account_setting/account_setting_screen.dart';
import 'package:healthline/screen/ui_patient/account_setting/change_password/change_password_screen.dart';
import 'package:healthline/screen/ui_patient/account_setting/contact/contact_screen.dart';
import 'package:healthline/screen/ui_patient/account_setting/wallet/wallet_screen.dart';
import 'package:healthline/screen/ui_patient/application_setting/application_setting_screen.dart';
import 'package:healthline/screen/ui_patient/helps/helps_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/patient_record/add_patient_record_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/patient_record/patient_record_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/update_health_stat_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/vaccination/add_vaccination_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/vaccination/vaccination_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/doctor_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/detail_doctor_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/invoice_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/payment_method_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/timeline_doctor_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/ref_vaccination/ref_vaccination_screen.dart';
import 'package:healthline/screen/ui_patient/main/main_sceen_patient.dart';
import 'package:healthline/screen/update/update_screen.dart';

class AppRoute {
  final _homeCubit = HomeCubit();
  final _vaccineRecordCubit = VaccineRecordCubit();
  final _sideMenuCubit = SideMenuCubit();
  final _medicalRecordCubit = MedicalRecordCubit();
  final _contactCubit = ContactCubit();
  final _vaccinationCubit = VaccinationCubit();
  final _logInCubit = LogInCubit();
  final _signUpCubit = SignUpCubit();
  final _doctorScheduleCubit = DoctorScheduleCubit();
  final _doctorProfileCubit = DoctorProfileCubit();
  final _patientRecordCubit = PatientRecordCubit();
  final _doctorCubit = DoctorCubit();
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
    _doctorScheduleCubit.close();
    _doctorProfileCubit.close();
    _patientRecordCubit.close();
    _doctorCubit.close();
    // _applicationUpdateBloc.close();
  }

  Route? onGeneralRoute(RouteSettings settings) {
    if (AppController.instance.authState == AuthState.Unauthorized) {
      switch (settings.name) {
        case onboardingName:
          return MaterialPageRoute(
            builder: (_) => const OnboardingScreen(),
          );
        case signUpName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _signUpCubit,
              child: const SignUpScreen(),
            ),
          );
        case errorName:
          return MaterialPageRoute(
            builder: (_) => const ErrorScreen(),
          );

        case termsAndConditionsName:
          return MaterialPageRoute(
            builder: (_) => const TermsAndConditionsScreen(),
          );
        case faqsName:
          return MaterialPageRoute(
            builder: (_) => const FAQsScreen(),
          );
        case privacyPolicyName:
          return MaterialPageRoute(
            builder: (_) => const PrivacyPolicyScreen(),
          );
        case forumName:
          return MaterialPageRoute(
            builder: (_) => const ForumScreen(),
          );
        case newsName:
          return MaterialPageRoute(
            builder: (_) => const NewsScreen(),
          );
        default:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _logInCubit,
              child: const LogInScreen(),
            ),
          );
      }
      // if (settings.name == onboardingName) {
      //   return MaterialPageRoute(
      //     builder: (_) => const OnboardingScreen(),
      //   );
      // }
      // if (settings.name == signUpName) {
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider.value(
      //       value: _signUpCubit,
      //       child: const SignUpScreen(),
      //     ),
      //   );
      // } else {
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider.value(
      //       value: _logInCubit,
      //       child: const LogInScreen(),
      //     ),
      //   );
      // }
    } else if (AppController.instance.authState == AuthState.DoctorAuthorized) {
      switch (settings.name) {
        case mainScreenDoctorName:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _sideMenuCubit,
                ),
                BlocProvider.value(
                  value: _doctorProfileCubit,
                ),
                BlocProvider.value(
                  value: _doctorScheduleCubit,
                ),
              ],
              child: const MainScreenDoctor(),
            ),
          );
        case shiftDoctorName:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _doctorScheduleCubit),
              ],
              child: const ShiftScreen(),
            ),
          );
        case updateProfileDoctorName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _doctorProfileCubit,
              child: const UpdateProfileScreen(),
            ),
          );
        case updateDefaultScheduleDoctorName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _doctorScheduleCubit,
              child: const UpdateDefaultScheduleScreen(),
            ),
          );
        case updateScheduleByDayDoctorName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _doctorScheduleCubit,
              child: const UpdateScheduleByDayScreen(),
            ),
          );
      }
    } else if (AppController.instance.authState ==
        AuthState.PatientAuthorized) {
      switch (settings.name) {
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
                BlocProvider.value(
                  value: _patientRecordCubit,
                ),
              ],
              child: const MainScreenPatient(),
            ),
          );
        case doctorName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _doctorCubit,
              child: const DoctorScreen(),
            ),
          );
        case detailDoctorName:
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (_) => DetailDoctorScreen(
              id: args,
            ),
          );
        case walletName:
          return MaterialPageRoute(
            builder: (_) => const WalletScreen(),
          );
        case accountSettingName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _sideMenuCubit,
              child: const AccountSettingScreen(),
            ),
          );
        case applicationSettingName:
          return MaterialPageRoute(
            builder: (_) => const ApplicationSettingScreen(),
          );
        case contactName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _contactCubit,
              child: const ContactScreen(),
            ),
          );
        case updateName:
          return MaterialPageRoute(
            builder: (_) => const UpdateScreen(),
          );
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
            ),
          );
        case addVaccinationName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _vaccineRecordCubit,
              child: const AddVaccinationScreen(),
            ),
          );
        case changePasswordName:
          return MaterialPageRoute(
            builder: (_) => const ChangePassword(),
          );
        case refVaccinationName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => _vaccinationCubit,
              child: const RefVaccinationScreen(),
            ),
          );
        case updateHealthStatName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _medicalRecordCubit,
              child: const HealthStatUpdateScreen(),
            ),
          );
        case patientRecordName:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _medicalRecordCubit,
                ),
                BlocProvider.value(
                  value: _patientRecordCubit,
                ),
              ],
              child: const PatientRecordScreen(),
            ),
          );
        case addPatientRecordName:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _patientRecordCubit,
                ),
              ],
              child: const AddPatientRecordScreen(),
            ),
          );
        case helpsName:
          return MaterialPageRoute(
            builder: (_) => const HelpsScreen(),
          );
        case timelineDoctorName:
          return MaterialPageRoute(
            builder: (_) => const TimelineDoctorScreen(),
          );
        case paymentMethodsName:
          return MaterialPageRoute(
            builder: (_) => const PaymentMethodScreen(),
          );
        case invoiceName:
          return MaterialPageRoute(
            builder: (_) => const InvoiceScreen(),
          );
      }
    }
    switch (settings.name) {
      // case splashName:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //           value: _applicationUpdateBloc, child: const SplashScreen()));

      // case signUpName:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider.value(
      //       value: _signUpCubit,
      //       child: const SignUpScreen(),
      //     ),
      //   );
      // case logInName:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider.value(
      //       value: _logInCubit,
      //       child: const LogInScreen(),
      //     ),
      //   );
      // case signUpName:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider.value(
      //       value: _signUpCubit,
      //       child: const SignUpScreen(),
      //     ),
      //   );
      // case logInName:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider.value(
      //       value: _logInCubit,
      //       child: const LogInScreen(),
      //     ),
      //   );

      default:
        return null;
    }
  }
}
