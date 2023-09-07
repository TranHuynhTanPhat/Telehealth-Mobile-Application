// ignore_for_file: depend_on_referenced_packages, unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthline/data/api/models/responses/signup_response.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._userRepository) : super(SignUpInitial());
  final UserRepository _userRepository;

  void navigateToLogIn() {
    emit(NavigateToLogInActionState());
  }

  Future<void> registerAccount(
      String fullName, String email, String password) async {
    try {
      SignUpResponse response =
          await _userRepository.registerAccount(fullName, email, password);
      emit(RegisterAccountActionState(response: response));
    } catch (error) {
      emit(SignUpErrorActionState(message: error.toString()));
    }
  }
}
