import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/schedule_response.dart';
import 'package:healthline/repository/doctor_repository.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'doctor_schedule_state.dart';

class DoctorScheduleCubit extends HydratedCubit<DoctorScheduleState> {
  DoctorScheduleCubit()
      : super(DoctorScheduleInitial(schedules: [], scheduleId: null));
  final DoctorRepository _doctorRepository = DoctorRepository();
  @override
  void onChange(Change<DoctorScheduleState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> updateScheduleId(String? id) async {
    emit(DoctorScheduleInitial(schedules: state.schedules, scheduleId: id));
  }

  Future<void> fetchSchedule() async {
    try {
      emit(FetchScheduleLoading(
          schedules: state.schedules, scheduleId: state.scheduleId));
      List<ScheduleResponse> schedules =
          await _doctorRepository.fetchSchedule();
      await updateScheduleId(schedules.first.id);
      emit(FetchScheduleSuccessfully(
          schedules: schedules, scheduleId: state.scheduleId));
    } on DioException catch (e) {
      logPrint("ERROR DIO: ${e.message.toString()}");
      emit(
        FetchScheduleError(
          schedules: state.schedules,
          message: e.response!.data['message'].toString(),
          scheduleId: state.scheduleId,
        ),
      );
    } catch (e) {
      logPrint("ERROR FETCH SCHEDULE: ${e.toString()}");
      emit(
        FetchScheduleError(
          schedules: state.schedules,
          message: e.toString(),
          scheduleId: state.scheduleId,
        ),
      );
    }
  }

  Future<void> getCron() async {
    try {
      emit(CronScheduleLoading(
          schedules: state.schedules, scheduleId: state.scheduleId));

      await _doctorRepository.getScheduleCron();
      emit(CronScheduleSuccessfully(
          schedules: state.schedules, scheduleId: state.scheduleId));
    } on DioException catch (e) {
      logPrint("ERROR DIO: ${e.message.toString()}");
      emit(
        CronScheduleError(
          schedules: state.schedules,
          message: e.response!.data['message'].toString(),
          scheduleId: state.scheduleId,
        ),
      );
    } catch (e) {
      logPrint("ERROR FETCH SCHEDULE: ${e.toString()}");
      emit(
        CronScheduleError(
          schedules: state.schedules,
          message: e.toString(),
          scheduleId: state.scheduleId,
        ),
      );
    }
  }

  Future<void> updateFixedSchedule(List<List<int>> schedules) async {
    try {
      emit(FixedScheduleUpdating(
          schedules: state.schedules, scheduleId: state.scheduleId));

      await _doctorRepository.updateFixedSchedule(schedules);
      emit(FixedScheduleUpdateSuccessfully(
          schedules: state.schedules, scheduleId: state.scheduleId));
    } on DioException catch (e) {
      logPrint("ERROR DIO: ${e.message.toString()}");
      emit(
        FixedScheduleUpdateError(
          schedules: state.schedules,
          message: e.response!.data['message'].toString(),
          scheduleId: state.scheduleId,
        ),
      );
    } catch (e) {
      logPrint("ERROR FETCH SCHEDULE: ${e.toString()}");
      emit(
        FixedScheduleUpdateError(
          schedules: state.schedules,
          message: e.toString(),
          scheduleId: state.scheduleId,
        ),
      );
    }
  }

  @override
  DoctorScheduleState? fromJson(Map<String, dynamic> json) {
    return DoctorScheduleState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(DoctorScheduleState state) {
    return state.toMap();
  }
}
