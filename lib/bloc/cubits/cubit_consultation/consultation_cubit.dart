// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/app/healthline_app.dart';
import 'package:healthline/app/push_notification_manager.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/requests/feedback_request.dart';
import 'package:healthline/data/api/models/responses/all_consultation_response.dart';

import 'package:healthline/data/api/models/responses/consultation_response.dart';
import 'package:healthline/data/api/models/responses/discount_response.dart';
import 'package:healthline/data/api/models/responses/doctor_dasboard_response.dart';
import 'package:healthline/data/api/models/responses/drug_response.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/data/api/models/responses/money_chart_response.dart';
import 'package:healthline/data/api/models/responses/prescription_response.dart';
import 'package:healthline/data/api/models/responses/statistic_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/data/storage/models/consultation_notification_model.dart';
import 'package:healthline/data/storage/provider/consultation_notification_provider.dart';
import 'package:healthline/repositories/consultation_repository.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

part 'consultation_state.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  ConsultationCubit()
      : super(
          ConsultationInitial(
            blocState: BlocState.Successed,
            timeline: [],
            consultations: null,
            feedbacks: [],
          ),
        );
  final ConsultationRepository _consultationRepository =
      ConsultationRepository();

  @override
  void onChange(Change<ConsultationState> change) {
    super.onChange(change);
    logPrint(
        "$change:${change.currentState.blocState} ${change.nextState.blocState}");
  }

  Future<void> fetchDiscount() async {
    emit(
      FetchDiscountState(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      List<DiscountResponse> discounts =
          await _consultationRepository.fetchDiscount();
      emit(
        FetchDiscountState(
            blocState: BlocState.Successed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            data: discounts),
      );
    } catch (error) {
      emit(
        FetchDiscountState(
          error: error.toString(),
          blocState: BlocState.Failed,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks,
        ),
      );
    }
  }

  Future<void> announceBusy({required String consultationId}) async {
    emit(
      AnnounceBusyState(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      await _consultationRepository.announceBusy(
          consultationId: consultationId);
      emit(
        AnnounceBusyState(
          blocState: BlocState.Successed,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks,
        ),
      );
    } catch (error) {
      emit(
        AnnounceBusyState(
          error: error.toString(),
          blocState: BlocState.Failed,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks,
        ),
      );
    }
  }

  Future<void> searchDrug(
      {required String key,
      required int pageKey,
      required Function(List<DrugResponse>) callback}) async {
    emit(
      SearchDrugState(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      List<DrugResponse> drugs =
          await _consultationRepository.searchDrug(key: key, pageKey: pageKey);
      callback(drugs);
      emit(
        SearchDrugState(
          blocState: BlocState.Successed,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks,
        ),
      );
    } catch (error) {
      emit(
        SearchDrugState(
          error: error.toString(),
          blocState: BlocState.Failed,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks,
        ),
      );
    }
  }

  Future<void> getInfoDrug({
    required String id,
  }) async {
    emit(
      GetInfoDrugState(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      DrugResponse drug = await _consultationRepository.getInfoDrug(id: id);
      emit(
        GetInfoDrugState(
            blocState: BlocState.Successed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            data: drug),
      );
    } catch (error) {
      emit(
        GetInfoDrugState(
          error: error.toString(),
          blocState: BlocState.Failed,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks,
        ),
      );
    }
  }

  Future<void> fetchPrescription({required String consultationId}) async {
    emit(
      FetchPrescriptionState(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      PrescriptionResponse pre =
          await _consultationRepository.fetchPrescription(
        consultationId: consultationId,
        isDoctor: AppController().authState == AuthState.DoctorAuthorized,
      );
      emit(
        FetchPrescriptionState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            data: pre),
      );
    } on DioException catch (e) {
      emit(
        FetchPrescriptionState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchPrescriptionState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> fetchStatisticTable() async {
    emit(
      FetchStatisticTableState(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      StatisticResponse dis =
          await _consultationRepository.fetchStatisticTable(isDoctor: true);
      emit(
        FetchStatisticTableState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            data: dis),
      );
    } on DioException catch (e) {
      emit(
        FetchStatisticTableState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchStatisticTableState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> getFamiliarCustomer() async {
    emit(
      GetFamiliarCustomer(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      List<UserResponse> users =
          await _consultationRepository.getFamiliarCustomer(isDoctor: true);
      emit(
        GetFamiliarCustomer(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            data: users),
      );
    } on DioException catch (e) {
      emit(
        GetFamiliarCustomer(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        GetFamiliarCustomer(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> getNewCustomer() async {
    emit(
      GetNewCustomer(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      List<UserResponse> users =
          await _consultationRepository.getNewCustomer(isDoctor: true);
      emit(
        GetNewCustomer(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            data: users),
      );
    } on DioException catch (e) {
      emit(
        GetNewCustomer(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        GetNewCustomer(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<DiscountResponse?> checkDiscount({required String code}) async {
    emit(
      FetchTimelineState(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      DiscountResponse dis =
          await _consultationRepository.checkDiscount(code: code);
      emit(
        FetchTimelineState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
      return dis;
    } on DioException catch (e) {
      emit(
        FetchTimelineState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchTimelineState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
    return null;
  }

  Future<void> moneyChart({required int year}) async {
    emit(
      FetchMoneyChartState(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      MoneyChartResponse data =
          await _consultationRepository.moneyChart(year: year, isDoctor: true);
      emit(
        FetchMoneyChartState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            data: data),
      );
    } on DioException catch (e) {
      emit(
        FetchMoneyChartState(
          blocState: BlocState.Failed,
          timeline: [],
          error: e.response!.data['message'].toString(),
          consultations: state.consultations,
          feedbacks: state.feedbacks,
        ),
      );
    } catch (e) {
      emit(
        FetchMoneyChartState(
          blocState: BlocState.Failed,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks,
        ),
      );
    }
  }

  Future<void> fetchTimeline(
      {required String doctorId, required String date}) async {
    emit(
      FetchTimelineState(
        blocState: BlocState.Pending,
        timeline: [],
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      List<int> timeline =
          await _consultationRepository.fetchTimeline(id: doctorId, date: date);
      emit(
        FetchTimelineState(
            blocState: BlocState.Successed,
            timeline: timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } on DioException catch (e) {
      emit(
        FetchTimelineState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchTimelineState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> getDasboard() async {
    emit(
      GetDasboardState(
        blocState: BlocState.Pending,
        timeline: state.timeline,
        consultations: state.consultations,
        feedbacks: state.feedbacks,
      ),
    );
    try {
      DoctorDasboardResponse dashboard =
          await _consultationRepository.getDasboard();
      emit(
        GetDasboardState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            dashboard: dashboard),
      );
    } on DioException catch (e) {
      emit(
        GetDasboardState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        GetDasboardState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> cancelConsultation({required String consultationId}) async {
    emit(
      CancelConsultationState(
          blocState: BlocState.Pending,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      await _consultationRepository.cancelConsultation(
          consultationId: consultationId);

      List<ConsultationResponse> coming =
          List<ConsultationResponse>.from(state.consultations?.coming ?? []);
      coming.removeWhere((element) => element.id == consultationId);

      emit(
        CancelConsultationState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: AllConsultationResponse(
                coming: coming,
                finish: state.consultations?.finish ?? [],
                cancel: state.consultations?.cancel ?? []),
            feedbacks: state.feedbacks),
      );
    } on DioException catch (e) {
      emit(
        CancelConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchTimelineState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> storeNotis(
      AllConsultationResponse allConsultationResponse) async {
    List<ConsultationNotificationModel> notis =
        await ConsultationNotificationProvider().selectAll();
    for (var e in allConsultationResponse.coming) {
      if (notis.where((element) => element.id == e.id).isEmpty &&
          e.status == "confirmed") {
        if (e.id != null) {
          DateTime? date = convertStringToDateTime(e.date);
          if (date != null) {
            List<int> numbers = e.expectedTime!.split('-').map((String number) {
              return int.tryParse(number) ??
                  0; // Sử dụng int.tryParse() để tránh lỗi nếu có ký tự không phải số
            }).toList();

            List<int> time = convertIntToTime(numbers.first)
                .split(":")
                .map((e) => int.tryParse(e) ?? 0)
                .toList();
            DateTime expectedTime = DateTime(
                date.year, date.month, date.day, time.first, time.last);

            ConsultationNotificationProvider().insert(
              ConsultationNotificationModel(
                id: e.id!,
                time: expectedTime.toString(),
                doctorName: e.doctor?.fullName,
                symptom: e.symptoms,
                medicalHistory: e.medicalHistory,
                payload: mainScreenPatientName,
              ),
            );
            PushNotificationManager().showScheduleNotification(
                RemoteMessage(
                  id: e.id!,
                  channelId: "healthline",
                  channelName: "healthline",
                  channelDescription: "healthline",
                  notification: ReceivedNotification(
                    // ignore: use_build_context_synchronously
                    title: translate(navigatorKey!.currentState!.context,
                        'you_have_an_upcoming_appointment'),
                    body:
                        "${e.doctor?.fullName ?? '\n'}${e.symptoms ?? '\n'}${e.medicalHistory ?? ''}",
                  ),
                ),
                expectedTime.subtract(const Duration(minutes: 15)));
          }
        }
      }
    }
  }

  Future<void> fetchConsultation() async {
    emit(
      FetchConsultationState(
          blocState: BlocState.Pending,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      AllConsultationResponse? consultations;
      if (AppController().authState == AuthState.PatientAuthorized) {
        consultations =
            await _consultationRepository.fetchPatientConsultation();
      }
      if (AppController().authState == AuthState.DoctorAuthorized) {
        consultations = await _consultationRepository.fetchDoctorConsultation();
      }
      emit(
        FetchConsultationState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: consultations,
            feedbacks: state.feedbacks),
      );
      if (consultations != null) {
        storeNotis(consultations);
      }
    } on DioException catch (e) {
      emit(
        FetchConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> fetchDetailDoctorConsultation(
      {required String consultationId}) async {
    emit(
      FetchDetatilDoctorConsultationState(
          blocState: BlocState.Pending,
          timeline: state.timeline,
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      ConsultationResponse? consultation = await _consultationRepository
          .fetchDetailDoctorConsultation(consultationId: consultationId);

      emit(
        FetchDetatilDoctorConsultationState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            detailDoctorConsultation: consultation),
      );
    } on DioException catch (e) {
      emit(
        FetchDetatilDoctorConsultationState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchDetatilDoctorConsultationState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            error: "cant_load_data",
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> createConsultation(
      {required ConsultationRequest consultation}) async {
    emit(
      CreateConsultationState(
          blocState: BlocState.Pending,
          timeline: state.timeline,
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      int? code = await _consultationRepository.createConsultation(
          request: consultation);
      if (code == 200 || code == 201) {
        emit(
          CreateConsultationState(
              blocState: BlocState.Successed,
              timeline: state.timeline,
              consultations: state.consultations,
              feedbacks: state.feedbacks),
        );
      } else {
        throw 'failure';
      }
    } on DioException catch (e) {
      emit(
        CreateConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        CreateConsultationState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> createFeedback(
      {required String feedbackId,
      required int rating,
      required String feedback}) async {
    emit(
      CreateFeebackState(
          blocState: BlocState.Pending,
          timeline: state.timeline,
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      int? code = await _consultationRepository.createFeeback(
          request: FeedbackRequest(
              feedback: feedback, rated: rating, feedbackId: feedbackId));
      if (code == 200 || code == 201) {
        emit(
          CreateFeebackState(
              blocState: BlocState.Successed,
              timeline: state.timeline,
              consultations: state.consultations,
              feedbacks: state.feedbacks),
        );
      } else {
        throw 'failure';
      }
    } on DioException catch (e) {
      emit(
        CreateFeebackState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        CreateFeebackState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> fetchFeedbackDoctor({required String doctorId}) async {
    emit(
      FetchFeedbackDoctorState(
          blocState: BlocState.Pending,
          timeline: state.timeline,
          consultations: state.consultations,
          feedbacks: []),
    );
    try {
      List<FeedbackResponse> feedbacks =
          await _consultationRepository.fetchFeedbackDoctor(doctorId: doctorId);
      emit(
        FetchFeedbackDoctorState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: feedbacks),
      );
    } on DioException catch (e) {
      emit(
        FetchFeedbackDoctorState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchFeedbackDoctorState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> fetchFeedbackUser({required String userId}) async {
    emit(
      FetchFeedbackUserState(
          blocState: BlocState.Pending,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      List<FeedbackResponse> feedbacks =
          await _consultationRepository.fetchFeedbackUser(userId: userId);
      emit(
        FetchFeedbackUserState(
            blocState: BlocState.Successed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: feedbacks),
      );
    } on DioException catch (e) {
      emit(
        FetchFeedbackUserState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchFeedbackUserState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> denyConsultation({required String consultationId}) async {
    emit(
      DenyConsultationState(
          blocState: BlocState.Pending,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      int? code = await _consultationRepository.deleteConsultation(
          consultationId: consultationId);
      if (code == 200 || code == 201) {
        emit(
          DenyConsultationState(
              blocState: BlocState.Successed,
              timeline: [],
              consultations: state.consultations,
              feedbacks: state.feedbacks),
        );
      }
    } on DioException catch (e) {
      emit(
        DenyConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        DenyConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> confirmConsultation({required String consultationId}) async {
    emit(
      ConfirmConsultationState(
          blocState: BlocState.Pending,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      int? code = await _consultationRepository.confirmConsultation(
          consultationId: consultationId);
      if (code == 200 || code == 201) {
        emit(
          ConfirmConsultationState(
              blocState: BlocState.Successed,
              timeline: [],
              consultations: state.consultations,
              feedbacks: state.feedbacks),
        );
      }
    } on DioException catch (e) {
      emit(
        ConfirmConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        ConfirmConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> createPrescription(
      {required PrescriptionResponse prescriptionResponse,
      required String consultationId}) async {
    emit(
      CreatePrescriptionState(
          blocState: BlocState.Pending,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      await _consultationRepository.createPrescription(
          prescriptionResponse: prescriptionResponse,
          consultationId: consultationId);
      emit(
        CreatePrescriptionState(
            blocState: BlocState.Successed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } on DioException catch (e) {
      emit(
        CreatePrescriptionState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'] ?? e.response,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        CreatePrescriptionState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> fetchHistoryPatientConsultation(
      {required String medicalId}) async {
    emit(
      FetchHistoryPatientConsultationState(
          blocState: BlocState.Pending,
          timeline: [],
          consultations: state.consultations,
          feedbacks: state.feedbacks,
          historyConsultation: []),
    );
    try {
      List<ConsultationResponse> hisConsultation = await _consultationRepository
          .fetchHistoryPatientConsultation(medicalId: medicalId);
      emit(
        FetchHistoryPatientConsultationState(
            blocState: BlocState.Successed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            historyConsultation: hisConsultation),
      );
    } on DioException catch (e) {
      emit(
        FetchHistoryPatientConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'] ?? e.response,
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            historyConsultation: []),
      );
    } catch (e) {
      emit(
        FetchHistoryPatientConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            consultations: state.consultations,
            feedbacks: state.feedbacks,
            historyConsultation: []),
      );
    }
  }

  // Future<void> updateRequest() async {
  //   emit(
  //     ConsultationInitial(
  //         blocState: BlocState.Successed,
  //         timeline: state.timeline,
  //         consultations: state.consultations,
  //         feedbacks: state.feedbacks),
  //   );
  // }
}
