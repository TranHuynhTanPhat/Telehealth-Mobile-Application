part of 'doctor_profile_cubit.dart';

sealed class DoctorProfileState extends Equatable {
  const DoctorProfileState();

  @override
  List<Object> get props => [];
}

final class DoctorProfileInitial extends DoctorProfileState {}
