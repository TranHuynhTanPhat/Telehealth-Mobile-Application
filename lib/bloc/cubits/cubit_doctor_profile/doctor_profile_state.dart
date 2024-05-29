part of 'doctor_profile_cubit.dart';

class DoctorProfileState {
  const DoctorProfileState({required this.profile, required this.blocState});
  final DoctorDetailResponse profile;
  final BlocState blocState;

}

final class DoctorProfileInitial extends DoctorProfileState {
  DoctorProfileInitial({required super.profile, required super.blocState});
}

final class FetchProfileState extends DoctorProfileState {

  final String? error;

  FetchProfileState(
      {required super.profile, required super.blocState, this.error});
}

final class UpdateProfileState extends DoctorProfileState {
  final String? error;
  final String? message;

  UpdateProfileState(
      {required super.profile,
      required super.blocState,
      this.error,
      this.message});
}

final class FetchPatientState extends DoctorProfileState {
  FetchPatientState(
      {required super.profile,
      required super.blocState,
      this.error,
      required this.patients});
  final String? error;
  final List<UserResponse> patients;
}
