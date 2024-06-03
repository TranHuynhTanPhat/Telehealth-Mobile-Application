import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/data/api/models/responses/drug_response.dart';
import 'package:healthline/data/api/models/responses/prescription_response.dart';
import 'package:healthline/repositories/consultation_repository.dart';
import 'package:healthline/res/enum.dart';

part 'prescription_state.dart';

class PrescriptionCubit extends Cubit<PrescriptionState> {
  PrescriptionCubit()
      : super(PrescriptionInitial(blocState: BlocState.Successed));
  final ConsultationRepository _consultationRepository =
      ConsultationRepository();

  Future<void> getInfoDrug({
    required String id,
  }) async {
    emit(
      GetInfoDrugState(
        blocState: BlocState.Pending,
      ),
    );
    try {
      DrugResponse drug = await _consultationRepository.getInfoDrug(id: id);
      emit(
        GetInfoDrugState(blocState: BlocState.Successed, data: drug),
      );
    } catch (error) {
      emit(
        GetInfoDrugState(
          error: error.toString(),
          blocState: BlocState.Failed,
        ),
      );
    }
  }

  Future<void> fetchPrescription({required String consultationId}) async {
    emit(
      FetchPrescriptionState(
        blocState: BlocState.Pending,
      ),
    );
    try {
      PrescriptionResponse pre =
          await _consultationRepository.fetchPrescription(
        consultationId: consultationId,
        isDoctor: AppController().authState == AuthState.DoctorAuthorized,
      );
      emit(
        FetchPrescriptionState(blocState: BlocState.Successed, data: pre),
      );
    } on DioException catch (e) {
      emit(FetchPrescriptionState(
        blocState: BlocState.Failed,
        error: e.response!.data['message'].toString(),
      ));
    } catch (e) {
      emit(FetchPrescriptionState(
        blocState: BlocState.Failed,
      ));
    }
  }

  Future<void> createPrescription(
      {required PrescriptionResponse prescriptionResponse,
      required String consultationId}) async {
    emit(
      CreatePrescriptionState(
        blocState: BlocState.Pending,
      ),
    );
    try {
      await _consultationRepository.createPrescription(
          prescriptionResponse: prescriptionResponse,
          consultationId: consultationId);
      emit(
        CreatePrescriptionState(
          blocState: BlocState.Successed,
        ),
      );
    } on DioException catch (e) {
      emit(
        CreatePrescriptionState(
          blocState: BlocState.Failed,
          error: e.response!.data['message'] ?? e.response,
        ),
      );
    } catch (e) {
      emit(
        CreatePrescriptionState(
          blocState: BlocState.Failed,
        ),
      );
    }
  }

  Future<void> searchDrug(
      {required String key,
      required int pageKey,
      required Function(List<DrugResponse>) callback}) async {
    emit(
      SearchDrugState(
        blocState: BlocState.Pending,
      ),
    );
    try {
      List<DrugResponse> drugs =
          await _consultationRepository.searchDrug(key: key, pageKey: pageKey);
      callback(drugs);
      emit(
        SearchDrugState(
          blocState: BlocState.Successed,
        ),
      );
    } catch (error) {
      emit(
        SearchDrugState(
          error: error.toString(),
          blocState: BlocState.Failed,
        ),
      );
    }
  }
}
