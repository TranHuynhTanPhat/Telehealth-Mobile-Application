// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/repository/user_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';

part 'patient_profile_state.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  PatientProfileCubit()
      : super(PatientProfileInitial(
            phone: '', email: '', blocState: BlocState.Successed));
  final UserRepository _userRepository = UserRepository();

  @override
  void onChange(Change<PatientProfileState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> fetchContact() async {
    emit(FetchContactState(
        phone: state.phone, email: state.email, blocState: BlocState.Pending));

    try {
      UserResponse userResponse = await _userRepository.fetchContact();

      emit(FetchContactState(
          phone: userResponse.phone,
          email: userResponse.email,
          blocState: BlocState.Successed));
    } on DioException catch (e) {
      emit(FetchContactState(
          error: e.response!.data['message'].toString(),
          phone: null,
          email: null,
          blocState: BlocState.Failed));
    } catch (e) {
      emit(FetchContactState(
          error: e.toString(),
          phone: null,
          email: null,
          blocState: BlocState.Failed));
    }
  }

  Future<void> updateEmail(String email) async {
    emit(UpdateContactState(
        phone: state.phone, email: email, blocState: BlocState.Pending));

    try {
      DataResponse response = await _userRepository.updateEmail(email);
      emit(UpdateContactState(
          phone: state.phone,
          email: email,
          response: response,
          blocState: BlocState.Successed));
    } on DioException catch (e) {
      emit(UpdateContactState(
          error: e.response!.data['message'].toString(),
          phone: null,
          email: null,
          blocState: BlocState.Failed));
    } catch (e) {
      emit(UpdateContactState(
          error: e.toString(),
          phone: null,
          email: null,
          blocState: BlocState.Failed));
    }
  }
}
