// ignore_for_file: depend_on_referenced_packages, unused_field

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/repository/common_repository.dart';
import 'package:healthline/repository/doctor_repository.dart';
import 'package:healthline/repository/user_repository.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/res/enum.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial(isDoctor: false, isPatient: false));
  final UserRepository _userRepository = UserRepository();
  final CommonRepository _commonRepository = CommonRepository();
  final DoctorRepository _doctorRepository = DoctorRepository();

  Future<void> logIn(String phone, String password,
      {required bool isDoctor, required bool isPatient}) async {
    emit(LogInLoading(isDoctor: state.isDoctor, isPatient: state.isPatient));
    bool doctor = false;
    bool patient = false;
    String? errorDoctor;
    String? errorPatient;
    if (isPatient == true) {
      try {
        LoginResponse response =
            await _commonRepository.loginPatient(phone.trim(), password.trim());
        AppStorage().savePatient(user: response);
        patient = true;
      } catch (e) {
        DioException er = e as DioException;
        errorPatient = er.response!.data['message'].toString();
      }
    }
    if (isDoctor == true) {
      try {
        LoginResponse response =
            await _commonRepository.loginDoctor(phone.trim(), password.trim());
        AppStorage().saveDoctor(user: response);
        doctor = true;
      } catch (e) {
        DioException er = e as DioException;
        errorDoctor = er.response!.data['message'].toString();
      }
    }
    if (doctor == true || patient == true) {
      if (doctor == true && patient == true) {
        AppController.instance.authState = AuthState.AllAuthorized;
      } else if (doctor == true) {
        AppController.instance.authState = AuthState.DoctorAuthorized;
      } else {
        AppController.instance.authState = AuthState.PatientAuthorized;
      }
      emit(LogInSuccessed(
          isDoctor: doctor,
          isPatient: patient,
          errorPatient: errorPatient,
          errorDoctor: errorDoctor));
    } else {
      AppController.instance.authState = AuthState.Unauthorized;
      emit(
        LogInError(
            isDoctor: false,
            isPatient: false,
            errorDoctor: errorDoctor,
            errorPatient: errorPatient),
      );
    }
  }
}
