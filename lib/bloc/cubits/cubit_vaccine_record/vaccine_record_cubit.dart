import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/injected_vaccination_response.dart';
import 'package:healthline/data/api/models/responses/vaccination_response.dart';
import 'package:healthline/repository/vaccination_repository.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'vaccine_record_state.dart';

class VaccineRecordCubit extends Cubit<VaccineRecordState> {
  VaccineRecordCubit()
      : super(VaccineRecordInitial(
            vaccinations: [],
            injectedVaccinations: [],
            age: 0,
            medicalRecord: ''));
  final VaccinationRepository _vaccinationRepository = VaccinationRepository();
  @override
  void onChange(Change<VaccineRecordState> change) {
    super.onChange(change);
    logPrint(change);
  }

  void updateAge(int age, String medicalRecord) {
    emit(
      VaccineRecordInitial(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: age,
          medicalRecord: medicalRecord),
    );
  }

  Future<void> fetchVaccination() async {
    emit(FetchVaccinationLoading(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        medicalRecord: state.medicalRecord));
    try {
      List<VaccinationResponse> vaccinations =
          await _vaccinationRepository.fetchVaccination();

      emit(
        FetchVaccinationLoaded(
            vaccinations: vaccinations,
            injectedVaccinations: state.injectedVaccinations,
            age: state.age,
            medicalRecord: state.medicalRecord),
      );
    } on DioException catch (e) {
      emit(
        FetchVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          message: e.response!.data['message'].toString(),
        ),
      );
    } catch (e) {
      emit(
        FetchVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchInjectedVaccination(String medicalRecord) async {
    emit(
      FetchInjectedVaccinationLoading(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        medicalRecord: state.medicalRecord,
      ),
    );
    try {
      List<InjectedVaccinationResponse> injectedVaccinations =
          await _vaccinationRepository.fetchInjectedVaccination(medicalRecord);
      emit(
        FetchInjectedVaccinationLoaded(
            vaccinations: state.vaccinations,
            injectedVaccinations: injectedVaccinations,
            age: state.age,
            medicalRecord: state.medicalRecord),
      );
    } on DioException catch (e) {
      emit(
        FetchInjectedVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          message: e.response!.data['message'].toString(),
        ),
      );
    } catch (e) {
      emit(
        FetchInjectedVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          message: e.toString(),
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
        medicalRecord: state.medicalRecord,
      ),
    );
    try {
      InjectedVaccinationResponse vaccination =
          await _vaccinationRepository.createInjectedVaccination(
              state.medicalRecord, vaccineId, doseNumber, date);

      emit(
        CreateInjectedVaccinationLoaded(
          vaccinations: state.vaccinations,
          injectedVaccinations: List.from(state.injectedVaccinations)
            ..add(vaccination),
          age: state.age,
          medicalRecord: state.medicalRecord,
        ),
      );
    } on DioException catch (e) {
      emit(CreateInjectedVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          message: e.response!.data['message'].toString()));
    } catch (e) {
      emit(CreateInjectedVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          message: e.toString()));
    }
  }

  Future<void> updateInjectedVaccination(
      String recordId, int doseNumber, String date) async {
    emit(
      UpdateInjectedVaccinationLoading(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        medicalRecord: state.medicalRecord,
      ),
    );
    try {
      InjectedVaccinationResponse vaccination = await _vaccinationRepository
          .updateInjectedVaccination(recordId, doseNumber, date);

      emit(
        UpdateInjectedVaccinationLoaded(
          vaccinations: state.vaccinations,
          injectedVaccinations: List.from(state.injectedVaccinations)
            ..removeWhere((element) => element.id == vaccination.id),
          age: state.age,
          medicalRecord: state.medicalRecord,
        ),
      );
    } on DioException catch (e) {
      emit(UpdateInjectedVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          message: e.response!.data['message'].toString()));
    } catch (e) {
      emit(UpdateInjectedVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          message: e.toString()));
    }
  }

  Future<void> deleteInjectedVaccination(String recordId) async {
    emit(
      DeleteInjectedVaccinationLoading(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        medicalRecord: state.medicalRecord,
      ),
    );
    try {
      await _vaccinationRepository.deleteInjectedVaccination(recordId);

      emit(
        DeleteInjectedVaccinationLoaded(
          vaccinations: state.vaccinations,
          injectedVaccinations: List.from(state.injectedVaccinations)
            ..removeWhere((element) => element.id == recordId),
          age: state.age,
          medicalRecord: state.medicalRecord,
        ),
      );
    } on DioException catch (e) {
      emit(DeleteInjectedVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          message: e.response!.data['message'].toString()));
    } catch (e) {
      emit(DeleteInjectedVaccinationError(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          message: e.toString()));
    }
  }

  // @override
  // VaccineRecordState? fromJson(Map<String, dynamic> json) {
  //   return VaccineRecordState.fromMap(json);
  // }

  // @override
  // Map<String, dynamic>? toJson(VaccineRecordState state) {
  //   return state.toMap();
  // }
}
