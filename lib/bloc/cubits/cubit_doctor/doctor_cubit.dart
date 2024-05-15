// ignore: depend_on_referenced_packages

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:healthline/repositories/file_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meilisearch/meilisearch.dart';

import 'package:healthline/data/api/meilisearch_manager.dart';
import 'package:healthline/data/api/models/responses/doctor_detail_response.dart';
import 'package:healthline/repositories/user_repository.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';

part 'doctor_state.dart';

class DoctorCubit extends HydratedCubit<DoctorState> {
  DoctorCubit()
      : super(
          const DoctorState(
            doctors: [],
            blocState: BlocState.Successed,
            pageKey: 0,
          ),
        );
  final MeiliSearchManager meiliSearchManager = MeiliSearchManager.instance;
  final UserRepository _userRepository = UserRepository();
  final FileRepository _fileRepository = FileRepository();

  @override
  void onChange(Change<DoctorState> change) {
    super.onChange(change);
    logPrint("$change ${change.currentState.blocState.name}");
  }

  // Future<void> resetRecentDoctor() async {
  //   await HydratedBloc.storage.clear();
  // }

  Future<List<String>> uploadImageSpecialty(
      {required List<File?> images, required String phone}) async {
    try {
      return await _fileRepository.uploadImageSpecialty(
          images: images, phone: phone);
    } catch (e) {
      logPrint(e);
      return [];
    }
  }

  Future<void> searchDoctor(
      {required String key,
      SearchQuery? searchQuery,
      required int pageKey,
      required Function(List<DoctorDetailResponse>) callback}) async {
    emit(
      DoctorState(
          doctors: state.doctors,
          blocState: BlocState.Pending,
          pageKey: pageKey,
          recentDoctors: state.recentDoctors),
    );
    try {
      // String jsonString =
      //     await rootBundle.loadString('assets/virtual_data/doctor.json');
      // dynamic list = json.decode(jsonString);
      // List<DoctorResponse> doctors =
      //     list.map<DoctorResponse>((e) => DoctorResponse.fromMap(e)).toList();

      meiliSearchManager.index(uid: 'doctors');
      var result = await meiliSearchManager.search(key, searchQuery);
      List<DoctorDetailResponse> doctors = List<DoctorDetailResponse>.from(
        result.hits.map(
          (e) => DoctorDetailResponse.fromMap(e),
        ),
      );
      callback(doctors);
      emit(
        DoctorState(
            doctors: doctors,
            blocState: BlocState.Successed,
            pageKey: pageKey,
            recentDoctors: state.recentDoctors),
      );
    } catch (error) {
      logPrint("A +$error");
      emit(
        DoctorState(
            error: error.toString(),
            doctors: state.doctors,
            blocState: BlocState.Failed,
            pageKey: pageKey,
            recentDoctors: state.recentDoctors),
      );
    }
  }

  Future<void> addRecentDoctor(DoctorDetailResponse doctor) async {
    List<DoctorDetailResponse> recentDrs = state.recentDoctors.toList();

    if (recentDrs.where((element) => element.id == doctor.id).isEmpty) {
      recentDrs.add(doctor);
    }
    try {
      if (recentDrs.length > 10) {
        recentDrs =
            recentDrs.getRange(1, recentDrs.length).map((e) => e).toList();
      }
    } catch (e) {
      logPrint("$e");
    }

    emit(DoctorState(
        blocState: state.blocState,
        doctors: state.doctors,
        error: state.error,
        recentDoctors: recentDrs,
        pageKey: state.pageKey));
  }

  Future<void> addWishList({required String doctorId}) async {
    emit(DoctorState(
        doctors: state.doctors,
        blocState: BlocState.Pending,
        recentDoctors: state.recentDoctors,
        pageKey: state.pageKey,
        wishDoctors: state.wishDoctors));
    try {
      await _userRepository.addWishList(doctorId: doctorId);
      emit(DoctorState(
          doctors: state.doctors,
          blocState: BlocState.Successed,
          recentDoctors: state.recentDoctors,
          pageKey: state.pageKey,
          wishDoctors: state.wishDoctors));
    } on DioException catch (e) {
      // DioException er = e as DioException;
      emit(
        DoctorState(
            doctors: state.doctors,
            blocState: BlocState.Failed,
            error: e.response!.data['message'].toString(),
            recentDoctors: state.recentDoctors,
            pageKey: state.pageKey,
            wishDoctors: state.wishDoctors),
      );
    } catch (e) {
      emit(
        DoctorState(
            doctors: state.doctors,
            blocState: BlocState.Failed,
            error: e.toString(),
            recentDoctors: state.recentDoctors,
            pageKey: state.pageKey,
            wishDoctors: state.wishDoctors),
      );
    }
  }

  Future<void> getWishList() async {
    emit(DoctorState(
        doctors: state.doctors,
        blocState: BlocState.Pending,
        recentDoctors: state.recentDoctors,
        pageKey: state.pageKey,
        wishDoctors: state.wishDoctors));
    try {
      List<DoctorDetailResponse> wishDrs = await _userRepository.getWishList();
      emit(DoctorState(
          doctors: state.doctors,
          blocState: BlocState.Successed,
          recentDoctors: state.recentDoctors,
          pageKey: state.pageKey,
          wishDoctors: wishDrs));
    } on DioException catch (e) {
      // DioException er = e as DioException;
      emit(
        DoctorState(
            doctors: state.doctors,
            blocState: BlocState.Failed,
            error: e.response!.data['message'].toString(),
            recentDoctors: state.recentDoctors,
            pageKey: state.pageKey,
            wishDoctors: state.wishDoctors),
      );
    } catch (e) {
      emit(
        DoctorState(
            doctors: state.doctors,
            blocState: BlocState.Failed,
            error: e.toString(),
            recentDoctors: state.recentDoctors,
            pageKey: state.pageKey,
            wishDoctors: state.wishDoctors),
      );
    }
  }

  @override
  DoctorState? fromJson(Map<String, dynamic> json) {
    return DoctorState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(DoctorState state) {
    return state.toMap();
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
