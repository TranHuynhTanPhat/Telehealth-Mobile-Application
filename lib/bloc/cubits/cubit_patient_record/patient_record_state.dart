part of 'patient_record_cubit.dart';

class PatientRecordState {
  List<PatientRecordResponse> records;
  PatientRecordState({
    required this.records,
  });
}

final class PatientRecordInitial extends PatientRecordState {
  PatientRecordInitial({required super.records});
}

abstract class FetchPatientRecordState extends PatientRecordState {
  FetchPatientRecordState({required super.records});
}

abstract class AddPatientRecordState extends PatientRecordState {
  AddPatientRecordState({required super.records});
}

abstract class DeletePatientRecordState extends PatientRecordState {
  DeletePatientRecordState({required super.records});
}

final class FetchPatientRecordLoading extends FetchPatientRecordState {
  FetchPatientRecordLoading({required super.records});
}

final class FetchPatientRecordLoaded extends FetchPatientRecordState {
  FetchPatientRecordLoaded({required super.records});
}

final class FetchPatientRecordError extends FetchPatientRecordState {
  FetchPatientRecordError({required super.records});
}

final class DeletePatientRecordLoading extends DeletePatientRecordState {
  DeletePatientRecordLoading({required super.records});
}

final class DeletePatientRecordLoaded extends DeletePatientRecordState {
  DeletePatientRecordLoaded({required super.records});
}

final class DeletePatientRecordError extends DeletePatientRecordState {
  DeletePatientRecordError({required super.records});
}

final class AddPatientRecordLoading extends AddPatientRecordState {
  AddPatientRecordLoading({required super.records});
}

final class AddPatientRecordLoaded extends AddPatientRecordState {
  AddPatientRecordLoaded({required super.records});
}

final class AddPatientRecordError extends AddPatientRecordState {
  AddPatientRecordError({required super.records});
}


// OPEN FILE
abstract class OpenFileState extends PatientRecordState{
  OpenFileState({required super.records});
}

final class OpenFileLoading extends OpenFileState {
  OpenFileLoading({required super.records});
}

final class OpenFileLoaded extends OpenFileState {
  OpenFileLoaded( {required super.records, required this.filePath});
  final String filePath;
}

final class OpenFileError extends OpenFileState {
  OpenFileError({required super.records, required this.message, required this.url});
  final String message;
  final String url;
}