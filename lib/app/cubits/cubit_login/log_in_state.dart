part of 'log_in_cubit.dart';

sealed class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object> get props => [];
}

final class LogInInitial extends LogInState {}


final class LogInLoading extends LogInState {}

final class LogInLoaded extends LogInState {}

final class LogInError extends LogInState {
  final String message;

  const LogInError({required this.message});
}

final class LogInActionState extends LogInState {}

final class LogInLoadingActionState extends LogInActionState{}

final class LogInErrorActionState extends LogInActionState {
  final String message;

  LogInErrorActionState({required this.message});
}

final class SignInActionState extends LogInActionState {
  final LoginResponse response;

  SignInActionState({required this.response});
}
