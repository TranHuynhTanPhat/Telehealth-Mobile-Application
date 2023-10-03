part of 'health_info_cubit.dart';

class HealthInfoState {
  const HealthInfoState(this.subUsers, this.currentUser);
  final List<UserResponse> subUsers;
  final int currentUser;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'subUsers': subUsers.map((x) => x.toMap()).toList()});
    result.addAll({'currentUser': currentUser});

    return result;
  }

  factory HealthInfoState.fromMap(Map<String, dynamic> map) {
    return HealthInfoState(
      List<UserResponse>.from(
          map['subUsers']?.map((x) => UserResponse.fromMap(x))),
      map['currentUser']?.toInt() ?? 0,
    );
  }
}

final class HealthInfoInitial extends HealthInfoState {
  HealthInfoInitial(super.subUsers, super.currentUser);
}

final class HealthInfoLoading extends HealthInfoState {
  HealthInfoLoading(super.subUsers, super.currentUser);
}

final class HealthInfoError extends HealthInfoState {
  HealthInfoError(super.subUsers, super.currentUser);
}

final class HealthInfoLoaded extends HealthInfoState {
  HealthInfoLoaded(super.subUsers, super.currentUser);
}

final class AddUserSuccessfully extends HealthInfoState {
  AddUserSuccessfully(super.subUsers, super.currentUser, this.message);
  final String message;
}

final class AddUserFailure extends HealthInfoState {
  AddUserFailure(super.subUsers, super.currentUser, this.message);
  final String message;
}

final class UpdateUserSuccessfully extends HealthInfoState {
  UpdateUserSuccessfully(super.subUsers, super.currentUser, this.message);
  final String message;
}

final class UpdateUserFailure extends HealthInfoState {
  UpdateUserFailure(super.subUsers, super.currentUser, this.message);
  final String message;
}
