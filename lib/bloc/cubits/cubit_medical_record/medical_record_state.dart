part of 'medical_record_cubit.dart';

class MedicalRecordState {
  final List<HealthStatResponse> stats;
  final List<UserResponse> subUsers;
  final String? currentId;

  MedicalRecordState({
    required this.stats,
    required this.subUsers,
    required this.currentId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'stats': stats.map((x) => x.toMap()).toList()});
    result.addAll({'subUsers': subUsers.map((x) => x.toMap()).toList()});
    result.addAll({'currentId': currentId});

    return result;
  }

  factory MedicalRecordState.fromMap(Map<String, dynamic> map) {
    return MedicalRecordState(
      stats: List<HealthStatResponse>.from(
          map['stats']?.map((x) => HealthStatResponse.fromMap(x))),
      subUsers: List<UserResponse>.from(
          map['subUsers']?.map((x) => UserResponse.fromMap(x))),
      currentId: map['currentId']?.toInt() ?? 0,
    );
  }
}

final class MedicalRecordInitial extends MedicalRecordState {
  MedicalRecordInitial(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class NoChange extends MedicalRecordState {
  NoChange(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

/// Medical record loading
abstract class MedicalRecordLoadingState extends MedicalRecordState {
  MedicalRecordLoadingState(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

/// HealStatState
abstract class HealthStatState extends MedicalRecordState {
  HealthStatState(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

/// Update health stat
abstract class UpdateStatState extends HealthStatState {
  UpdateStatState(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

/// Fetch health stat
abstract class FetchStatState extends HealthStatState {
  FetchStatState(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class HealthStatLoading extends MedicalRecordLoadingState {
  HealthStatLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class HealthStatLoaded extends FetchStatState {
  HealthStatLoaded(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class HealthStatError extends UpdateStatState {
  HealthStatError(
      {required super.stats,
      required this.message,
      required super.subUsers,
      required super.currentId});
  final String message;
}

final class UpdateStatLoading extends MedicalRecordLoadingState {
  UpdateStatLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class UpdateStatSuccessfully extends UpdateStatState {
  UpdateStatSuccessfully(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class UpdateStatError extends UpdateStatState {
  UpdateStatError(
      {required super.stats,
      required this.message,
      required super.subUsers,
      required super.currentId});
  final String message;
}

/// SubUserState
abstract class SubUserState extends MedicalRecordState {
  SubUserState(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

/// Add subUser
abstract class AddSubUserState extends SubUserState {
  AddSubUserState(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

/// Update subuser
abstract class UpdateSubUserState extends SubUserState {
  UpdateSubUserState(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

/// Fetch subUser
abstract class FetchSubUserState extends SubUserState {
  FetchSubUserState(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

/// Delete subUser
abstract class DeleteSubUserState extends SubUserState {
  DeleteSubUserState(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class UpdateCurrentId extends SubUserState {
  UpdateCurrentId(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class FetchSubUserLoading extends MedicalRecordLoadingState {
  FetchSubUserLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class FetchSubUserError extends FetchSubUserState {
  FetchSubUserError(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class FetchSubUserLoaded extends FetchSubUserState {
  FetchSubUserLoaded(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class AddSubUserLoading extends MedicalRecordLoadingState {
  AddSubUserLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class AddSubUserSuccessfully extends AddSubUserState {
  AddSubUserSuccessfully(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class AddSubUserFailure extends AddSubUserState {
  final String message;

  AddSubUserFailure(
      {required super.stats,
      required super.subUsers,
      required super.currentId,
      required this.message});
}

final class UpdateSubUserLoading extends MedicalRecordLoadingState {
  UpdateSubUserLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class UpdateSubUserSuccessfully extends UpdateSubUserState {
  UpdateSubUserSuccessfully({
    required super.stats,
    required super.subUsers,
    required super.currentId,
  });
}

final class UpdateSubUserFailure extends UpdateSubUserState {
  final String message;

  UpdateSubUserFailure(
      {required super.stats,
      required super.subUsers,
      required super.currentId,
      required this.message});
}

final class DeleteSubUserLoading extends MedicalRecordLoadingState {
  DeleteSubUserLoading(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class DeleteSubUserSuccessfully extends DeleteSubUserState {
  DeleteSubUserSuccessfully(
      {required super.stats,
      required super.subUsers,
      required super.currentId});
}

final class DeleteSubUserFailure extends DeleteSubUserState {
  DeleteSubUserFailure(
      {required super.stats,
      required super.subUsers,
      required super.currentId,
      required this.message});
  final String message;
}
