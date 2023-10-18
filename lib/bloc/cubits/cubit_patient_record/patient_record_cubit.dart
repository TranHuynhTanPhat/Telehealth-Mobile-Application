import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/patient_record_response.dart';
import 'package:healthline/repository/file_repository.dart';
import 'package:healthline/repository/patient_repository.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:open_document/open_document.dart';
import 'package:open_document/open_document_exception.dart';

part 'patient_record_state.dart';

class PatientRecordCubit extends Cubit<PatientRecordState> {
  PatientRecordCubit()
      : super(PatientRecordInitial(
          records: [],
          medicalId: null,
        ));
  final PatientRepository _patientRepository = PatientRepository();
  final FileRepository _fileRepository = FileRepository();

  @override
  void onChange(Change<PatientRecordState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> fetchPatientRecord(String medicalId) async {
    emit(FetchPatientRecordLoading(
        records: state.records, medicalId: medicalId));

    try {
      List<PatientRecordResponse> records =
          await _patientRepository.fetchPatientRecord(
        medicalId,
      );
      emit(FetchPatientRecordLoaded(
        records: records,
        medicalId: state.medicalId,
      ));
    } catch (e) {
      emit(FetchPatientRecordError(
          records: state.records, medicalId: state.medicalId));
    }
  }

  Future<void> addPatientRecord(File file) async {
    emit(AddPatientRecordLoading(
        records: state.records, medicalId: state.medicalId));
    try {
      // await _patientRepository.addPatientRecord(state.currentId!, file.path);
      emit(AddPatientRecordLoaded(
          records: state.records, medicalId: state.medicalId));
    } catch (e) {
      emit(AddPatientRecordError(
          records: state.records, medicalId: state.medicalId));
    }
  }

  Future<void> deletePatientRecord(File file) async {
    emit(DeletePatientRecordLoading(
        records: state.records, medicalId: state.medicalId));
    try {
      // await _patientRepository.addPatientRecord(state.currentId!, file.path);
      emit(DeletePatientRecordLoaded(
          records: state.records, medicalId: state.medicalId));
    } catch (e) {
      emit(DeletePatientRecordError(
          records: state.records, medicalId: state.medicalId));
    }
  }

  Future<void> openFile({required String url, required String fileName}) async {
    emit(OpenFileLoading(records: state.records, medicalId: state.medicalId));
    try {
      final path = await OpenDocument.getPathDocument();

      String filePath = "$path/$fileName";

      final isCheck = await OpenDocument.checkDocument(filePath: filePath);
      if (!isCheck) {
        filePath =
            await _fileRepository.downloadFile(filePath: filePath, url: url);
      }

      emit(OpenFileLoaded(
          records: state.records,
          filePath: filePath,
          medicalId: state.medicalId));
    } on DioException catch (e) {
      logPrint("ERROR DIO: ${e.message.toString()}");
      emit(OpenFileError(
          records: state.records,
          message: e.message.toString(),
          url: url,
          medicalId: state.medicalId));
    } on OpenDocumentException catch (e) {
      logPrint("ERROR OPEN DOCUMENT: ${e.errorMessage}");
      emit(
        OpenFileError(
            records: state.records,
            message: e.errorMessage,
            url: url,
            medicalId: state.medicalId),
      );
    } catch (e) {
      logPrint("ERROR OPEN FILE CUBIT: ${e.toString()}");
      emit(
        OpenFileError(
            records: state.records,
            message: e.toString(),
            url: url,
            medicalId: state.medicalId),
      );
    }
  }
}
