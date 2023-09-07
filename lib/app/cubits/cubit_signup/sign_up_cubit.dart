// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  void navigateToLogIn() {
    emit(NavigateToLogInActionState());
  }

  Future<void> registerAccount(
      String fullName, String email, String password) async {
    emit(RegisterAccountActionState());
  }
}
