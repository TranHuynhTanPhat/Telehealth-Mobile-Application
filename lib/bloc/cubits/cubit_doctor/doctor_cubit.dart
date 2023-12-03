// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/doctor_profile_response.dart';
import 'package:healthline/repository/doctor_repository.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial(doctors: []));
  final DoctorRepository _doctorRepository = DoctorRepository();

  Future<void> fetchDoctors() async {
    emit(FetchDoctorsLoading(doctors: state.doctors));
    try {
      List<DoctorProfileResponse> doctors =
          await _doctorRepository.fetchListDoctor();
      emit(FetchDoctorsSuccess(doctors: doctors));
    } on DioException catch (e) {
      emit(FetchDoctorsError(
          error: e.response!.data['message'].toString(),
          doctors: state.doctors));
    } catch (e) {
      // DioException er = e as DioException;
      emit(FetchDoctorsError(error: e.toString(), doctors: state.doctors));
    }
  }
}
