part of 'log_in_bloc.dart';

sealed class LogInState extends Equatable {
  const LogInState();
  
  @override
  List<Object> get props => [];
}

final class LogInInitial extends LogInState {}

final class LogInActionState extends LogInState {}


final class LogInLoading extends LogInState {}

final class LogInLoaded extends LogInState {}

final class LogInError extends LogInState {
  final String message;

  const LogInError({required this.message});
}

final class NavigateToSignUpActionState extends LogInActionState{}