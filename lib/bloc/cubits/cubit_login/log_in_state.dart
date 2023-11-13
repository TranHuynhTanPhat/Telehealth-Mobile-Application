part of 'log_in_cubit.dart';

sealed class LogInState {
  // const LogInState({required this.isDoctor, required this.isPatient});
  // final bool isDoctor;
  // final bool isPatient;
}

final class LogInInitial extends LogInState {
  // LogInInitial({required super.isDoctor, required super.isPatient});
}

final class LogInLoading extends LogInState {
  // LogInLoading({required super.isDoctor, required super.isPatient});
}

final class LogInSuccessed extends LogInState {
  // LogInSuccessed({
  // required super.isDoctor,
  // required super.isPatient,
  // required this.errorDoctor,
  // required this.errorPatient,
  // });
  // final String? errorDoctor;
  // final String? errorPatient;
}

final class LogInError extends LogInState {
  // final String? errorDoctor;
  // final String? errorPatient;
  final String error;
  LogInError({required this.error});
  // const LogInError({
  //   required super.isDoctor,
  //   required super.isPatient,
  //   required this.errorDoctor,
  //   required this.errorPatient,
  // });
}
