import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_forum/forum_cubit.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/auth/forget_password/forgot_password_screen.dart';
import 'package:healthline/screen/auth/login/login_screen.dart';
import 'package:healthline/screen/auth/signup/signup_screen.dart';
import 'package:healthline/screen/change_password/change_password_screen.dart';
import 'package:healthline/screen/error/error_screen.dart';
import 'package:healthline/screen/forum/edit_post_screen.dart';
import 'package:healthline/screen/forum/forum_screen.dart';
import 'package:healthline/screen/license/bug_report.dart';
import 'package:healthline/screen/license/faqs_screen.dart';
import 'package:healthline/screen/license/privacy_policy_screen.dart';
import 'package:healthline/screen/license/terms_and_conditions_screen.dart';
import 'package:healthline/screen/news/detail_news_screen.dart';
import 'package:healthline/screen/news/news_screen.dart';
import 'package:healthline/screen/schedule/detail_consultation.dart';
import 'package:healthline/screen/splash/onboarding.dart';
import 'package:healthline/screen/ui_doctor/account_setting/update_profile_screen.dart';
import 'package:healthline/screen/ui_doctor/main_screen_doctor.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/shift_screen.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/update_default_schedule.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/update_schedule_by_day_screen.dart';
import 'package:healthline/screen/ui_patient/account_setting/account_setting_screen.dart';
import 'package:healthline/screen/ui_patient/account_setting/contact/contact_screen.dart';
import 'package:healthline/screen/ui_patient/application_setting/application_setting_screen.dart';
import 'package:healthline/screen/ui_patient/helps/helps_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/patient_record/add_patient_record_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/patient_record/patient_record_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/update_health_stat/update_health_stat_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/vaccination/add_vaccination_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/vaccination/vaccination_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/docs_vaccination/docs_vaccination_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/doctor_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/create_consultation_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/detail_doctor_screen.dart';
import 'package:healthline/screen/ui_patient/main/main_sceen_patient.dart';
import 'package:healthline/screen/update/update_screen.dart';
import 'package:healthline/screen/wallet/wallet_screen.dart';

class AppRoute {
  final _vaccineRecordCubit = VaccineRecordCubit();
  final _authenticationCubit = AuthenticationCubit();
  final _medicalRecordCubit = MedicalRecordCubit();
  final _patientProfileCubit = PatientProfileCubit();
  final _docsVaccination = DocsVaccinationCubit();
  final _doctorScheduleCubit = DoctorScheduleCubit();
  final _doctorProfileCubit = DoctorProfileCubit();
  final _patientRecordCubit = PatientRecordCubit();
  final _doctorCubit = DoctorCubit();
  final _newsCubit = NewsCubit();
  final _forumCubit = ForumCubit();
  final _consultationCubit = ConsultationCubit();
  // final _applicationUpdateBloc = ApplicationUpdateCubit();

  void dispose() {
    _vaccineRecordCubit.close();
    _authenticationCubit.close();
    _medicalRecordCubit.close();
    _patientProfileCubit.close();
    _docsVaccination.close();
    _doctorScheduleCubit.close();
    _doctorProfileCubit.close();
    _patientRecordCubit.close();
    _doctorCubit.close();
    _newsCubit.close();
    _forumCubit.close();
    _consultationCubit.close();
    // _applicationUpdateBloc.close();

    AppController.instance.close();
  }

  Route? onGeneralRoute(RouteSettings settings) {
    if (AppController.instance.authState == AuthState.DoctorAuthorized ||
        AppController.instance.authState == AuthState.PatientAuthorized) {
      switch (settings.name) {
        case forumName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _forumCubit,
              child: const ForumScreen(),
            ),
          );
        case editPostName:
          final args = settings.arguments as String?;

          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _forumCubit,
              child: EditPostScreen(args: args),
            ),
          );
        case newsName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _newsCubit,
              child: const NewsScreen(),
            ),
          );
        case detailNewsName:
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (_) => DetailNewsScreen(args: args),
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
        case bugReportName:
          return MaterialPageRoute(
            builder: (_) => const BugReportScreen(),
          );
        case walletName:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _patientProfileCubit,
                ),
                BlocProvider.value(
                  value: _doctorProfileCubit,
                ),
              ],
              child: const WalletScreen(),
            ),
          );
        case changePasswordName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _authenticationCubit,
              child: const ChangePassword(),
            ),
          );
        case detailConsultationName:
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _consultationCubit,
                ),
                BlocProvider.value(
                  value: _patientRecordCubit,
                ),
              ],
              child: DetailConsultationScreen(
                args: args,
              ),
            ),
          );
      }
    }
    if (AppController.instance.authState == AuthState.Unauthorized) {
      switch (settings.name) {
        case onboardingName:
          return MaterialPageRoute(
            builder: (_) => const OnboardingScreen(),
          );
        case signUpName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _authenticationCubit,
              child: const SignUpScreen(),
            ),
          );
        case forgetPasswordName:
          bool isDoctor = settings.arguments as bool? ?? false;
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _authenticationCubit,
              child: ForgotPasswordScreen(isDoctor: isDoctor),
            ),
          );

        // default:
        case logInName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _authenticationCubit,
              child: const LogInScreen(),
            ),
          );
      }
    } else if (AppController.instance.authState == AuthState.DoctorAuthorized) {
      switch (settings.name) {
        case mainScreenDoctorName:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _authenticationCubit,
                ),
                BlocProvider.value(
                  value: _doctorProfileCubit,
                ),
                BlocProvider.value(
                  value: _doctorScheduleCubit,
                ),
                BlocProvider.value(
                  value: _consultationCubit,
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
                  value: _authenticationCubit,
                ),
                BlocProvider.value(
                  value: _vaccineRecordCubit,
                ),
                BlocProvider.value(
                  value: _medicalRecordCubit,
                ),
                BlocProvider.value(
                  value: _patientRecordCubit,
                ),
                BlocProvider.value(
                  value: _doctorCubit,
                ),
                BlocProvider.value(
                  value: _consultationCubit,
                ),
              ],
              child: const MainScreenPatient(),
            ),
          );
        case doctorName:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _doctorCubit,
                ),
                BlocProvider.value(
                  value: _consultationCubit,
                ),
              ],
              child: const DoctorScreen(),
            ),
          );
        case detailDoctorName:
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _consultationCubit,
              child: DetailDoctorScreen(
                args: args,
              ),
            ),
          );
        case accountSettingName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _authenticationCubit,
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
              value: _patientProfileCubit,
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

        case refVaccinationName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => _docsVaccination,
              child: const DocsVaccinationScreen(),
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
        // case timelineDoctorName:
        // String? args = settings.arguments as String?;
        //   return MaterialPageRoute(
        //     builder: (_) => BlocProvider.value(
        //       value: _consultationCubit,
        //       child: TimelineDoctorScreen(args: args),
        //     ),
        //   );
        // case paymentMethodsName:
        //   return MaterialPageRoute(
        //     builder: (_) => BlocProvider.value(
        //       value: _consultationCubit,
        //       child: const PaymentMethodScreen(),
        //     ),
        //   );
        // case invoiceName:
        //   return MaterialPageRoute(
        //     builder: (_) => BlocProvider.value(
        //       value: _consultationCubit,
        //       child: const InvoiceScreen(),
        //     ),
        //   );
        case createConsultationName:
          String? args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _consultationCubit,
                ),
                BlocProvider.value(
                  value: _medicalRecordCubit,
                ),
                BlocProvider.value(
                  value: _patientRecordCubit,
                ),
              ],
              child: CreateConsultationScreen(
                args: args,
              ),
            ),
          );
        // case formConsultationName:
        //   return MaterialPageRoute(
        //     builder: (_) => BlocProvider.value(
        //       value: _consultationCubit,
        //       child: const FormConsultationScreen(),
        //     ),
        //   );
        // case formMedicalDeclarationName:
        //   return MaterialPageRoute(
        //     builder: (_) => MultiBlocProvider(
        //       providers: [
        //         BlocProvider.value(
        //           value: _consultationCubit,
        //         ),
        //         BlocProvider.value(
        //           value: _patientRecordCubit,
        //         ),
        //       ],
        //       child: const FormMedicalDeclaration(),
        //     ),
        //   );
      }
    }
    return MaterialPageRoute(
      builder: (_) => const ErrorScreen(),
    );
  }
}
