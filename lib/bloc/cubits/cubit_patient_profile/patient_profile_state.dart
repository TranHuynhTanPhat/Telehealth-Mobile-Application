part of 'patient_profile_cubit.dart';

sealed class PatientProfileState {
  final UserResponse profile;
  final BlocState blocState;
  final String? error;

  PatientProfileState(
      {required this.profile, required this.blocState, this.error});
}

final class PatientProfileInitial extends PatientProfileState {
  PatientProfileInitial(
      {required super.profile, required super.blocState, super.error});
}

final class FetchContactState extends PatientProfileState {
  FetchContactState(
      {required super.profile, required super.blocState, super.error});
}

final class UpdateContactState extends PatientProfileState {
  UpdateContactState(
      {required super.blocState, super.error, required super.profile});

  // final DataResponse? response;
}
