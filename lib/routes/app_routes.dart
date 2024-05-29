import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubit_chat/chat_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_forum/forum_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_prescription/prescription_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_wallet/wallet_cubit.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/consultation_response.dart';
import 'package:healthline/data/api/models/responses/doctor_detail_response.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/data/api/models/responses/room_chat.dart';
import 'package:healthline/data/api/socket_manager.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/auth/forget_password/forgot_password_screen.dart';
import 'package:healthline/screen/auth/login/login_screen.dart';
import 'package:healthline/screen/auth/register_doctor/register_doctor_screen.dart';
import 'package:healthline/screen/auth/signup/signup_screen.dart';
import 'package:healthline/screen/change_password/change_password_screen.dart';
import 'package:healthline/screen/chat/chat_box_screen.dart';
import 'package:healthline/screen/chat/chat_screen.dart';
import 'package:healthline/screen/error/error_screen.dart';
import 'package:healthline/screen/forum/edit_post_screen.dart';
import 'package:healthline/screen/forum/forum_screen.dart';
import 'package:healthline/screen/license/bug_report.dart';
import 'package:healthline/screen/license/faqs_screen.dart';
import 'package:healthline/screen/license/privacy_policy_screen.dart';
import 'package:healthline/screen/license/terms_and_conditions_screen.dart';
import 'package:healthline/screen/news/detail_news_screen.dart';
import 'package:healthline/screen/news/news_screen.dart';
import 'package:healthline/screen/prescription/add_prescription_screen.dart';
import 'package:healthline/screen/prescription/prescription_screen.dart';
import 'package:healthline/screen/schedule/detail_consultation.dart';
import 'package:healthline/screen/splash/onboarding.dart';
import 'package:healthline/screen/ui_doctor/account_setting/update_profile_screen.dart';
import 'package:healthline/screen/ui_doctor/main_screen_doctor.dart';
import 'package:healthline/screen/ui_doctor/patient/detail_patient/detail_history_screen.dart';
import 'package:healthline/screen/ui_doctor/patient/detail_patient/list_history_screen.dart';
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
import 'package:healthline/screen/ui_patient/main/home/doctor/list_wish_screen/list_wish_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/all_feedbacks.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/create_consultation_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/detail_doctor_screen.dart';
import 'package:healthline/screen/ui_patient/main/main_sceen_patient.dart';
import 'package:healthline/screen/ui_patient/main/notification/notification_screen.dart';
import 'package:healthline/screen/update/update_screen.dart';
import 'package:healthline/screen/wallet/pay_screen.dart';
import 'package:healthline/screen/wallet/wallet_screen.dart';

class AppRoute {
  late SocketManager _socketForum;
  late SocketManager _socketChat;
  late VaccineRecordCubit _vaccineRecordCubit;
  late AuthenticationCubit _authenticationCubit;
  late MedicalRecordCubit _medicalRecordCubit;
  late PatientProfileCubit _patientProfileCubit;
  late DocsVaccinationCubit _docsVaccination;
  late DoctorScheduleCubit _doctorScheduleCubit;
  late DoctorProfileCubit _doctorProfileCubit;
  late PatientRecordCubit _patientRecordCubit;
  late DoctorCubit _doctorCubit;
  late NewsCubit _newsCubit;
  late ForumCubit _forumCubit;
  late ConsultationCubit _consultationCubit;
  late ChatCubit _chatCubit;
  late WalletCubit _walletCubit;
  late PrescriptionCubit _prescriptionCubit;
  // final _applicationUpdateBloc = ApplicationUpdateCubit();

  AppRoute() {
    init();
  }

  void init() {
    _socketForum = SocketManager(port: PortSocket.comments);
    _socketChat = SocketManager(port: PortSocket.chat);
    _vaccineRecordCubit = VaccineRecordCubit();
    _authenticationCubit = AuthenticationCubit();
    _medicalRecordCubit = MedicalRecordCubit();
    _patientProfileCubit = PatientProfileCubit();
    _docsVaccination = DocsVaccinationCubit();
    _doctorScheduleCubit = DoctorScheduleCubit();
    _doctorProfileCubit = DoctorProfileCubit();
    _patientRecordCubit = PatientRecordCubit();
    _doctorCubit = DoctorCubit();
    _newsCubit = NewsCubit();
    _forumCubit = ForumCubit(socketManager: _socketForum);
    _consultationCubit = ConsultationCubit();
    _chatCubit = ChatCubit(socketManager: _socketChat);
    _walletCubit = WalletCubit();
    _prescriptionCubit = PrescriptionCubit();
  }

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
    _chatCubit.close();
    _walletCubit.close();
    // _applicationUpdateBloc.close();

    AppController().close();
  }

  Route? onGeneralRoute(RouteSettings settings) {
    if (AppController().authState == AuthState.DoctorAuthorized ||
        AppController().authState == AuthState.PatientAuthorized ||
        AppController().authState == AuthState.Unauthorized) {
      switch (settings.name) {
        case forumName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _forumCubit,
              child: const ForumScreen(),
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
        case chatName:
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
                  value: _chatCubit,
                ),
              ],
              child: const ChatScreen(),
            ),
          );
        case chatBoxName:
          RoomChat args = settings.arguments as RoomChat;
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _consultationCubit,
                ),
                BlocProvider.value(
                  value: _chatCubit,
                ),
              ],
              child: ChatBoxScreen(
                detail: args,
              ),
            ),
          );
        case notificationName:
          return MaterialPageRoute(
            builder: (_) => const NotificationScreen(),
          );
        case registerDoctorName:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _doctorCubit,
                ),
                BlocProvider.value(
                  value: _authenticationCubit,
                ),
              ],
              child: const RegisterDoctorScreen(),
            ),
          );
        case prescriptionName:
          final args = settings.arguments as String?;

          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
              
                BlocProvider.value(
                  value: _prescriptionCubit,
                ),
              ],
              child: PrescriptionScreen(consultationId: args),
            ),
          );
      }
    }
    if (AppController().authState == AuthState.DoctorAuthorized ||
        AppController().authState == AuthState.PatientAuthorized) {
      switch (settings.name) {
        case editPostName:
          final args = settings.arguments as String?;

          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _forumCubit,
              child: EditPostScreen(args: args),
            ),
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
                BlocProvider.value(
                  value: _walletCubit,
                ),
              ],
              child: const WalletScreen(),
            ),
          );
        case payName:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _walletCubit,
                ),
              ],
              child: const PayScreen(),
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
        case updateName:
          return MaterialPageRoute(
            builder: (_) => const UpdateScreen(),
          );
        case addPrescriptionName:
          final args = settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                
                BlocProvider.value(
                  value: _prescriptionCubit,
                ),
              ],
              child: AddPrescriptionScreen(
                prescriptionResponse: args?['prescriptionResponse'],
                consultationId: args?['consultationId'],
              ),
            ),
          );
      }
    }
    if (AppController().authState == AuthState.Unauthorized) {
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

        default:
          // case logInName:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _authenticationCubit,
              child: const LogInScreen(),
            ),
          );
      }
    } else if (AppController().authState == AuthState.DoctorAuthorized) {
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
                BlocProvider.value(
                  value: _chatCubit,
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
        case listHistoryConsultation:
          final args = settings.arguments as String?;

          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _consultationCubit,
              child: ListHistoryConsultationScreen(medicalId: args),
            ),
          );
        case detailHistoryConsultation:
          final args = settings.arguments as ConsultationResponse?;

          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _consultationCubit,
                ),
                 BlocProvider.value(
                  value: _prescriptionCubit,
                ),
                BlocProvider.value(
                  value: _patientRecordCubit,
                ),
              ],
              child: DetailHistoryConsultationScreen(consultation: args),
            ),
          );
      }
    } else if (AppController().authState == AuthState.PatientAuthorized) {
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
                BlocProvider.value(
                  value: _chatCubit,
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
        case wishListName:
          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _doctorCubit,
                ),
                // BlocProvider.value(
                //   value: _consultationCubit,
                // ),
              ],
              child: const ListWishScreen(),
            ),
          );
        case detailDoctorName:
          final args = settings.arguments as DoctorDetailResponse?;

          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _consultationCubit,
                ),
                BlocProvider.value(
                  value: _doctorCubit,
                ),
              ],
              child: DetailDoctorScreen(
                args: args,
              ),
            ),
          );
        case feedbacksName:
          final args = settings.arguments as List<FeedbackResponse>;
          return MaterialPageRoute(
            builder: (_) => AllFeedbacks(
              feedbacks: args,
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
                BlocProvider.value(
                  value: _patientProfileCubit,
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
