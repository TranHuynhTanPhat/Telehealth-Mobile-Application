import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:open_document/open_document.dart';
import 'package:open_document/open_document_exception.dart';

import 'package:healthline/data/api/models/responses/patient_record_response.dart';
import 'package:healthline/repositories/file_repository.dart';
import 'package:healthline/repositories/patient_repository.dart';
import 'package:healthline/utils/log_data.dart';

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

  Future<void> addPatientRecord(
      String path, String? folderName, int size) async {
    emit(AddPatientRecordLoading(
        records: state.records, medicalId: state.medicalId));
    try {
      await _fileRepository.uploadRecordPatient(
          medicalId: state.medicalId!, path: path, folder: folderName ?? '');
      // String publicId = response.publicId!;

      // await _patientRepository.addPatientRecord(state.medicalId!, publicId,
      //     folderName ?? 'default', getFileSizeString(bytes: size));
      emit(AddPatientRecordLoaded(
          records: state.records, medicalId: state.medicalId));
    } on DioException catch (e) {
      emit(AddPatientRecordError(
          records: state.records,
          medicalId: state.medicalId,
          message: e.response!.data['message'].toString()));
    } catch (e) {
      emit(AddPatientRecordError(
          records: state.records,
          medicalId: state.medicalId,
          message: e.toString()));
    }
  }

  Future<void> deletePatientRecord(String patientRecordId) async {
    emit(DeletePatientRecordLoading(
        records: state.records, medicalId: state.medicalId));
    try {
      PatientRecordResponse record =
          state.records.firstWhere((element) => element.id == patientRecordId);
      String publicId = record.record!.split('/').last;
      // String folderName = record.record!
      //     .replaceAll('healthline/users/${state.medicalId}/records/', '')
      //     .split('/')
      //     .first;
      // await _fileRepository.deleteRecordPatient(medicalId: state.medicalId!,
      //     publicId: publicId, folder: folderName);
      await _patientRepository.deletePatientRecord([patientRecordId]);

      final path = await OpenDocument.getPathDocument();

      String filePath = "$path/$publicId";

      final isCheck = await OpenDocument.checkDocument(filePath: filePath);

      if (isCheck) {
        File(filePath).deleteSync();
      }

      List<PatientRecordResponse> response = List.from(state.records);
      response.removeWhere(
        (element) => element.id == patientRecordId,
      );
      emit(DeletePatientRecordLoaded(
          records: response, medicalId: state.medicalId));
    } on DioException catch (e) {
      logPrint(e);
      emit(DeletePatientRecordError(
          records: state.records,
          medicalId: state.medicalId,
          message: e.response!.data['message'].toString()));
    } catch (e) {
      logPrint(e);
      emit(DeletePatientRecordError(
          records: state.records,
          medicalId: state.medicalId,
          message: e.toString()));
    }
  }

  Future<void> deleteFolderPatient(String folderName) async {
    emit(DeletePatientRecordLoading(
        records: state.records, medicalId: state.medicalId));
    try {
      await _fileRepository.deleteFolderPatient(
          medicalId: state.medicalId!, folderName: folderName);

      final path = await OpenDocument.getPathDocument();

      List<PatientRecordResponse> response = List.from(state.records);
      response
          .where((element) => element.folder == folderName)
          .forEach((element) async {
        String publicId = element.record!.split('/').last;
        String filePath = "$path/$publicId";
        final isCheck = await OpenDocument.checkDocument(filePath: filePath);
        // _patientRepository.deletePatientFolderRecord([element.id!]);

        if (isCheck) {
          File(filePath).deleteSync();
        }
      });
      response.removeWhere(
        (element) => element.folder == folderName,
      );
      emit(DeletePatientRecordLoaded(
          records: response, medicalId: state.medicalId));
    } on DioException catch (e) {
      emit(DeletePatientRecordError(
          records: state.records,
          medicalId: state.medicalId,
          message: e.response!.data['message'].toString()));
    } catch (e) {
      emit(DeletePatientRecordError(
          records: state.records,
          medicalId: state.medicalId,
          message: e.toString()));
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
          message: e.response!.data['message'].toString(),
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
