import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/injected_vaccination_response.dart';
import 'package:healthline/data/api/models/responses/vaccination_response.dart';
import 'package:healthline/repositories/vaccination_repository.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'vaccine_record_state.dart';

class VaccineRecordCubit extends Cubit<VaccineRecordState> {
  VaccineRecordCubit()
      : super(VaccineRecordInitial(
            vaccinations: [],
            injectedVaccinations: [],
            age: 0,
            medicalRecord: '',
            blocState: BlocState.Successed));
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
          medicalRecord: medicalRecord,
          blocState: BlocState.Successed),
    );
  }

  /// Fetch vaccinations
  Future<void> fetchVaccination() async {
    emit(FetchVaccinationState(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        medicalRecord: state.medicalRecord,
        blocState: BlocState.Pending));
    try {
      List<VaccinationResponse> vaccinations =
          await _vaccinationRepository.fetchVaccination();

      emit(
        FetchVaccinationState(
            vaccinations: vaccinations,
            injectedVaccinations: state.injectedVaccinations,
            age: state.age,
            medicalRecord: state.medicalRecord,
            blocState: BlocState.Successed),
      );
    } on DioException catch (e) {
      emit(
        FetchVaccinationState(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          error: e.response!.data['message'].toString(),
          blocState: BlocState.Failed,
        ),
      );
    } catch (e) {
      emit(
        FetchVaccinationState(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          error: e.toString(),
          blocState: BlocState.Failed,
        ),
      );
    }
  }

  /// Fetch vaccination records
  Future<void> fetchVaccinationRecord(String medicalRecord) async {
    emit(
      FetchVaccinationRecordState(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        medicalRecord: state.medicalRecord,
        blocState: BlocState.Pending,
      ),
    );
    try {
      List<InjectedVaccinationResponse> injectedVaccinations =
          await _vaccinationRepository.fetchInjectedVaccination(medicalRecord);
      emit(
        FetchVaccinationRecordState(
            vaccinations: state.vaccinations,
            injectedVaccinations: injectedVaccinations,
            age: state.age,
            medicalRecord: state.medicalRecord,
            blocState: BlocState.Successed),
      );
    } on DioException catch (e) {
      emit(
        FetchVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          error: e.response!.data['message'].toString(),
          blocState: BlocState.Failed,
        ),
      );
    } catch (e) {
      emit(
        FetchVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          error: e.toString(),
          blocState: BlocState.Failed,
        ),
      );
    }
  }

  /// Create vaccination records
  Future<void> createVaccinationRecordState(
      String vaccineId, int doseNumber, String date) async {
    emit(
      CreateVaccinationRecordState(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        medicalRecord: state.medicalRecord,
        blocState: BlocState.Pending,
      ),
    );
    try {
      InjectedVaccinationResponse vaccination =
          await _vaccinationRepository.createInjectedVaccination(
              state.medicalRecord, vaccineId, doseNumber, date);

      emit(
        CreateVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: List.from(state.injectedVaccinations)
            ..add(vaccination),
          age: state.age,
          medicalRecord: state.medicalRecord,
          blocState: BlocState.Successed,
        ),
      );
    } on DioException catch (e) {
      emit(CreateVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          error: e.response!.data['message'].toString(),
          blocState: BlocState.Failed));
    } catch (e) {
      emit(CreateVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          error: e.toString(),
          blocState: BlocState.Failed));
    }
  }

  /// Update vaccination records
  Future<void> updateVaccinationRecordState(
      String recordId, int doseNumber, String date) async {
    emit(
      UpdateVaccinationRecordState(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        medicalRecord: state.medicalRecord,
        blocState: BlocState.Pending,
      ),
    );
    try {
      InjectedVaccinationResponse vaccination = await _vaccinationRepository
          .updateInjectedVaccination(recordId, doseNumber, date);

      emit(
        UpdateVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: List.from(state.injectedVaccinations)
            ..removeWhere((element) => element.id == vaccination.id),
          age: state.age,
          medicalRecord: state.medicalRecord,
          blocState: BlocState.Successed,
        ),
      );
    } on DioException catch (e) {
      emit(UpdateVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          error: e.response!.data['message'].toString(),
          blocState: BlocState.Failed));
    } catch (e) {
      emit(UpdateVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          error: e.toString(),
          blocState: BlocState.Failed));
    }
  }

  /// Delete vaccination records
  Future<void> deleteVaccinationRecordState(String recordId) async {
    emit(
      DeleteVaccinationRecordState(
        vaccinations: state.vaccinations,
        injectedVaccinations: state.injectedVaccinations,
        age: state.age,
        medicalRecord: state.medicalRecord, blocState: BlocState.Pending,
      ),
    );
    try {
      await _vaccinationRepository.deleteInjectedVaccination(recordId);

      emit(
        DeleteVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: List.from(state.injectedVaccinations)
            ..removeWhere((element) => element.id == recordId),
          age: state.age,
          medicalRecord: state.medicalRecord, blocState: BlocState.Successed,
        ),
      );
    } on DioException catch (e) {
      emit(DeleteVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          error: e.response!.data['message'].toString(), blocState: BlocState.Failed));
    } catch (e) {
      emit(DeleteVaccinationRecordState(
          vaccinations: state.vaccinations,
          injectedVaccinations: state.injectedVaccinations,
          age: state.age,
          medicalRecord: state.medicalRecord,
          error: e.toString(), blocState: BlocState.Failed));
    }
  }
}
