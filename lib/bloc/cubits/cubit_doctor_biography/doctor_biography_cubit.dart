// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/repository/doctor_repository.dart';

part 'doctor_biography_state.dart';

class DoctorBiographyCubit extends Cubit<DoctorBiographyState> {
  DoctorBiographyCubit() : super(DoctorBiographyInitial());
  final DoctorRepository _doctorRepository = DoctorRepository();
  Future<void> updateBio(String bio) async {
    emit(DoctorBiographyUpdating());
    try {
      DataResponse response = await _doctorRepository.updateBio(bio);
      if(response.success){
        emit(DoctorBiographySuccessfully());
      }
    } catch (e) {
      DioException er = e as DioException;
      emit(DoctorBiographyError(message: er.message.toString()));
    }
  }
}
