// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/data/api/socket_manager.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/data_constants.dart';
import 'package:healthline/repository/common_repository.dart';
import 'package:healthline/repository/user_repository.dart';

import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit()
      : super(AuthenticationInitial(blocState: BlocState.Successed));
  final UserRepository _userRepository = UserRepository();
  final CommonRepository _commonRepository = CommonRepository();

  @override
  void onChange(Change<AuthenticationState> change) {
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
    emit(RegisterAccountState(blocState: BlocState.Pending));
    try {
      await _userRepository.registerAccount(fullName, phone, email, password,
          passwordConfirm, gender, birthday, address);
      emit(RegisterAccountState(blocState: BlocState.Successed));
    } on DioException catch (e) {
      emit(
        RegisterAccountState(
          blocState: BlocState.Failed,
          error: e.response!.data['message'].toString(),
        ),
      );
    } catch (e) {
      emit(
        RegisterAccountState(
          blocState: BlocState.Failed,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> login(String phone, String password,
      {required bool isDoctor,
      required bool isPatient,
      bool remember = false}) async {
    emit(LoginState(blocState: BlocState.Pending));
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
      SocketManager.instance.init();
      emit(LoginState(blocState: BlocState.Successed));
    } on DioException catch (e) {
      AppController.instance.authState = AuthState.Unauthorized;
      error = e.response!.data['message'].toString();
    } catch (e) {
      AppController.instance.authState = AuthState.Unauthorized;
      error = e.toString();
    }
    emit(LoginState(error: error.toString(), blocState: BlocState.Failed));

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

  Future<void> logout() async {
    emit(LogoutState(blocState: BlocState.Pending));
    try {
      await RestClient().logout();
      emit(LogoutState(blocState: BlocState.Successed));
    } catch (e) {
      logPrint(e);
      emit(LogoutState(blocState: BlocState.Failed, error: e.toString()));
    }
  }
}
