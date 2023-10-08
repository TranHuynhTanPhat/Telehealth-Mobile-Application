import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/injected_vaccination_response.dart';
import 'package:healthline/data/api/models/responses/vaccination_response.dart';
import 'package:healthline/data/storage/models/vaccination_model.dart';
import 'package:healthline/repository/vaccination_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'vaccination_state.dart';

class VaccinationCubit extends HydratedCubit<VaccinationState> {
  VaccinationCubit() : super(const VaccinationInitial([], [], [], [], 0));
  final VaccinationRepository _vaccinationRepository = VaccinationRepository();

  Future<void> fetchVaccinationFromStorage() async {
    emit(VaccinationLoading(state.diseaseAdult, state.diseaseChild,
        state.vaccinations, state.injectedVaccination, state.age));
    try {
      List<Disease> diseases = await VaccinationModel().fetchData();
      List<Disease> diseaseAdult =
          diseases.where((disease) => !disease.isChild).toList();
      List<Disease> diseaseChild =
          diseases.where((disease) => disease.isChild).toList();
      emit(
        VaccinationLoaded(diseaseAdult, diseaseChild, state.vaccinations,
            state.injectedVaccination, state.age),
      );
    } catch (e) {
      emit(VaccinationError(state.diseaseAdult, state.diseaseChild,
          state.vaccinations, state.injectedVaccination, state.age,
          message: e.toString()));
    }
  }

  Future<void> fetchVaccination(int age) async {
    emit(VaccinationLoading(state.diseaseAdult, state.diseaseChild,
        state.vaccinations, state.injectedVaccination, state.age));
    try {
      List<VaccinationResponse> vaccinations =
          await _vaccinationRepository.fetchVaccination();

      emit(
        VaccinationLoaded(state.diseaseAdult, state.diseaseChild, vaccinations,
            state.injectedVaccination, age),
      );
    } catch (e) {
      DioException er = e as DioException;
      emit(VaccinationError(state.diseaseAdult, state.diseaseChild,
          state.vaccinations, state.injectedVaccination, state.age,
          message: er.response!.data['message'].toString()));
    }
  }

  Future<void> fetchInjectedVaccination(String recordId) async {
    emit(FetchInjectedVaccinationLoading(state.diseaseAdult, state.diseaseChild,
        state.vaccinations, state.injectedVaccination, state.age));
    try {
      List<InjectedVaccinationResponse> vaccinations =
          await _vaccinationRepository.fetchInjectedVaccination(recordId);

      emit(
        FetchInjectedVaccinationLoaded(state.diseaseAdult, state.diseaseChild,
            state.vaccinations, vaccinations, state.age),
      );
    } catch (e) {
      print(e);
      DioException er = e as DioException;
      emit(FetchInjectedVaccinationError(state.diseaseAdult, state.diseaseChild,
          state.vaccinations, state.injectedVaccination, state.age,
          message: er.response!.data['message'].toString()));
    }
  }

  @override
  VaccinationState? fromJson(Map<String, dynamic> json) {
    return VaccinationState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(VaccinationState state) {
    return state.toMap();
  }
}
