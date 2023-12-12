part of 'doctor_cubit.dart';

sealed class DoctorState {
  const DoctorState({
    required this.doctors,
    required this.blocState,
    this.error,
  });
  final List<DoctorResponse> doctors;
  final BlocState blocState;
  final String? error;
}

final class DoctorInitial extends DoctorState {
  DoctorInitial(
      {required super.doctors, required super.blocState, super.error});
}

final class SearchDoctorState extends DoctorState {
  SearchDoctorState({required super.doctors, required super.blocState, required this.pageKey, super.error});
  int pageKey;
}
