part of 'sub_user_cubit.dart';

class SubUserState {
  const SubUserState(this.subUsers, this.currentUser);
  final List<UserResponse> subUsers;
  final int currentUser;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'subUsers': subUsers.map((x) => x.toMap()).toList()});
    result.addAll({'currentUser': currentUser});

    return result;
  }

  factory SubUserState.fromMap(Map<String, dynamic> map) {
    return SubUserState(
      List<UserResponse>.from(
          map['subUsers']?.map((x) => UserResponse.fromMap(x))),
      map['currentUser']?.toInt() ?? 0,
    );
  }
}

final class SubUserInitial extends SubUserState {
  SubUserInitial(super.subUsers, super.currentUser);
}

abstract class AddUser extends SubUserState {
  AddUser(super.subUsers, super.currentUser);
}

abstract class UpdateUser extends SubUserState {
  UpdateUser(super.subUsers, super.currentUser);
}

abstract class FetchUser extends SubUserState {
  FetchUser(super.subUsers, super.currentUser);
}

abstract class DeleteUser extends SubUserState {
  DeleteUser(super.subUsers, super.currentUser);
}

final class FetchSubUserLoading extends FetchUser {
  FetchSubUserLoading(super.subUsers, super.currentUser);
}

final class FetchSubUserError extends FetchUser {
  FetchSubUserError(super.subUsers, super.currentUser);
}

final class FetchSubUserLoaded extends SubUserState {
  FetchSubUserLoaded(super.subUsers, super.currentUser);
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
