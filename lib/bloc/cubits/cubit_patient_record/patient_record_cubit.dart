import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:healthline/data/api/models/responses/patient_record_response.dart';
import 'package:healthline/repository/patient_repository.dart';
import 'package:healthline/utils/log_data.dart';

part 'patient_record_state.dart';

class PatientRecordCubit extends Cubit<PatientRecordState> {
  PatientRecordCubit() : super(PatientRecordInitial(records: []));
  final PatientRepository _patientRepository = PatientRepository();

  @override
  void onChange(Change<PatientRecordState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> fetchPatientRecord(String medicalId) async {
    emit(FetchPatientRecordLoading(records: state.records));

    try {
      List<PatientRecordResponse> records =
          await _patientRepository.fetchPatientRecord(
        medicalId,
      );
      emit(FetchPatientRecordLoaded(
        records: records,
      ));
    } catch (e) {
      emit(FetchPatientRecordError(records: state.records));
    }
  }

  Future<void> addPatientRecord(File file) async {
    emit(AddPatientRecordLoading(records: state.records));
    try {
      // await _patientRepository.addPatientRecord(state.currentId!, file.path);
      emit(AddPatientRecordLoaded(records: state.records));
    } catch (e) {
      emit(AddPatientRecordError(records: state.records));
    }
  }

  Future<void> deletePatientRecord(File file) async {
    emit(DeletePatientRecordLoading(records: state.records));
    try {
      // await _patientRepository.addPatientRecord(state.currentId!, file.path);
      emit(DeletePatientRecordLoaded(records: state.records));
    } catch (e) {
      emit(DeletePatientRecordError(records: state.records));
    }
  }
}
