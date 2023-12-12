part of 'sign_up_cubit.dart';

class SignUpState {
  final BlocState blocState;
  final String? error;

  SignUpState({required this.blocState, this.error});
}

final class SignUpInitial extends SignUpState {
  SignUpInitial({required super.blocState, super.error});
}
