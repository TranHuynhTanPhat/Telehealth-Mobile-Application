// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
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
      required int pageKey}) async {
    emit(
      SearchDoctorState(
          doctors: state.doctors,
          blocState: BlocState.Pending,
          pageKey: pageKey),
    );
    try {
      meiliSearchManager.index(uid: 'doctors');
      var result = await meiliSearchManager.search(key, searchQuery);
      List<DoctorResponse> doctors = List<DoctorResponse>.from(
        result.hits.map(
          (e) => DoctorResponse.fromMap(e),
        ),
      );
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
