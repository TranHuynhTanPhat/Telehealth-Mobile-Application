import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/repository/patient_repository.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'health_stat_state.dart';

class HealthStatCubit extends HydratedCubit<HealthStatState> {
  HealthStatCubit() : super(HealthStatInitial(stats: []));
  final PatientRepository _patientRepository = PatientRepository();
  @override
  void onChange(Change<HealthStatState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> fetchStats(String recordId) async {
    emit(HealthStatLoading(stats: state.stats));
    try {
      List<HealthStatResponse> stats =
          await _patientRepository.fetchStats(recordId);
      emit(HealthStatInitial(stats: stats));
    } catch (e) {
      DioException er = e as DioException;

      emit(
        HealthStatError(
          stats: state.stats,
          message: er.message.toString(),
        ),
      );
    }
  }

  @override
  HealthStatState? fromJson(Map<String, dynamic> json) {
    return HealthStatState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(HealthStatState state) {
    return state.toMap();
  }
}
