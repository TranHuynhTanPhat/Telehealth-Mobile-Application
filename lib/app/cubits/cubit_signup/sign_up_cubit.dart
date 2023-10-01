// ignore_for_file: depend_on_referenced_packages, unused_field

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._userRepository) : super(SignUpInitial());
  final UserRepository _userRepository;

  Future<void> registerAccount(
      String fullName,
      String phone,
      String email,
      String password,
      String passwordConfirm,
      String gender,
      String birthday,
      String address) async {
    emit(SignUpLoadingActionState());
    try {
      int? code = await _userRepository.registerAccount(fullName, phone, email,
          password, passwordConfirm, gender, birthday, address);
      emit(RegisterAccountActionState(
          message: code == 201 ? 'success_register' : ''));
    } catch (error) {
      DioException er = error as DioException;
      emit(SignUpErrorActionState(code:er.response!.statusCode,
          message: er.response!.data['message'].toString()));
    }
  }
}
