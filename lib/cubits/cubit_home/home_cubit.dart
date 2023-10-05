// ignore_for_file: depend_on_referenced_packages

import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:healthline/data/api/models/responses/top_doctor_response.dart';
// import 'package:healthline/data/api/repositories/doctor_repository.dart';

part 'home_state.dart';

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(HomeInital(doctors: const []));
  // final DoctorRepository _doctorRepository = DoctorRepository();
  // final UserRepository _userRepository = UserRepository();

  // Future<void> fetchData() async {
  //   emit(HomeLoading(doctors: state.doctors));

  //   try {
  //     List<TopDoctorsResponse> doctors = await _doctorRepository.getDoctors();
  //     emit(HomeInital(doctors: doctors));
  //   } catch (e) {
  //     logPrint(e.toString());
  //     emit(HomeError(message: e.toString(), doctors: state.doctors));
  //   }
  // }

  

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    return HomeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return state.toMap();
  }
}
