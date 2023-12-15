// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/repository/consultation_repository.dart';
import 'package:healthline/res/enum.dart';

part 'consultation_state.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  ConsultationCubit()
      : super(
          ConsultationInitial(
              blocState: BlocState.Successed,
              timeline: [],
              request: ConsultationRequest()),
        );
  final ConsultationRepository _consultationRepository =
      ConsultationRepository();
  Future<void> fetchTimeline(
      {required String doctorId, required String date}) async {
    emit(
      FetchTimelineState(
        blocState: BlocState.Pending,
        timeline: [],
        request: state.request,
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
        ),
      );
    } on DioException catch (e) {
      emit(
        FetchTimelineState(
          blocState: BlocState.Failed,
          timeline: [],
          error: e.response!.data['message'].toString(),
          request: state.request,
        ),
      );
    } catch (e) {
      emit(
        FetchTimelineState(
          blocState: BlocState.Failed,
          timeline: [],
          request: state.request,
        ),
      );
    }
  }
  Future<void> updateExpectTime(
      {required String time}) async {

    emit(ConsultationInitial(blocState: BlocState.Successed, timeline: state.timeline, request: state.request.copyWith(expectedTime: time)));
  }
}
