part of 'health_info_cubit.dart';

class HealthInfoState {
  const HealthInfoState(this.subUsers);
  final List<UserResponse> subUsers;


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'profile': subUsers.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory HealthInfoState.fromMap(Map<String, dynamic> map) {
    return HealthInfoState(
      List<UserResponse>.from(map['profile']?.map((x) => UserResponse.fromMap(x))),
    );
  }
}

final class HealthInfoInitial extends HealthInfoState {
  HealthInfoInitial(super.subUsers);
}

final class HealthInfoLoading extends HealthInfoState {
  HealthInfoLoading(super.subUsers);
}

final class HealthInfoError extends HealthInfoState {
  HealthInfoError(super.subUsers);
}

final class HealthInfoLoaded extends HealthInfoState {
  HealthInfoLoaded(super.subUsers);
}