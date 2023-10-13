part of 'medical_record_cubit.dart';

class MedicalRecordState {
  final List<HealthStatResponse> stats;
  final List<UserResponse> subUsers;
  final int currentUser;

  MedicalRecordState({
    required this.stats,
    required this.subUsers,
    required this.currentUser,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'stats': stats.map((x) => x.toMap()).toList()});
    result.addAll({'subUsers': subUsers.map((x) => x.toMap()).toList()});
    result.addAll({'currentUser': currentUser});

    return result;
  }

  factory MedicalRecordState.fromMap(Map<String, dynamic> map) {
    return MedicalRecordState(
      stats: List<HealthStatResponse>.from(
          map['stats']?.map((x) => HealthStatResponse.fromMap(x))),
      subUsers: List<UserResponse>.from(
          map['subUsers']?.map((x) => UserResponse.fromMap(x))),
      currentUser: map['currentUser']?.toInt() ?? 0,
    );
  }
}

final class MedicalRecordInitial extends MedicalRecordState {
  MedicalRecordInitial(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

/// Medical record loading
abstract class MedicalRecordLoadingState extends MedicalRecordState {
  MedicalRecordLoadingState(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

/// HealStatState
abstract class HealthStatState extends MedicalRecordState {
  HealthStatState(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

/// Update health stat
abstract class UpdateStat extends HealthStatState {
  UpdateStat(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

/// Fetch health stat
abstract class FetchStat extends HealthStatState {
  FetchStat(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class HealthStatLoading extends MedicalRecordLoadingState {
  HealthStatLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class HealthStatLoaded extends FetchStat {
  HealthStatLoaded(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class HealthStatError extends FetchStat {
  HealthStatError(
      {required super.stats,
      required this.message,
      required super.subUsers,
      required super.currentUser});
  final String message;
}

final class UpdateStatLoading extends MedicalRecordLoadingState {
  UpdateStatLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class UpdateStatSuccessfully extends UpdateStat {
  UpdateStatSuccessfully(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class UpdateStatError extends UpdateStat {
  UpdateStatError(
      {required super.stats,
      required this.message,
      required super.subUsers,
      required super.currentUser});
  final String message;
}

/// SubUserState
abstract class SubUserState extends MedicalRecordState {
  SubUserState(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

/// Add subUser
abstract class AddSubUser extends SubUserState {
  AddSubUser(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

/// Update subuser
abstract class UpdateSubUser extends SubUserState {
  UpdateSubUser(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

/// Fetch subUser
abstract class FetchSubUser extends SubUserState {
  FetchSubUser(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

/// Delete subUser
abstract class DeleteSubUser extends SubUserState {
  DeleteSubUser(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class UpdateIndexSubUser extends SubUserState {
  UpdateIndexSubUser(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class FetchSubUserLoading extends MedicalRecordLoadingState {
  FetchSubUserLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class FetchSubUserError extends FetchSubUser {
  FetchSubUserError(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class FetchSubUserLoaded extends FetchSubUser {
  FetchSubUserLoaded(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class AddSubUserLoading extends MedicalRecordLoadingState {
  AddSubUserLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class AddSubUserSuccessfully extends AddSubUser {
  final String message;

  AddSubUserSuccessfully(
      {required super.stats,
      required super.subUsers,
      required super.currentUser,
      required this.message});
}

final class AddSubUserFailure extends AddSubUser {
  final String message;

  AddSubUserFailure(
      {required super.stats,
      required super.subUsers,
      required super.currentUser,
      required this.message});
}

final class UpdateSubUserLoading extends MedicalRecordLoadingState {
  UpdateSubUserLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class UpdateSubUserSuccessfully extends UpdateSubUser {
  final String message;

  UpdateSubUserSuccessfully(
      {required super.stats,
      required super.subUsers,
      required super.currentUser,
      required this.message});
}

final class UpdateSubUserFailure extends UpdateSubUser {
  final String message;

  UpdateSubUserFailure(
      {required super.stats,
      required super.subUsers,
      required super.currentUser,
      required this.message});
}

final class DeleteSubUserLoading extends MedicalRecordLoadingState {
  DeleteSubUserLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class DeleteSubUserSuccessfully extends DeleteSubUser {
  DeleteSubUserSuccessfully(
      {required super.stats,
      required super.subUsers,
      required super.currentUser});
}

final class DeleteSubUserFailure extends DeleteSubUser {
  DeleteSubUserFailure(
      {required super.stats,
      required super.subUsers,
      required super.currentUser, required this.message});
      final String message;
}
