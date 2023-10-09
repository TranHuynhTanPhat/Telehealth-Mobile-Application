import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/schedule_response.dart';
import 'package:healthline/repository/doctor_repository.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'schedule_state.dart';

class ScheduleCubit extends HydratedCubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleInitial(schedules: <ScheduleResponse>[]));
  final DoctorRepository _doctorRepository = DoctorRepository();
  @override
  void onChange(Change<ScheduleState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> fetchSchedule() async {
    try {
      emit(FetchScheduleLoading(schedules: state.schedules));
      List<ScheduleResponse> schedules =
          await _doctorRepository.fetchSchedule();
      emit(FetchScheduleSuccessfully(schedules: schedules));
    } catch (e) {
      DioException er = e as DioException;
      emit(
        FetchScheduleError(
          schedules: state.schedules,
          message: er.response!.data['message'].toString(),
        ),
      );
    }
  }

  @override
  ScheduleState? fromJson(Map<String, dynamic> json) {
    return ScheduleState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ScheduleState state) {
    return state.toMap();
  }
}
