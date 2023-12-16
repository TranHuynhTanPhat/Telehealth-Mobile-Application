part of 'authentication_cubit.dart';

sealed class AuthenticationState {
  final BlocState blocState;
  final String? error;

  AuthenticationState({required this.blocState, this.error});
}

final class AuthenticationInitial extends AuthenticationState {
  AuthenticationInitial({required super.blocState});
}

final class RegisterAccountState extends AuthenticationState {
  RegisterAccountState({required super.blocState, super.error});
}

final class LoginState extends AuthenticationState {
  LoginState({required super.blocState, super.error});
}

final class LogoutState extends AuthenticationState {
  LogoutState({required super.blocState, super.error});
}

final class ChangePasswordState extends AuthenticationState {
  ChangePasswordState({required super.blocState, super.error});
}

final class ResetPasswordState extends AuthenticationState {
  ResetPasswordState({required super.blocState, super.error});
}

final class SendOTPState extends AuthenticationState {
  SendOTPState({required super.blocState, super.error});
}
