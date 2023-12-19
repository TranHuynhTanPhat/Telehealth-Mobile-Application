// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/requests/feedback_request.dart';
import 'package:healthline/data/api/models/responses/all_consultation_response.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/repository/consultation_repository.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';

part 'consultation_state.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  ConsultationCubit()
      : super(
          ConsultationInitial(
            blocState: BlocState.Successed,
            timeline: [],
            request: ConsultationRequest(),
            doctorName: null,
            patientName: null,
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
        request: state.request,
        doctorName: state.doctorName,
        patientName: state.patientName,
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
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } on DioException catch (e) {
      emit(
        FetchTimelineState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchTimelineState(
            blocState: BlocState.Failed,
            timeline: [],
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
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
          request: state.request,
          doctorName: state.doctorName,
          patientName: state.patientName,
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
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
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
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchTimelineState(
            blocState: BlocState.Failed,
            timeline: [],
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
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
          request: ConsultationRequest(),
          doctorName: null,
          patientName: null,
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      AllConsultationResponse consultations =
          await _consultationRepository.fetchPatientConsultation();
      emit(
        FetchConsultationState(
            blocState: BlocState.Successed,
            timeline: state.timeline,
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: consultations,
            feedbacks: state.feedbacks),
      );
    } on DioException catch (e) {
      emit(
        FetchConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> createConsultation() async {
    emit(
      CreateConsultationState(
          blocState: BlocState.Pending,
          timeline: state.timeline,
          request: state.request,
          doctorName: state.doctorName,
          patientName: state.patientName,
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      int? code = await _consultationRepository.createConsultation(
          request: state.request);
      if (code == 200 || code == 201) {
        emit(
          CreateConsultationState(
              blocState: BlocState.Successed,
              timeline: state.timeline,
              request: state.request,
              doctorName: state.doctorName,
              patientName: state.patientName,
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
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        CreateConsultationState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
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
          request: state.request,
          doctorName: state.doctorName,
          patientName: state.patientName,
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
              request: state.request,
              doctorName: state.doctorName,
              patientName: state.patientName,
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
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        CreateFeebackState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
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
          request: state.request,
          doctorName: state.doctorName,
          patientName: state.patientName,
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
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: feedbacks),
      );
    } on DioException catch (e) {
      emit(
        FetchFeedbackDoctorState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: []),
      );
    } catch (e) {
      emit(
        FetchFeedbackDoctorState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
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
          request: state.request,
          doctorName: state.doctorName,
          patientName: state.patientName,
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
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: feedbacks),
      );
    } on DioException catch (e) {
      emit(
        FetchFeedbackUserState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        FetchFeedbackUserState(
            blocState: BlocState.Failed,
            timeline: [],
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> deleteConsultation({required String consultationId}) async {
    emit(
      DeleteConsultationState(
          blocState: BlocState.Pending,
          timeline: [],
          request: state.request,
          doctorName: state.doctorName,
          patientName: state.patientName,
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
    try {
      int? code = await _consultationRepository.deleteConsultation(
          consultationId: consultationId);
      if (code == 200 || code == 201) {
        emit(
          DeleteConsultationState(
              blocState: BlocState.Successed,
              timeline: [],
              request: state.request,
              doctorName: state.doctorName,
              patientName: state.patientName,
              consultations: state.consultations,
              feedbacks: state.feedbacks),
        );
      }
    } on DioException catch (e) {
      emit(
        DeleteConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            error: e.response!.data['message'].toString(),
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        DeleteConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
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
          request: state.request,
          doctorName: state.doctorName,
          patientName: state.patientName,
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
              request: state.request,
              doctorName: state.doctorName,
              patientName: state.patientName,
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
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    } catch (e) {
      emit(
        ConfirmConsultationState(
            blocState: BlocState.Failed,
            timeline: [],
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            consultations: state.consultations,
            feedbacks: state.feedbacks),
      );
    }
  }

  Future<void> updateRequest(
      {String? doctorId,
      String? medicalRecord,
      String? date,
      String? expectedTime,
      int? price,
      String? discountCode,
      String? patientName,
      String? doctorName}) async {
    emit(
      ConsultationInitial(
          blocState: BlocState.Successed,
          timeline: state.timeline,
          request: state.request.copyWith(
              expectedTime: expectedTime,
              doctorId: doctorId,
              medicalRecord: medicalRecord,
              price: price,
              discountCode: discountCode,
              date: date),
          doctorName: doctorName ?? state.doctorName,
          patientName: patientName ?? state.patientName,
          consultations: state.consultations,
          feedbacks: state.feedbacks),
    );
  }
}
