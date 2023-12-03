part of 'doctor_cubit.dart';

sealed class DoctorState {
  const DoctorState({required this.doctors});
  final List<DoctorProfileResponse> doctors;
}

final class DoctorInitial extends DoctorState {
  DoctorInitial({required super.doctors});
}

final class FetchDoctorsState extends DoctorState {
  FetchDoctorsState({required super.doctors});
}

final class FetchDetailDoctor extends DoctorState {
  FetchDetailDoctor({required super.doctors});
}

final class FetchDoctorsLoading extends FetchDoctorsState {
  FetchDoctorsLoading( {required super.doctors});
}

final class FetchDoctorsSuccess extends FetchDoctorsState {
  FetchDoctorsSuccess({required super.doctors});
}

final class FetchDoctorsError extends FetchDoctorsState {
  final String error;

  FetchDoctorsError({required this.error, required super.doctors});
}

final class FetchDetailDoctorLoading extends FetchDetailDoctor {
  FetchDetailDoctorLoading({required super.doctors});
}

final class FetchDetailDoctorSuccess extends FetchDetailDoctor {
  FetchDetailDoctorSuccess({required super.doctors});
}

final class FetchDetailDoctorError extends FetchDetailDoctor {
  FetchDetailDoctorError({required super.doctors});
}
