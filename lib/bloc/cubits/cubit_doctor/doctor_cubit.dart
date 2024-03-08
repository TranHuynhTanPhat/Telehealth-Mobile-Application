// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:meilisearch/meilisearch.dart';

import 'package:healthline/data/api/meilisearch_manager.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/res/enum.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit()
      : super(
          DoctorInitial(
            doctors: [],
            blocState: BlocState.Successed,
          ),
        );
  final MeiliSearchManager meiliSearchManager = MeiliSearchManager.instance;

  Future<void> searchDoctor(
      {required String key,
      SearchQuery? searchQuery,
      required int pageKey,
      required Function(List<DoctorResponse>) callback}) async {
    emit(
      SearchDoctorState(
          doctors: state.doctors,
          blocState: BlocState.Pending,
          pageKey: pageKey),
    );
    try {
      // meiliSearchManager.index(uid: 'doctors');
      // var result = await meiliSearchManager.search(key, searchQuery);
      String jsonString =
          await rootBundle.loadString('assets/virtual_data/doctor.json');
      dynamic list = json.decode(jsonString);
      List<DoctorResponse> doctors =
          list.map<DoctorResponse>((e) => DoctorResponse.fromMap(e)).toList();
      // List<DoctorResponse> doctors = List<DoctorResponse>.from(
      //   listMap.map(
      //     (e) => DoctorResponse.fromMap(e),
      //   ),
      // );
      callback(doctors);
      emit(
        SearchDoctorState(
            doctors: doctors, blocState: BlocState.Successed, pageKey: pageKey),
      );
    } catch (error) {
      logPrint(error);
      emit(
        SearchDoctorState(
            error: error.toString(),
            doctors: state.doctors,
            blocState: BlocState.Failed,
            pageKey: pageKey),
      );
    }
  }
  // Future<void> fetchDoctors() async {
  //   emit(FetchDoctorsLoading(doctors: state.doctors));
  //   try {
  //     // List<DoctorResponse> doctors =
  //     //     await _doctorRepository.fetchListDoctor();
  //     emit(FetchDoctorsSuccess(doctors: doctors));
  //   } on DioException catch (e) {
  //     emit(FetchDoctorsError(
  //         error: e.response!.data['message'].toString(),
  //         doctors: state.doctors));
  //   } catch (e) {
  //     // DioException er = e as DioException;
  //     emit(FetchDoctorsError(error: e.toString(), doctors: state.doctors));
  //   }
  // }
}
