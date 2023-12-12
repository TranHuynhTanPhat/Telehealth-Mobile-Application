// ignore_for_file: depend_on_referenced_packages, unused_field

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/repository/user_repository.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial(blocState: BlocState.Successed));

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
    emit(SignUpState(blocState: BlocState.Pending));
    try {
      await _userRepository.registerAccount(fullName, phone, email, password,
          passwordConfirm, gender, birthday, address);
      emit(SignUpState(blocState: BlocState.Successed));
    } on DioException catch (e) {
      emit(
        SignUpState(
          blocState: BlocState.Failed,
          error: e.response!.data['message'].toString(),
        ),
      );
    } catch (e) {
      emit(
        SignUpState(
          blocState: BlocState.Failed,
          error: e.toString(),
        ),
      );
    }
  }
}
