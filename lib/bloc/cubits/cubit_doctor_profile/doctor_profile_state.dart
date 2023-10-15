part of 'doctor_profile_cubit.dart';

class DoctorProfileState {
  const DoctorProfileState(this.profile);
  final DoctorProfileResponse? profile;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (profile != null) {
      result.addAll({'profile': profile!.toMap()});
    }

    return result;
  }

  factory DoctorProfileState.fromMap(Map<String, dynamic> map) {
    return DoctorProfileState(
      map['profile'] != null
          ? DoctorProfileResponse.fromMap(map['profile'])
          : null,
    );
  }
}

final class DoctorProfileInitial extends DoctorProfileState {
  DoctorProfileInitial(super.profile);
}

abstract class DoctorBiographyState extends DoctorProfileState {
  DoctorBiographyState(super.profile);
}

abstract class DoctorAvatarState extends DoctorProfileState {
  DoctorAvatarState(super.profile);
}

abstract class DoctorEmailState extends DoctorProfileState {
  DoctorEmailState(super.profile);
}

final class DoctorProfileLoading extends DoctorProfileState {
  DoctorProfileLoading(super.profile);
}

final class DoctorProfileSuccessfully extends DoctorProfileState {
  DoctorProfileSuccessfully(super.profile);
}

final class DoctorProfileError extends DoctorProfileState {
  DoctorProfileError(super.profile);
}

final class DoctorBiographyUpdating extends DoctorProfileLoading {
  DoctorBiographyUpdating(super.profile);
}

final class DoctorBiographySuccessfully extends DoctorBiographyState {
  DoctorBiographySuccessfully(super.profile);
}

final class DoctorBiographyError extends DoctorBiographyState {
  final String message;

  DoctorBiographyError(super.profile, {required this.message});
}

final class DoctorAvatarUpdating extends DoctorProfileLoading {
  DoctorAvatarUpdating(super.profile);
}

final class DoctorAvatarSuccessfully extends DoctorAvatarState {
  DoctorAvatarSuccessfully(super.profile);
}

final class DoctorAvatarError extends DoctorAvatarState {
  final String message;

  DoctorAvatarError(super.profile, {required this.message});
}

final class DoctorEmailUpdating extends DoctorProfileLoading {
  DoctorEmailUpdating(super.profile);
}

final class DoctorEmailSuccessfully extends DoctorEmailState {
  DoctorEmailSuccessfully(super.profile);
}

final class DoctorEmailError extends DoctorEmailState {
  final String message;

  DoctorEmailError(super.profile, {required this.message});
}
