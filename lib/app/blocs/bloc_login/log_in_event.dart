part of 'log_in_bloc.dart';

sealed class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class NavigateToSignUp extends LogInEvent{}