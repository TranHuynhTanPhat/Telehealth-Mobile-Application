// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/responses/all_consultation_response.dart';
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
        ),
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
        ),
      );
    } catch (e) {
      emit(
        FetchTimelineState(
          blocState: BlocState.Failed,
          timeline: [],
          request: state.request,
          doctorName: state.doctorName,
          patientName: state.patientName,
        ),
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
        consultations: AllConsultationResponse(
          coming: [],
          finish: [],
          cancel: [],
        ),
      ),
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
            consultations: consultations),
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
          consultations: AllConsultationResponse(
            coming: [],
            finish: [],
            cancel: [],
          ),
        ),
      );
    } catch (e) {
      emit(
        FetchConsultationState(
          blocState: BlocState.Failed,
          timeline: [],
          request: state.request,
          doctorName: state.doctorName,
          patientName: state.patientName,
          consultations: AllConsultationResponse(
            coming: [],
            finish: [],
            cancel: [],
          ),
        ),
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
          ),
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
              ),
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
            ),
      );
    } catch (e) {
      emit(
        CreateConsultationState(
            blocState: BlocState.Failed,
            timeline: state.timeline,
            request: state.request,
            doctorName: state.doctorName,
            patientName: state.patientName,
            ),
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
          ),
    );
  }
}
