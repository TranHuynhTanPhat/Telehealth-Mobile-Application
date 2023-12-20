part of 'doctor_profile_cubit.dart';

class DoctorProfileState {
  const DoctorProfileState({required this.profile});
  final DoctorResponse profile;
}

final class DoctorProfileInitial extends DoctorProfileState {
  DoctorProfileInitial({required super.profile});
}

final class FetchProfileState extends DoctorProfileState {
  final BlocState blocState;
  final String? error;

  FetchProfileState(
      {required super.profile, required this.blocState, this.error});
}

final class UpdateProfileState extends DoctorProfileState {
  final BlocState blocState;
  final String? error;
  final String? message;

  UpdateProfileState(
      {required super.profile,
      required this.blocState,
      this.error,
      this.message});
}

final class FetchPatientState extends DoctorProfileState {
  FetchPatientState(
      {required super.profile,
      required this.blocState,
      this.error,
      required this.patients});
  final String? error;
  final BlocState blocState;
  final List<UserResponse> patients;
}
