import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/injected_vaccination_response.dart';
import 'package:healthline/data/api/models/responses/vaccination_response.dart';
import 'package:healthline/repository/vaccination_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'vaccine_record_state.dart';

class VaccineRecordCubit extends HydratedCubit<VaccineRecordState> {
  VaccineRecordCubit()
      : super(VaccineRecordInitial(
            vaccinations: [], injectedVaccinations: [], age: 0, recordId: ''));
  final VaccinationRepository _vaccinationRepository = VaccinationRepository();

  void updateAge(int age, String recordId) {
    emit(
      VaccineRecordInitial(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: age,
          recordId: recordId),
    );
  }

  void updateInjectedVaccinations(
      InjectedVaccinationResponse injectedVaccinationResponse) {
    emit(
      VaccineRecordInitial(
          vaccinations: state.vaccinations,
          injectedVaccinations: List.from(state.injectedVaccinations)
            ..add(injectedVaccinationResponse),
          age: state.age,
          recordId: state.recordId),
    );
  }

  Future<void> fetchVaccination() async {
    emit(FetchVaccinationLoading(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        recordId: state.recordId));
    try {
      List<VaccinationResponse> vaccinations =
          await _vaccinationRepository.fetchVaccination();

      emit(
        FetchVaccinationLoaded(
            vaccinations: vaccinations,
            injectedVaccinations: state.injectedVaccinations,
            age: state.age,
            recordId: state.recordId),
      );
    } catch (e) {
      DioException er = e as DioException;
      emit(
        FetchVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          recordId: state.recordId,
          message: er.response!.data['message'].toString(),
        ),
      );
    }
  }

  Future<void> fetchInjectedVaccination(String recordId) async {
    emit(
      FetchInjectedVaccinationLoading(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        recordId: state.recordId,
      ),
    );
    try {
      List<InjectedVaccinationResponse> injectedVaccinations =
          await _vaccinationRepository.fetchInjectedVaccination(recordId);

      emit(
        FetchInjectedVaccinationLoaded(
            vaccinations: state.vaccinations,
            injectedVaccinations: injectedVaccinations,
            age: state.age,
            recordId: state.recordId),
      );
    } catch (e) {
      DioException er = e as DioException;
      emit(
        FetchInjectedVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          recordId: state.recordId,
          message: er.response!.data['message'].toString(),
        ),
      );
    }
  }

  Future<void> createInjectedVaccination(
      String vaccineId, int doseNumber, String date) async {
    emit(
      CreateInjectedVaccinationLoading(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        recordId: state.recordId,
      ),
    );
    try {
      InjectedVaccinationResponse vaccination =
          await _vaccinationRepository.createInjectedVaccination(
              state.recordId, vaccineId, doseNumber, date);

      emit(
        CreateInjectedVaccinationLoaded(
            vaccinations: state.vaccinations,
            injectedVaccinations: state.injectedVaccinations,
            age: state.age,
            recordId: state.recordId,
            injectedVaccine: vaccination),
      );
    } catch (e) {
      DioException er = e as DioException;
      emit(CreateInjectedVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          recordId: state.recordId,
          message: er.response!.data['message'].toString()));
    }
  }

  @override
  VaccineRecordState? fromJson(Map<String, dynamic> json) {
    return VaccineRecordState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(VaccineRecordState state) {
    return state.toMap();
  }
}
