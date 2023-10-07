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

abstract class AddUser extends HealthInfoState {
  AddUser(super.subUsers, super.currentUser);
}

abstract class UpdateUser extends HealthInfoState {
  UpdateUser(super.subUsers, super.currentUser);
}

abstract class FetchUser extends HealthInfoState {
  FetchUser(super.subUsers, super.currentUser);
}
abstract class DeleteUser extends HealthInfoState {
  DeleteUser(super.subUsers, super.currentUser);
}

final class HealthInfoInitial extends FetchUser {
  HealthInfoInitial(super.subUsers, super.currentUser);
}

final class HealthInfoLoading extends FetchUser {
  HealthInfoLoading(super.subUsers, super.currentUser);
}

final class HealthInfoError extends FetchUser {
  HealthInfoError(super.subUsers, super.currentUser);
}

final class HealthInfoLoaded extends HealthInfoState {
  HealthInfoLoaded(super.subUsers, super.currentUser);
}

final class AddUserLoading extends AddUser {
  AddUserLoading(super.subUsers, super.currentUser);
}

final class AddUserSuccessfully extends AddUser {
  AddUserSuccessfully(super.subUsers, super.currentUser, this.message);
  final String message;
}

final class AddUserFailure extends AddUser {
  AddUserFailure(super.subUsers, super.currentUser, this.message);
  final String message;
}

final class UpdateUserLoading extends UpdateUser {
  UpdateUserLoading(super.subUsers, super.currentUser);
}

final class UpdateUserSuccessfully extends UpdateUser {
  UpdateUserSuccessfully(super.subUsers, super.currentUser, this.message);
  final String message;
}

final class UpdateUserFailure extends UpdateUser {
  UpdateUserFailure(super.subUsers, super.currentUser, this.message);
  final String message;
}
final class DeleteUserLoading extends UpdateUser {
  DeleteUserLoading(super.subUsers, super.currentUser);
}

final class DeleteUserSuccessfully extends UpdateUser {
  DeleteUserSuccessfully(super.subUsers, super.currentUser, this.message);
  final String message;
}

final class DeleteUserFailure extends UpdateUser {
  DeleteUserFailure(super.subUsers, super.currentUser, this.message);
  final String message;
}
