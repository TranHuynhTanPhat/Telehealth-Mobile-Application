// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/data/api/models/responses/doctors_response.dart';
import 'package:healthline/data/api/repositories/doctor_repository.dart';
import 'package:healthline/utils/log_data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(doctors: []));
  final DoctorRepository _doctorRepository = DoctorRepository();

  Future<void> fetchData() async {
    try {
      DoctorsResponse doctors = await _doctorRepository.getDoctors();
      emit(HomeState(doctors: doctors.data));
    } catch (e) {
      logPrint(e.toString());
    }
  }
}
