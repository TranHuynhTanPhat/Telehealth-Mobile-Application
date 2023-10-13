import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/repository/patient_repository.dart';
import 'package:healthline/res/enum.dart';
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

  Future<void> fetchStats(String medicalId) async {
    emit(HealthStatLoading(stats: state.stats));
    try {
      List<HealthStatResponse> stats =
          await _patientRepository.fetchStats(medicalId);
      emit(HealthStatInitial(stats: stats));
    } on DioException catch (e) {
      emit(
        HealthStatError(
          stats: state.stats,
          message: e.message.toString(),
        ),
      );
    } catch (e) {
      print(e);
      print('checkk');
      emit(
        HealthStatError(
          stats: state.stats,
          message: 'failure',
        ),
      );
    }
  }

  Future<void> updateStats(String medicalId, String bloodGroup, int heartRate,
      int height, int weight, int headCircumference, int temperature) async {
    emit(UpdateStatLoading(stats: state.stats));
    try {
      int? blG;
      int? hR;
      int? h;
      int? w;
      int? t;
      int? hc;
      blG = bloodGroup == 'A'
          ? 0
          : bloodGroup == 'B'
              ? 1
              : bloodGroup == 'O'
                  ? 2
                  : bloodGroup == 'AB'
                      ? 3
                      : null;
      hR = heartRate ==
              state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Heart_rate,
                      orElse: () => HealthStatResponse())
                  .value
          ? null
          : heartRate;
      h = height ==
              state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Height,
                      orElse: () => HealthStatResponse())
                  .value
          ? null
          : height;
      w = weight ==
              state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Weight,
                      orElse: () => HealthStatResponse())
                  .value
          ? null
          : weight;
      t = temperature ==
              state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Temperature,
                      orElse: () => HealthStatResponse())
                  .value
          ? null
          : temperature;
      hc = headCircumference ==
              state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Temperature,
                      orElse: () => HealthStatResponse())
                  .value
          ? null
          : headCircumference;
      if (blG == null &&
          hR == null &&
          h == null &&
          w == null &&
          hc == null &&
          t == null) {
        emit(UpdateStatSuccessfully(stats: state.stats));
      } else {
        await _patientRepository.updateStats(medicalId, blG, hR, h, w, hc, t);
      }
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
