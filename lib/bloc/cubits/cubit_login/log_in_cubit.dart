// ignore_for_file: depend_on_referenced_packages, unused_field

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/storage/data_constants.dart';
import 'package:healthline/repository/common_repository.dart';
import 'package:healthline/repository/doctor_repository.dart';
import 'package:healthline/repository/user_repository.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  final UserRepository _userRepository = UserRepository();
  final CommonRepository _commonRepository = CommonRepository();
  final DoctorRepository _doctorRepository = DoctorRepository();

  @override
  void onChange(Change<LogInState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> logIn(String phone, String password,
      {required bool isDoctor,
      required bool isPatient,
      bool remember = false}) async {
    emit(LogInLoading());
    // bool doctor = false;
    // bool patient = false;
    // String? errorDoctor;
    // String? errorPatient;
    String? error;

    try {
      if (isPatient) {
        LoginResponse response =
            await _commonRepository.loginPatient(phone.trim(), password.trim());
        AppStorage()
            .setString(key: DataConstants.PATIENT, value: response.toJson());
        // patient = true;
        AppController.instance.authState = AuthState.PatientAuthorized;
      } else if (isDoctor) {
        LoginResponse response =
            await _commonRepository.loginDoctor(phone.trim(), password.trim());
        AppStorage()
            .setString(key: DataConstants.DOCTOR, value: response.toJson());
        // doctor = true;
        AppController.instance.authState = AuthState.DoctorAuthorized;
      }
      AppStorage().setBool(key: DataConstants.REMEMBER, value: remember);
      emit(LogInSuccessed());
    } on DioException catch (e) {
      AppController.instance.authState = AuthState.Unauthorized;
      error = e.response!.data['message'].toString();
    } catch (e) {
      AppController.instance.authState = AuthState.Unauthorized;
      error = e.toString();
    }
    emit(LogInError(error: error.toString()));

    // if (isPatient == true) {
    //   try {
    //     LoginResponse response =
    //         await _commonRepository.loginPatient(phone.trim(), password.trim());
    //     AppStorage()
    //         .setString(key: DataConstants.PATIENT, value: response.toJson());
    //     patient = true;
    //   } catch (e) {
    // DioException er = e as DioException;
    // // errorPatient = er.response!.data['message'].toString();
    //   }
    // }
    // if (isDoctor == true) {
    //   try {
    //     LoginResponse response =
    //         await _commonRepository.loginDoctor(phone.trim(), password.trim());
    //     AppStorage()
    //         .setString(key: DataConstants.DOCTOR, value: response.toJson());
    //     doctor = true;
    //   } catch (e) {
    //     DioException er = e as DioException;
    //     errorDoctor = er.response!.data['message'].toString();
    //   }
    // }
    // if (doctor == true || patient == true) {
    //   if (doctor == true && patient == true) {
    //     AppController.instance.authState = AuthState.AllAuthorized;
    //   } else if (doctor == true) {
    //     AppController.instance.authState = AuthState.DoctorAuthorized;
    //   } else {
    //     AppController.instance.authState = AuthState.PatientAuthorized;
    //   }
    // AppStorage().setBool(key: DataConstants.REMEMBER, value: remember);
    // emit(LogInSuccessed(
    //     isDoctor: doctor,
    //     isPatient: patient,
    //     errorPatient: errorPatient,
    //     errorDoctor: errorDoctor));
    // }
    // else {
    //   AppController.instance.authState = AuthState.Unauthorized;
    //   emit(
    //     LogInError(
    //         isDoctor: false,
    //         isPatient: false,
    //         errorDoctor: errorDoctor,
    //         errorPatient: errorPatient),
    //   );
    // }
  }
}
