part of 'patient_record_cubit.dart';

class PatientRecordState {
  List<PatientRecordResponse> records;
  String? medicalId;
  PatientRecordState({
    required this.records,
    required this.medicalId,
  });
}

final class PatientRecordInitial extends PatientRecordState {
  PatientRecordInitial({required super.records, required super.medicalId});
}

abstract class FetchPatientRecordState extends PatientRecordState {
  FetchPatientRecordState({required super.records, required super.medicalId});
}

abstract class AddPatientRecordState extends PatientRecordState {
  AddPatientRecordState({required super.records, required super.medicalId});
}

abstract class DeletePatientRecordState extends PatientRecordState {
  DeletePatientRecordState({required super.records, required super.medicalId});
}

final class FetchPatientRecordLoading extends FetchPatientRecordState {
  FetchPatientRecordLoading({required super.records, required super.medicalId});
}

final class FetchPatientRecordLoaded extends FetchPatientRecordState {
  FetchPatientRecordLoaded({required super.records, required super.medicalId});
}

final class FetchPatientRecordError extends FetchPatientRecordState {
  FetchPatientRecordError({required super.records, required super.medicalId});
}

final class DeletePatientRecordLoading extends DeletePatientRecordState {
  DeletePatientRecordLoading(
      {required super.records, required super.medicalId});
}

final class DeletePatientRecordLoaded extends DeletePatientRecordState {
  DeletePatientRecordLoaded({required super.records, required super.medicalId});
}

final class DeletePatientRecordError extends DeletePatientRecordState {
  DeletePatientRecordError({required super.records, required super.medicalId, required this.message});
  final String message;
}

final class AddPatientRecordLoading extends AddPatientRecordState {
  AddPatientRecordLoading({required super.records, required super.medicalId});
}

final class AddPatientRecordLoaded extends AddPatientRecordState {
  AddPatientRecordLoaded({required super.records, required super.medicalId});
}

final class AddPatientRecordError extends AddPatientRecordState {
  AddPatientRecordError({required super.records, required super.medicalId, required this.message});
  final String message;
}

// OPEN FILE
abstract class OpenFileState extends PatientRecordState {
  OpenFileState({required super.records, required super.medicalId});
}

final class OpenFileLoading extends OpenFileState {
  OpenFileLoading({required super.records, required super.medicalId});
}

final class OpenFileLoaded extends OpenFileState {
  OpenFileLoaded({required super.records, required this.filePath, required super.medicalId});
  final String filePath;
}

final class OpenFileError extends OpenFileState {
  OpenFileError(
      {required super.records, required this.message, required this.url, required super.medicalId});
  final String message;
  final String url;
}
