// ignore_for_file: depend_on_referenced_packages, unused_field

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/repository/user_repository.dart';
import 'package:healthline/utils/log_data.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final UserRepository _userRepository = UserRepository();

  @override
  void onChange(Change<SignUpState> change) {
    super.onChange(change);
    logPrint(change);
  }

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
    } on DioException catch (e) {
      emit(SignUpErrorActionState(
          code: e.response!.statusCode,
          message: e.response!.data['message'].toString()));
    } catch (e) {
      emit(SignUpErrorActionState(code: 0, message: e.toString()));
    }
  }
}
