part of 'sign_up_cubit.dart';

sealed class SignUpState {
  const SignUpState();
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpLoaded extends SignUpState {}

final class SignUpError extends SignUpState {
  final String message;

  const SignUpError({required this.message});
}

final class SignUpActionState extends SignUpState {}

final class SignUpLoadingActionState extends SignUpActionState {}

final class SignUpErrorActionState extends SignUpActionState {
  final String message;

  SignUpErrorActionState({required this.message});
}

final class RegisterAccountActionState extends SignUpActionState {
  final String message;

  RegisterAccountActionState({required this.message});
}
