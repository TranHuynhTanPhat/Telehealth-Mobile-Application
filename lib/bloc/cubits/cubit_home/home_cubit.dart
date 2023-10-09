// ignore_for_file: depend_on_referenced_packages

import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:healthline/data/api/models/responses/top_doctor_response.dart';
// import 'package:healthline/data/api/repositories/doctor_repository.dart';

part 'home_state.dart';

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(HomeInital(doctors: const []));
  @override
  void onChange(Change<HomeState> change) {
    super.onChange(change);
    logPrint(change);
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    return HomeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return state.toMap();
  }
}
