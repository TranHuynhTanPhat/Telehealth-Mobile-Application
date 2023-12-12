part of 'patient_profile_cubit.dart';

sealed class PatientProfileState {
  final String? phone;
  final String? email;
  final BlocState blocState;
  final String? error;

  PatientProfileState(
      {required this.phone,
      required this.email,
      required this.blocState,
      this.error});
}

final class PatientProfileInitial extends PatientProfileState {
  PatientProfileInitial(
      {required super.phone, required super.email, required super.blocState});
}

final class FetchContactState extends PatientProfileState {
  FetchContactState(
      {required super.phone,
      required super.email,
      required super.blocState,
      super.error});
}

final class UpdateContactState extends PatientProfileState {
  UpdateContactState(
      {required super.phone,
      required super.email,
      required super.blocState,
      super.error,
       this.response});

  final DataResponse? response;
}
