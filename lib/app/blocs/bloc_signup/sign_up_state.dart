part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpActionState extends SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpLoaded extends SignUpState {}

final class SignUpError extends SignUpState {
  final String message;

  const SignUpError({required this.message});
}

final class NavigateToLogInActionState extends SignUpActionState{}