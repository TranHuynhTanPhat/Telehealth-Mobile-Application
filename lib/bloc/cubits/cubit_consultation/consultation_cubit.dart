// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/requests/feedback_request.dart';
import 'package:healthline/data/api/models/responses/all_consultation_response.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/data/api/models/responses/doctor_dasboard_response.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/repositories/consultation_repository.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';

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
    logPrint(change);
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
      if (AppController.instance.authState == AuthState.PatientAuthorized) {
        consultations =
            await _consultationRepository.fetchPatientConsultation();
      }
      if (AppController.instance.authState == AuthState.DoctorAuthorized) {
        consultations = await _consultationRepository.fetchDoctorConsultation();
      }
      emit(
        FetchConsultationState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            consultations: consultations,
            feedbacks: state.feedbacks),
      );
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

  Future<void> fetchDetatilDoctorConsultation(
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
        FetchConsultationState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            error: e.response!.data['message'].toString(),
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchConsultationState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
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
            feedbacks: []),
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
