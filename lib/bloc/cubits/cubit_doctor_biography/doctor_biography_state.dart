part of 'doctor_biography_cubit.dart';

sealed class DoctorBiographyState {
  const DoctorBiographyState();
}

final class DoctorBiographyInitial extends DoctorBiographyState {}

final class DoctorBiographyUpdating extends DoctorBiographyState {}

final class DoctorBiographySuccessfully extends DoctorBiographyState {}

final class DoctorBiographyError extends DoctorBiographyState {
  final String message;

  DoctorBiographyError({required this.message});
}
