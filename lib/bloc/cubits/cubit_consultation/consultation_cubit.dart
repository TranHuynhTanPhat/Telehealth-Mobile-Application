// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/repository/consultation_repository.dart';
import 'package:healthline/res/enum.dart';

part 'consultation_state.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  ConsultationCubit()
      : super(
          ConsultationInitial(
            blocState: BlocState.Successed, timeline: [],
          ),
        );
  final ConsultationRepository _consultationRepository =
      ConsultationRepository();
  Future<void> fetchTimeline(
      {required String doctorId, required String date}) async {
    emit(
      FetchTimelineState(
        blocState: BlocState.Pending,
        timeline: [],
      ),
    );
    try {
      List<int> timeline =
          await _consultationRepository.fetchTimeline(id: doctorId, date: date);
      emit(
        FetchTimelineState(
          blocState: BlocState.Successed,
          timeline: timeline,
        ),
      );
    } on DioException catch (e) {
      emit(
        FetchTimelineState(
          blocState: BlocState.Failed,
          timeline: [],
          error: e.response!.data['message'].toString(),
        ),
      );
    } catch (e) {
      emit(
        FetchTimelineState(
          blocState: BlocState.Failed,
          timeline: [],
        ),
      );
    }
  }
}
