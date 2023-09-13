// ignore_for_file: depend_on_referenced_packages, unused_field

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/models/user_model.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit(this._userRepository) : super(LogInInitial());
  final UserRepository _userRepository;

  void navigateToSignIn() {
    emit(NavigateToSignUpActionState());
  }

  Future<void> signIn(String phone, String password) async {
    emit(LogInLoadingActionState());
    try {
      LoginResponse response =
          await _userRepository.login(phone.trim(), password.trim());
      AppStorage().saveUser(
          user: User(role: response.role, accessToken: response.jwtToken));
      emit(SignInActionState(response: response));
    } catch (error) {
      DioException er = error as DioException;
      emit(LogInErrorActionState(message: er.response?.data['message']));
    }
  }
}
