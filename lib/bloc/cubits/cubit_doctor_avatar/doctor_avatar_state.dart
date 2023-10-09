part of 'doctor_avatar_cubit.dart';

sealed class DoctorAvatarState {
  const DoctorAvatarState();
}

final class DoctorAvatarInitial extends DoctorAvatarState {}

final class DoctorAvatarUpdating extends DoctorAvatarState {}

final class DoctorAvatarSuccessfully extends DoctorAvatarState {}

final class DoctorAvatarError extends DoctorAvatarState {
  final String message;

  DoctorAvatarError({required this.message});
}
