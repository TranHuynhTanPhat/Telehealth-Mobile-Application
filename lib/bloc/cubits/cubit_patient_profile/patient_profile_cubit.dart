// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/spending_chart_patient.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/repositories/user_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';

part 'patient_profile_state.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  PatientProfileCubit()
      : super(PatientProfileInitial(
            blocState: BlocState.Successed, profile: UserResponse()));
  final UserRepository _userRepository = UserRepository();

  @override
  void onChange(Change<PatientProfileState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> fetchSpendingChart(
      {required String id, required int month, required int year}) async {
    emit(FetchSpendingChart(
        blocState: BlocState.Pending,
        profile: state.profile,
        spendingChartPatient: null));

    try {
      SpendingChartPatient spendingChartPatient = await _userRepository
          .fetchSpendingChart(id: id, month: month, year: year);

      emit(FetchSpendingChart(
          blocState: BlocState.Successed,
          profile: state.profile,
          spendingChartPatient: spendingChartPatient));
    } on DioException catch (e) {
      emit(FetchSpendingChart(
          error: e.response!.data['message'].toString(),
          blocState: BlocState.Failed,
          profile: state.profile,
          spendingChartPatient: null));
    } catch (e) {
      emit(FetchSpendingChart(
          error: e.toString(),
          blocState: BlocState.Failed,
          profile: state.profile,
          spendingChartPatient: null));
    }
  }

  Future<void> fetchProfile() async {
    emit(FetchContactState(
        blocState: BlocState.Pending, profile: state.profile));

    try {
      UserResponse userResponse = await _userRepository.fetchProfile();
      // fetchSpendingChart(id: userResponse.id??"", month: 5, year: 2024);

      emit(FetchContactState(
          blocState: BlocState.Successed, profile: userResponse));
    } on DioException catch (e) {
      emit(FetchContactState(
          error: e.response!.data['message'].toString(),
          blocState: BlocState.Failed,
          profile: state.profile));
    } catch (e) {
      emit(FetchContactState(
          error: e.toString(),
          blocState: BlocState.Failed,
          profile: state.profile));
    }
  }

  Future<void> updateEmail(String email) async {
    emit(UpdateContactState(
        blocState: BlocState.Pending, profile: state.profile));

    try {
      await _userRepository.updateEmail(email);
      emit(UpdateContactState(
          blocState: BlocState.Successed, profile: state.profile));
    } on DioException catch (e) {
      emit(UpdateContactState(
          error: e.response!.data['message'].toString(),
          blocState: BlocState.Failed,
          profile: state.profile));
    } catch (e) {
      emit(UpdateContactState(
          error: e.toString(),
          blocState: BlocState.Failed,
          profile: state.profile));
    }
  }
}
